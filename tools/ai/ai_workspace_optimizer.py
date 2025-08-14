#!/usr/bin/env python3
"""
AI-Powered Workspace Optimizer for NEXUS
Integrates MLX models to provide intelligent workspace management suggestions
"""

import os
import sys
import json
from pathlib import Path
from typing import Dict, List, Optional
import subprocess

try:
    from mlx_lm import load, generate
    MLX_AVAILABLE = True
except ImportError:
    MLX_AVAILABLE = False
    print("⚠️  MLX-LM not available. Install with: pip install mlx-lm")

class AIWorkspaceOptimizer:
    """AI-powered workspace optimization using MLX models"""
    
    def __init__(self, models_path: str = "/Volumes/MICRO/models"):
        self.models_path = Path(models_path)
        self.available_models = self._discover_models()
        self.current_model = None
        self.current_tokenizer = None
        
    def _discover_models(self) -> Dict[str, Dict]:
        """Discover available MLX models"""
        models = {}
        
        if not self.models_path.exists():
            print(f"⚠️  Models path not found: {self.models_path}")
            return models
            
        for model_dir in self.models_path.iterdir():
            if model_dir.is_dir() and not model_dir.name.startswith('.'):
                config_file = model_dir / "config.json"
                if config_file.exists():
                    try:
                        with open(config_file, 'r') as f:
                            config = json.load(f)
                        
                        models[model_dir.name] = {
                            'path': str(model_dir),
                            'type': config.get('model_type', 'unknown'),
                            'size': self._get_model_size(model_dir),
                            'config': config
                        }
                    except Exception as e:
                        print(f"⚠️  Error reading {config_file}: {e}")
        
        return models
    
    def _get_model_size(self, model_dir: Path) -> str:
        """Get model size in GB"""
        total_size = 0
        for file in model_dir.rglob("*.safetensors"):
            total_size += file.stat().st_size
        
        if total_size > 0:
            size_gb = total_size / (1024**3)
            return f"{size_gb:.1f}GB"
        return "Unknown"
    
    def list_models(self) -> None:
        """List available models"""
        print("🤖 Available MLX Models:")
        print("=" * 60)
        
        for name, info in self.available_models.items():
            print(f"📁 {name}")
            print(f"   Type: {info['type']}")
            print(f"   Size: {info['size']}")
            print(f"   Path: {info['path']}")
            print()
    
    def load_model(self, model_name: str) -> bool:
        """Load a specific model"""
        if model_name not in self.available_models:
            print(f"❌ Model not found: {model_name}")
            return False
        
        try:
            print(f"🔄 Loading model: {model_name}")
            model_path = self.available_models[model_name]['path']
            
            self.current_model, self.current_tokenizer = load(model_path)
            print(f"✅ Model loaded successfully!")
            print(f"   Model type: {type(self.current_model)}")
            print(f"   Tokenizer type: {type(self.current_tokenizer)}")
            return True
            
        except Exception as e:
            print(f"❌ Error loading model: {e}")
            return False
    
    def optimize_workspace(self, prompt: str, max_tokens: int = 200) -> Optional[str]:
        """Generate workspace optimization suggestions"""
        if not self.current_model or not self.current_tokenizer:
            print("❌ No model loaded. Use load_model() first.")
            return None
        
        try:
            print(f"🧠 Generating optimization for: {prompt}")
            
            # Format the prompt for workspace optimization
            formatted_prompt = f"""
            You are an expert workspace optimization specialist. 
            Provide practical, actionable advice for the following request:
            
            {prompt}
            
            Focus on practical steps, ergonomic considerations, and productivity improvements.
            Keep the response concise and actionable.
            """
            
            response = generate(
                self.current_model, 
                self.current_tokenizer, 
                prompt=formatted_prompt.strip(),
                max_tokens=max_tokens,
                verbose=True
            )
            
            return response
            
        except Exception as e:
            print(f"❌ Error generating response: {e}")
            return None
    
    def get_display_info(self) -> Dict:
        """Get current display information"""
        try:
            result = subprocess.run(
                ['system_profiler', 'SPDisplaysDataType', '-json'],
                capture_output=True, text=True
            )
            
            if result.returncode == 0:
                data = json.loads(result.stdout)
                displays = data.get('SPDisplaysDataType', [])
                
                display_info = {
                    'count': len(displays),
                    'displays': []
                }
                
                for display in displays:
                    display_info['displays'].append({
                        'name': display.get('_name', 'Unknown'),
                        'resolution': display.get('spdisplays_resolution', 'Unknown'),
                        'main': display.get('spdisplays_main', False)
                    })
                
                return display_info
            else:
                return {'count': 0, 'displays': [], 'error': 'Failed to get display info'}
                
        except Exception as e:
            return {'count': 0, 'displays': [], 'error': str(e)}
    
    def suggest_workspace_profile(self, current_task: str) -> Optional[str]:
        """Suggest optimal workspace profile based on current task"""
        if not self.current_model or not self.current_tokenizer:
            return None
        
        prompt = f"""
        Based on the current task: "{current_task}"
        
        Suggest the optimal workspace profile from these options:
        1. Work Profile (Development & Productivity)
        2. Personal Profile (Entertainment & Social)
        3. AI Research Profile (AI & ML Development)
        4. Daily Routine (Default Setup)
        5. Content Creation (Video, Design, Writing)
        6. Gaming & Entertainment
        7. Learning & Education
        8. Business & Meetings
        9. Focus & Deep Work
        
        Explain why this profile would be best and what specific optimizations to apply.
        """
        
        return self.optimize_workspace(prompt, max_tokens=150)

def main():
    """Main function for CLI usage"""
    print("🤖 NEXUS AI Workspace Optimizer")
    print("=" * 40)
    
    if not MLX_AVAILABLE:
        print("❌ MLX-LM not available. Please install it first.")
        return
    
    optimizer = AIWorkspaceOptimizer()
    
    # Show available models
    optimizer.list_models()
    
    # Get display info
    display_info = optimizer.get_display_info()
    print(f"🖥️  Current Display Setup: {display_info['count']} displays")
    for display in display_info['displays']:
        print(f"   - {display['name']}: {display['resolution']}")
    print()
    
    # Try to load a recommended model
    recommended_models = [
        "DeepSeek-R1-0528-Qwen3-8B-MLX-4bit",
        "Qwen2.5-0.5B-Instruct-MLX-4bit",
        "Phi-4-mini-reasoning-MLX-4bit"
    ]
    
    model_loaded = False
    for model_name in recommended_models:
        if model_name in optimizer.available_models:
            if optimizer.load_model(model_name):
                model_loaded = True
                break
    
    if not model_loaded:
        print("❌ Could not load any recommended models.")
        return
    
    # Test workspace optimization
    print("\n🧠 Testing AI Workspace Optimization...")
    
    # Test 1: General workspace optimization
    prompt1 = "How can I optimize my 2-display workspace for maximum productivity?"
    response1 = optimizer.optimize_workspace(prompt1)
    
    if response1:
        print(f"\n📝 Response 1: {response1[:200]}...")
    
    # Test 2: Profile suggestion
    prompt2 = "I'm working on AI development and need to manage multiple terminal windows, code editors, and documentation."
    response2 = optimizer.suggest_workspace_profile(prompt2)
    
    if response2:
        print(f"\n📝 Response 2: {response2[:200]}...")
    
    print("\n✅ AI Workspace Optimizer test completed!")

if __name__ == "__main__":
    main()
