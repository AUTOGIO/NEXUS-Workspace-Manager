#!/usr/bin/env python3
"""
AI Model Manager for YABAI Workspace
Advanced model integration and intelligent workspace optimization
"""

import os
import sys
import json
import yaml
import subprocess
import asyncio
from pathlib import Path
from typing import Dict, List, Any, Optional, Tuple
from dataclasses import dataclass
from datetime import datetime, time
import logging
import psutil
import platform

# Configure logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)


@dataclass
class ModelInfo:
    """Model information and capabilities"""
    name: str
    path: str
    format: str  # MLX, GGUF, HF
    size: str    # small-1B, medium-8B, large-14B+
    purpose: str # chat, reasoning, coding, vision
    memory_required: float
    performance_score: float
    is_available: bool = True


@dataclass
class WorkspaceContext:
    """Current workspace context"""
    time: datetime
    day_of_week: int
    active_apps: List[str]
    current_profile: str
    available_memory: float
    cpu_usage: float
    display_config: Dict[str, Any]


class AIModelManager:
    """
    Advanced AI model manager for YABAI workspace optimization
    """
    
    def __init__(self, model_path: str = "/Volumes/MICRO/models"):
        self.model_path = Path(model_path)
        self.models = {}
        self.workspace_context = None
        self.performance_tracker = {}
        
        # Load model collection
        self.load_model_collection()
        
    def load_model_collection(self):
        """Load and categorize all available models"""
        logger.info("Loading model collection...")
        
        if not self.model_path.exists():
            logger.error(f"Model path not found: {self.model_path}")
            return
        
        # Scan by format
        for format_dir in ["MLX", "GGUF", "HF"]:
            format_path = self.model_path / "by-format" / format_dir
            if format_path.exists():
                self._scan_format_directory(format_path, format_dir)
        
        # Scan by creator
        for creator_dir in ["lmstudio-community", "mlx-community", "standalone"]:
            creator_path = self.model_path / "by-creator" / creator_dir
            if creator_path.exists():
                self._scan_creator_directory(creator_path, creator_dir)
        
        logger.info(f"Loaded {len(self.models)} models")
    
    def _scan_format_directory(self, format_path: Path, format_type: str):
        """Scan format-specific directory for models"""
        for model_dir in format_path.iterdir():
            if model_dir.is_dir():
                model_info = self._analyze_model_directory(model_dir, format_type)
                if model_info:
                    self.models[model_info.name] = model_info
    
    def _scan_creator_directory(self, creator_path: Path, creator_type: str):
        """Scan creator-specific directory for models"""
        for model_dir in creator_path.iterdir():
            if model_dir.is_dir():
                model_info = self._analyze_model_directory(model_dir, creator_type)
                if model_info:
                    self.models[model_info.name] = model_info
    
    def _analyze_model_directory(self, model_dir: Path, source_type: str) -> Optional[ModelInfo]:
        """Analyze a model directory and extract information"""
        try:
            model_name = model_dir.name
            
            # Determine format
            format_type = "GGUF" if source_type == "GGUF" else "MLX"
            if source_type in ["lmstudio-community", "mlx-community", "standalone"]:
                format_type = "MLX" if (model_dir / "model.safetensors").exists() else "GGUF"
            
            # Determine size category
            size_category = self._determine_size_category(model_name)
            
            # Determine purpose
            purpose = self._determine_purpose(model_name)
            
            # Estimate memory requirements
            memory_required = self._estimate_memory_requirements(model_name, size_category)
            
            # Calculate performance score
            performance_score = self._calculate_performance_score(model_name, size_category, purpose)
            
            return ModelInfo(
                name=model_name,
                path=str(model_dir),
                format=format_type,
                size=size_category,
                purpose=purpose,
                memory_required=memory_required,
                performance_score=performance_score
            )
            
        except Exception as e:
            logger.warning(f"Failed to analyze model directory {model_dir}: {e}")
            return None
    
    def _determine_size_category(self, model_name: str) -> str:
        """Determine model size category based on name"""
        if any(size in model_name.lower() for size in ["1b", "1.1b", "1.2b", "0.5b"]):
            return "small-1B"
        elif any(size in model_name.lower() for size in ["14b", "13b", "12b"]):
            return "large-14B+"
        else:
            return "medium-8B"
    
    def _determine_purpose(self, model_name: str) -> str:
        """Determine model purpose based on name"""
        name_lower = model_name.lower()
        
        if any(keyword in name_lower for keyword in ["reasoning", "phi-4", "phi-3"]):
            return "reasoning"
        elif any(keyword in name_lower for keyword in ["vl", "vision", "multimodal"]):
            return "vision"
        elif any(keyword in name_lower for keyword in ["deepseek", "granite", "code"]):
            return "coding"
        elif any(keyword in name_lower for keyword in ["chat", "instruct", "llama", "qwen"]):
            return "chat"
        else:
            return "chat"  # Default to chat
    
    def _estimate_memory_requirements(self, model_name: str, size_category: str) -> float:
        """Estimate memory requirements in GB"""
        base_memory = {
            "small-1B": 2.0,
            "medium-8B": 8.0,
            "large-14B+": 16.0
        }
        
        base = base_memory.get(size_category, 8.0)
        
        # Adjust based on format
        if "MLX" in model_name or "mlx" in model_name.lower():
            base *= 0.8  # MLX is more memory efficient
        elif "4bit" in model_name.lower():
            base *= 0.5  # 4-bit quantization
        elif "8bit" in model_name.lower():
            base *= 0.7  # 8-bit quantization
        
        return base
    
    def _calculate_performance_score(self, model_name: str, size_category: str, purpose: str) -> float:
        """Calculate performance score (0-1) based on model characteristics"""
        score = 0.5  # Base score
        
        # Size-based scoring
        size_scores = {"small-1B": 0.3, "medium-8B": 0.7, "large-14B+": 0.9}
        score += size_scores.get(size_category, 0.5)
        
        # Purpose-based scoring
        purpose_scores = {
            "reasoning": 0.9,
            "vision": 0.8,
            "coding": 0.8,
            "chat": 0.6
        }
        score += purpose_scores.get(purpose, 0.6)
        
        # Format-based scoring
        if "MLX" in model_name or "mlx" in model_name.lower():
            score += 0.1  # MLX is optimized for Apple Silicon
        
        return min(score, 1.0)
    
    def get_workspace_context(self) -> WorkspaceContext:
        """Get current workspace context"""
        now = datetime.now()
        
        # Get active applications
        try:
            result = subprocess.run([
                "osascript", "-e", 
                'tell application "System Events" to get name of every process whose background only is false'
            ], capture_output=True, text=True)
            active_apps = result.stdout.strip().split(", ") if result.returncode == 0 else []
        except:
            active_apps = []
        
        # Determine current profile
        current_profile = self._determine_current_profile(now, active_apps)
        
        # Get system resources
        available_memory = psutil.virtual_memory().available / (1024**3)  # GB
        cpu_usage = psutil.cpu_percent()
        
        # Get display configuration
        display_config = self._get_display_config()
        
        return WorkspaceContext(
            time=now,
            day_of_week=now.weekday() + 1,  # 1=Monday, 7=Sunday
            active_apps=active_apps,
            current_profile=current_profile,
            available_memory=available_memory,
            cpu_usage=cpu_usage,
            display_config=display_config
        )
    
    def _determine_current_profile(self, now: datetime, active_apps: List[str]) -> str:
        """Determine current workspace profile based on time and apps"""
        hour = now.hour
        day = now.weekday() + 1
        
        # Time-based profile
        if day <= 5 and 9 <= hour <= 17:  # Work hours
            base_profile = "work"
        elif hour >= 18 or hour <= 8:  # Evening/Night
            base_profile = "personal"
        else:  # Research hours
            base_profile = "ai_research"
        
        # App-based adjustment
        dev_apps = sum(1 for app in active_apps if any(keyword in app.lower() 
                                                      for keyword in ["cursor", "code", "xcode", "terminal"]))
        comm_apps = sum(1 for app in active_apps if any(keyword in app.lower() 
                                                       for keyword in ["slack", "teams", "whatsapp", "zoom"]))
        ent_apps = sum(1 for app in active_apps if any(keyword in app.lower() 
                                                      for keyword in ["spotify", "netflix", "youtube", "twitch"]))
        
        if dev_apps > max(comm_apps, ent_apps):
            return "work"
        elif ent_apps > max(dev_apps, comm_apps):
            return "personal"
        else:
            return base_profile
    
    def _get_display_config(self) -> Dict[str, Any]:
        """Get current display configuration"""
        try:
            result = subprocess.run(["yabai", "-m", "query", "--displays"], 
                                  capture_output=True, text=True)
            if result.returncode == 0:
                return json.loads(result.stdout)
        except:
            pass
        return {}
    
    def select_optimal_models(self, context: WorkspaceContext) -> Dict[str, ModelInfo]:
        """Select optimal models for current workspace context"""
        available_models = []
        
        for model in self.models.values():
            if model.memory_required <= context.available_memory * 0.8:  # Leave 20% buffer
                available_models.append(model)
        
        # Sort by performance score
        available_models.sort(key=lambda x: x.performance_score, reverse=True)
        
        # Select models based on profile
        selected_models = {}
        
        if context.current_profile == "work":
            # Work profile: coding + reasoning
            coding_models = [m for m in available_models if m.purpose == "coding"]
            reasoning_models = [m for m in available_models if m.purpose == "reasoning"]
            chat_models = [m for m in available_models if m.purpose == "chat"]
            
            if coding_models:
                selected_models["coding"] = coding_models[0]
            if reasoning_models:
                selected_models["reasoning"] = reasoning_models[0]
            if chat_models:
                selected_models["chat"] = chat_models[0]
                
        elif context.current_profile == "personal":
            # Personal profile: chat + creative
            chat_models = [m for m in available_models if m.purpose == "chat"]
            if chat_models:
                selected_models["chat"] = chat_models[0]
                
        elif context.current_profile == "ai_research":
            # AI Research profile: reasoning + vision + large models
            reasoning_models = [m for m in available_models if m.purpose == "reasoning"]
            vision_models = [m for m in available_models if m.purpose == "vision"]
            large_models = [m for m in available_models if m.size == "large-14B+"]
            
            if reasoning_models:
                selected_models["reasoning"] = reasoning_models[0]
            if vision_models:
                selected_models["vision"] = vision_models[0]
            if large_models:
                selected_models["large"] = large_models[0]
        
        return selected_models
    
    def suggest_workspace_optimizations(self, context: WorkspaceContext, selected_models: Dict[str, ModelInfo]) -> List[str]:
        """Generate workspace optimization suggestions"""
        suggestions = []
        
        # Profile-specific suggestions
        if context.current_profile == "work":
            suggestions.extend([
                "💼 Load coding assistant models for development",
                "🔧 Optimize display layout for development tools",
                "📝 Enable code completion and documentation assistance",
                "🎯 Suggest relevant development tools based on current project"
            ])
            
        elif context.current_profile == "personal":
            suggestions.extend([
                "🏠 Load conversation models for social interaction",
                "🎮 Optimize layout for entertainment and social media",
                "✍️ Enable creative writing and content generation",
                "📱 Suggest entertainment and personal productivity tools"
            ])
            
        elif context.current_profile == "ai_research":
            suggestions.extend([
                "🤖 Load large language models for research analysis",
                "👁️ Enable visual analysis for data interpretation",
                "🔬 Optimize for model development and experimentation",
                "📊 Suggest AI/ML tools and frameworks"
            ])
        
        # Model-specific suggestions
        if "coding" in selected_models:
            suggestions.append(f"💻 Use {selected_models['coding'].name} for code assistance")
        if "reasoning" in selected_models:
            suggestions.append(f"🧠 Use {selected_models['reasoning'].name} for complex analysis")
        if "vision" in selected_models:
            suggestions.append(f"👁️ Use {selected_models['vision'].name} for visual workspace analysis")
        
        # Performance suggestions
        if context.cpu_usage > 80:
            suggestions.append("⚠️ High CPU usage detected - consider lighter models")
        if context.available_memory < 4:
            suggestions.append("⚠️ Low memory available - using lightweight models")
        
        return suggestions
    
    def generate_model_loading_script(self, selected_models: Dict[str, ModelInfo]) -> str:
        """Generate script to load selected models"""
        script_lines = ["#!/bin/zsh", "", "# Auto-generated model loading script", ""]
        
        for purpose, model in selected_models.items():
            if model.format == "MLX":
                script_lines.extend([
                    f"# Load {model.name} for {purpose}",
                    f"echo 'Loading {model.name}...'",
                    f"# Add MLX loading commands here",
                    ""
                ])
            elif model.format == "GGUF":
                script_lines.extend([
                    f"# Load {model.name} for {purpose}",
                    f"echo 'Loading {model.name}...'",
                    f"# Add GGUF loading commands here",
                    ""
                ])
        
        return "\n".join(script_lines)
    
    def get_model_statistics(self) -> Dict[str, Any]:
        """Get comprehensive model statistics"""
        stats = {
            "total_models": len(self.models),
            "by_format": {},
            "by_size": {},
            "by_purpose": {},
            "available_memory": psutil.virtual_memory().available / (1024**3),
            "total_memory": psutil.virtual_memory().total / (1024**3)
        }
        
        # Count by format
        for model in self.models.values():
            stats["by_format"][model.format] = stats["by_format"].get(model.format, 0) + 1
            stats["by_size"][model.size] = stats["by_size"].get(model.size, 0) + 1
            stats["by_purpose"][model.purpose] = stats["by_purpose"].get(model.purpose, 0) + 1
        
        return stats


def main():
    """Main function for testing and demonstration"""
    manager = AIModelManager()
    
    # Get workspace context
    context = manager.get_workspace_context()
    
    print("🤖 AI Model Manager for YABAI Workspace")
    print("=" * 50)
    
    # Display context
    print(f"📊 Current Context:")
    print(f"  - Time: {context.time.strftime('%H:%M')}")
    print(f"  - Day: {context.day_of_week}")
    print(f"  - Profile: {context.current_profile}")
    print(f"  - Available Memory: {context.available_memory:.1f}GB")
    print(f"  - CPU Usage: {context.cpu_usage:.1f}%")
    print(f"  - Active Apps: {len(context.active_apps)}")
    
    # Select optimal models
    selected_models = manager.select_optimal_models(context)
    
    print(f"\n🎯 Selected Models:")
    for purpose, model in selected_models.items():
        print(f"  - {purpose}: {model.name} ({model.format}, {model.size})")
    
    # Generate suggestions
    suggestions = manager.suggest_workspace_optimizations(context, selected_models)
    
    print(f"\n💡 Workspace Suggestions:")
    for suggestion in suggestions:
        print(f"  {suggestion}")
    
    # Display statistics
    stats = manager.get_model_statistics()
    print(f"\n📈 Model Statistics:")
    print(f"  - Total Models: {stats['total_models']}")
    print(f"  - By Format: {stats['by_format']}")
    print(f"  - By Size: {stats['by_size']}")
    print(f"  - By Purpose: {stats['by_purpose']}")


if __name__ == "__main__":
    main()
