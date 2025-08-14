#!/usr/bin/env python3
"""
MLX smoke test for NEXUS - Using available external models
"""

import sys
import os
from pathlib import Path

# Add project root to path
project_root = Path(__file__).parent.parent.parent
sys.path.append(str(project_root))

def test_mlx_basic():
    """Basic MLX functionality test"""
    try:
        import mlx
        # MLX might not have __version__ attribute
        version = getattr(mlx, '__version__', 'unknown')
        print(f"✅ MLX imported: {version}")
    except ImportError as e:
        print(f"❌ MLX import failed: {e}")
        return False
    
    try:
        import mlx_lm
        print("✅ MLX-LM imported successfully")
    except ImportError as e:
        print(f"❌ MLX-LM import failed: {e}")
        return False
    
    return True

def test_mlx_inference():
    """Test basic MLX inference with available model"""
    try:
        from mlx_lm import load, generate
        
        # Use the available TinyLlama model from external drive
        model_path = "/Volumes/MICRO/models/TinyLlama-1.1B-Chat-v1.0-mlx"
        
        if not os.path.exists(model_path):
            print(f"❌ Model not found at: {model_path}")
            return False
        
        print(f"🤖 Loading model from: {model_path}")
        model, tokenizer = load(model_path)
        
        print("🧪 Testing generation...")
        prompt = "Say 'NEXUS OK' in five words."
        response = generate(model, tokenizer, prompt, max_tokens=20, verbose=False)
        
        print(f"✅ Generation successful: {response}")
        return True
        
    except Exception as e:
        print(f"❌ MLX inference failed: {e}")
        return False

def test_model_discovery():
    """Test model discovery from external drive"""
    try:
        external_path = "/Volumes/MICRO/models"
        if not os.path.exists(external_path):
            print(f"❌ External drive not mounted: {external_path}")
            return False
        
        # Count available models
        mlx_models = list(Path(external_path).glob("*MLX*"))
        gguf_models = list(Path(external_path).glob("*.gguf"))
        
        print(f"✅ External drive mounted: {external_path}")
        print(f"📊 MLX models found: {len(mlx_models)}")
        print(f"📊 GGUF models found: {len(gguf_models)}")
        
        return True
        
    except Exception as e:
        print(f"❌ Model discovery failed: {e}")
        return False

def main():
    print("🚀 NEXUS MLX Smoke Test")
    print("=======================")
    
    # Basic import test
    if not test_mlx_basic():
        sys.exit(1)
    
    # Model discovery test
    if not test_model_discovery():
        sys.exit(1)
    
    # Inference test
    if not test_mlx_inference():
        sys.exit(1)
    
    print("✅ All MLX tests passed!")
    print("🎯 NEXUS AI integration ready!")
    print(f"📁 Models available at: /Volumes/MICRO/models")

if __name__ == "__main__":
    main()
