#!/usr/bin/env python3
"""Unit tests for AIModelManager with real model discovery"""

import pytest
import tempfile
import shutil
from pathlib import Path
from unittest.mock import patch, MagicMock
import sys
import os

# Add project root to path
project_root = Path(__file__).parent.parent.parent
sys.path.append(str(project_root))

from src.nexus.core.ai_model_manager import AIModelManager, ModelInfo, WorkspaceContext


class TestAIModelManager:
    """Test AIModelManager functionality with real models"""
    
    @pytest.fixture(scope="class")
    def real_model_path(self):
        """Use real external model path if available"""
        real_path = "/Volumes/MICRO/models"
        if os.path.exists(real_path):
            return real_path
        else:
            # Fallback to temp directory for testing
            temp_dir = tempfile.mkdtemp()
            yield temp_dir
            shutil.rmtree(temp_dir)
    
    @pytest.fixture
    def manager(self, real_model_path):
        """Create AIModelManager with real or mock models"""
        with patch('src.nexus.ai.ai_model_manager.httpx.get') as mock_get:
            mock_get.return_value.status_code = 200
            manager = AIModelManager(real_model_path)
            return manager
    
    def test_init_with_real_models(self, real_model_path):
        """Test initialization with real external models"""
        if os.path.exists(real_model_path):
            manager = AIModelManager(real_model_path)
            assert isinstance(manager.models, dict)
            print(f"✅ Real models loaded: {len(manager.models)}")
        else:
            pytest.skip("External models not available")
    
    def test_model_discovery_real_path(self, real_model_path):
        """Test model discovery from real external drive"""
        if not os.path.exists(real_model_path):
            pytest.skip("External models not available")
        
        # Check if models exist
        mlx_models = list(Path(real_model_path).glob("*MLX*"))
        gguf_models = list(Path(real_model_path).glob("*.gguf"))
        
        assert len(mlx_models) > 0 or len(gguf_models) > 0, "No models found"
        print(f"📊 MLX models: {len(mlx_models)}, GGUF models: {len(gguf_models)}")
    
    def test_tinyllama_model_availability(self, real_model_path):
        """Test if TinyLlama model is available for testing"""
        if not os.path.exists(real_model_path):
            pytest.skip("External models not available")
        
        tinyllama_path = Path(real_model_path) / "TinyLlama-1.1B-Chat-v1.0-mlx"
        if tinyllama_path.exists():
            print(f"✅ TinyLlama model available: {tinyllama_path}")
            assert tinyllama_path.exists()
        else:
            pytest.skip("TinyLlama model not found")
    
    def test_mlx_inference_with_real_model(self, real_model_path):
        """Test MLX inference with real TinyLlama model"""
        if not os.path.exists(real_model_path):
            pytest.skip("External models not available")
        
        tinyllama_path = Path(real_model_path) / "TinyLlama-1.1B-Chat-v1.0-mlx"
        if not tinyllama_path.exists():
            pytest.skip("TinyLlama model not found")
        
        try:
            from mlx_lm import load, generate
            
            print(f"🤖 Loading real model: {tinyllama_path}")
            model, tokenizer = load(str(tinyllama_path))
            
            print("🧪 Testing real inference...")
            prompt = "Say 'NEXUS OK' in five words."
            response = generate(model, tokenizer, prompt, max_tokens=20, verbose=False)
            
            print(f"✅ Real inference successful: {response}")
            assert len(response) > 0
            
        except Exception as e:
            pytest.fail(f"Real MLX inference failed: {e}")
    
    def test_workspace_context_generation(self, manager):
        """Test workspace context generation"""
        context = manager.get_workspace_context()
        assert isinstance(context, WorkspaceContext)
        assert context.time is not None
        assert context.current_profile is not None
        print(f"✅ Workspace context: {context.current_profile}")
    
    def test_memory_management(self, manager):
        """Test memory management and model selection"""
        available_memory = manager._get_available_memory()
        assert isinstance(available_memory, float)
        assert available_memory > 0
        print(f"💾 Available memory: {available_memory:.2f}GB")
    
    def test_fallback_mechanisms(self, manager):
        """Test fallback mechanisms when MLX fails"""
        # Mock MLX failure
        with patch.object(manager, '_check_lm_studio', return_value=True):
            with patch.object(manager, '_check_ollama', return_value=True):
                # Should have fallback models
                fallback_models = [m for m in manager.models.values() if 'fallback' in m.name]
                assert len(fallback_models) > 0
                print(f"✅ Fallback models available: {len(fallback_models)}")


if __name__ == "__main__":
    pytest.main([__file__, "-v"])
