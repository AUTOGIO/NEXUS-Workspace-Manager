#!/usr/bin/env python3
"""
🤖 NEXUS AI Model Discovery Script
AI-Powered Workspace Intelligence for Apple Silicon

Author: Eduardo Giovannini
Version: 0.1.0
License: MIT

This script discovers and catalogs AI models in the LM Studio models directory.
"""

import json
from pathlib import Path
from typing import Dict, List, Optional, Any
from dataclasses import dataclass, asdict
from datetime import datetime
import logging

# Configure logging
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s'
)
logger = logging.getLogger(__name__)


@dataclass
class ModelInfo:
    """Information about a discovered AI model."""
    name: str
    path: str
    category: str
    provider: str
    format: str
    size_mb: Optional[float] = None
    parameters: Optional[str] = None
    quantization: Optional[str] = None
    last_modified: Optional[str] = None
    metadata: Optional[Dict[str, Any]] = None

class ModelDiscovery:
    """Discovers and catalogs AI models in the LM Studio models directory."""
    
    def __init__(self, models_path: str = "/Volumes/MICRO/LM_STUDIO_MODELS"):
        self.models_path = Path(models_path)
        self.discovered_models: List[ModelInfo] = []

        self.model_categories = {
            "lmstudio-community": "LM Studio Community Models",
            "mlx-community": "MLX Community Models",
            "google": "Google Models",
            "ibm": "IBM Models",
            "microsoft": "Microsoft Models",
            "qwen": "Qwen Models",
            "liquid": "Liquid Models"
        }
        
    def discover_models(self) -> List[ModelInfo]:
        """Discover all models in the models directory."""
        logger.info(f"Starting model discovery in: {self.models_path}")
        
        if not self.models_path.exists():
            logger.error(f"Models directory does not exist: {self.models_path}")
            return []
        
        for provider_dir in self.models_path.iterdir():
            if provider_dir.is_dir():
                provider_name = provider_dir.name
                logger.info(f"Scanning provider: {provider_name}")
                
                for model_dir in provider_dir.iterdir():
                    if model_dir.is_dir():
                        model_info = self._analyze_model(model_dir, provider_name)
                        if model_info:
                            self.discovered_models.append(model_info)
                            logger.info(f"Discovered: {model_info.name}")
        
        logger.info(f"Model discovery complete. Found {len(self.discovered_models)} models.")
        return self.discovered_models
    
    def _analyze_model(self, model_dir: Path, provider: str) -> Optional[ModelInfo]:
        """Analyze a single model directory."""
        try:
            model_name = model_dir.name
            model_path = str(model_dir)
            
            # Determine model format and quantization
            format_type, quantization = self._detect_format_and_quantization(model_name)
            
            # Estimate model size
            size_mb = self._estimate_model_size(model_dir)
            
            # Extract parameters from name if possible
            parameters = self._extract_parameters(model_name)
            
            # Get last modified time
            last_modified = datetime.fromtimestamp(model_dir.stat().st_mtime).isoformat()
            
            # Determine category based on provider and model characteristics
            category = self._determine_category(provider, model_name, parameters)
            
            model_info = ModelInfo(
                name=model_name,
                path=model_path,
                category=category,
                provider=provider,
                format=format_type,
                size_mb=size_mb,
                parameters=parameters,
                quantization=quantization,
                last_modified=last_modified,
                metadata=self._extract_metadata(model_dir)
            )
            
            return model_info
            
        except Exception as e:
            logger.warning(f"Error analyzing model {model_dir}: {e}")
            return None
    
    def _detect_format_and_quantization(self, model_name: str) -> tuple[str, Optional[str]]:
        """Detect model format and quantization from name."""
        model_name_lower = model_name.lower()
        
        # Detect format
        if "mlx" in model_name_lower:
            format_type = "MLX"
        elif "gguf" in model_name_lower:
            format_type = "GGUF"
        elif "onnx" in model_name_lower:
            format_type = "ONNX"
        else:
            format_type = "Unknown"
        
        # Detect quantization
        quantization = None
        if "4bit" in model_name_lower:
            quantization = "4-bit"
        elif "8bit" in model_name_lower:
            quantization = "8-bit"
        elif "16bit" in model_name_lower:
            quantization = "16-bit"
        elif "32bit" in model_name_lower:
            quantization = "32-bit"
        
        return format_type, quantization
    
    def _estimate_model_size(self, model_dir: Path) -> Optional[float]:
        """Estimate model size in MB."""
        try:
            total_size = 0
            file_count = 0
            
            for file_path in model_dir.rglob("*"):
                if file_path.is_file():
                    total_size += file_path.stat().st_size
                    file_count += 1
            
            size_mb = total_size / (1024 * 1024)
            return round(size_mb, 2)
            
        except Exception as e:
            logger.warning(f"Error estimating size for {model_dir}: {e}")
            return None
    
    def _extract_parameters(self, model_name: str) -> Optional[str]:
        """Extract parameter count from model name."""
        import re
        
        # Common parameter patterns
        patterns = [
            r'(\d+(?:\.\d+)?)b',  # 7b, 13b, 70b
            r'(\d+(?:\.\d+)?)B',  # 7B, 13B, 70B
            r'(\d+(?:\.\d+)?)m',  # 1.5m, 3m
            r'(\d+(?:\.\d+)?)M',  # 1.5M, 3M
        ]
        
        for pattern in patterns:
            match = re.search(pattern, model_name)
            if match:
                return f"{match.group(1)}B"  # Normalize to B
        
        return None
    
    def _determine_category(self, provider: str, model_name: str, parameters: Optional[str]) -> str:
        """Determine model category based on provider and characteristics."""
        model_name_lower = model_name.lower()
        
        # Provider-specific categories
        if provider == "lmstudio-community":
            if "qwen" in model_name_lower:
                if "14b" in model_name_lower:
                    return "Large Language Model (Research)"
                else:
                    return "Large Language Model (General)"
            elif "phi" in model_name_lower:
                return "Reasoning Model"
            elif "gemma" in model_name_lower:
                return "Instruction Tuned Model"
            elif "lfm" in model_name_lower:
                return "Lightweight Model"
            elif "granite" in model_name_lower:
                return "Business Model"
        
        elif provider == "mlx-community":
            if "embedding" in model_name_lower:
                return "Embedding Model"
            else:
                return "MLX Optimized Model"
        
        elif provider == "google":
            return "Google Model"
        
        elif provider == "ibm":
            return "IBM Business Model"
        
        elif provider == "microsoft":
            return "Microsoft Model"
        
        elif provider == "qwen":
            return "Qwen Model"
        
        elif provider == "liquid":
            return "Liquid Model"
        
        # Fallback based on parameters
        if parameters:
            param_value = float(parameters.replace("B", ""))
            if param_value >= 10:
                return "Large Language Model"
            elif param_value >= 3:
                return "Medium Language Model"
            else:
                return "Small Language Model"
        
        return "Unknown"
    
    def _extract_metadata(self, model_dir: Path) -> Dict[str, Any]:
        """Extract additional metadata from model directory."""
        metadata = {}
        
        # Look for common metadata files
        metadata_files = ["config.json", "model_info.json", "README.md", "LICENSE"]
        
        for file_name in metadata_files:
            file_path = model_dir / file_name
            if file_path.exists():
                try:
                    if file_name.endswith('.json'):
                        with open(file_path, 'r') as f:
                            metadata[file_name] = json.load(f)
                    else:
                        with open(file_path, 'r') as f:
                            metadata[file_name] = f.read()[:500]  # First 500 chars
                except Exception as e:
                    logger.warning(f"Error reading metadata file {file_path}: {e}")
        
        return metadata
    
    def generate_catalog(self) -> Dict[str, Any]:
        """Generate a comprehensive model catalog."""
        catalog = {
            "discovery_info": {
                "timestamp": datetime.now().isoformat(),
                "models_path": str(self.models_path),
                "total_models": len(self.discovered_models),
                "discovery_version": "0.1.0"
            },
            "providers": {},
            "categories": {},
            "models": [asdict(model) for model in self.discovered_models]
        }
        
        # Organize by providers
        for model in self.discovered_models:
            if model.provider not in catalog["providers"]:
                catalog["providers"][model.provider] = {
                    "name": self.model_categories.get(model.provider, model.provider),
                    "model_count": 0,
                    "total_size_mb": 0
                }
            
            catalog["providers"][model.provider]["model_count"] += 1
            if model.size_mb:
                catalog["providers"][model.provider]["total_size_mb"] += model.size_mb
        
        # Organize by categories
        for model in self.discovered_models:
            if model.category not in catalog["categories"]:
                catalog["categories"][model.category] = {
                    "model_count": 0,
                    "total_size_mb": 0,
                    "models": []
                }
            
            catalog["categories"][model.category]["model_count"] += 1
            if model.size_mb:
                catalog["categories"][model.category]["total_size_mb"] += model.size_mb
            
            catalog["categories"][model.category]["models"].append(model.name)
        
        return catalog
    
    def save_catalog(self, output_path: str = "configs/models/model_catalog.json"):
        """Save the model catalog to a JSON file."""
        catalog = self.generate_catalog()
        
        # Ensure output directory exists
        output_file = Path(output_path)
        output_file.parent.mkdir(parents=True, exist_ok=True)
        
        try:
            with open(output_file, 'w') as f:
                json.dump(catalog, f, indent=2, ensure_ascii=False)
            
            logger.info(f"Model catalog saved to: {output_file}")
            return True
            
        except Exception as e:
            logger.error(f"Error saving catalog: {e}")
            return False
    
    def print_summary(self):
        """Print a summary of discovered models."""
        if not self.discovered_models:
            print("No models discovered.")
            return
        
        print(f"\n🤖 NEXUS AI Model Discovery Summary")
        print(f"=====================================")
        print(f"📁 Models Path: {self.models_path}")
        print(f"🔍 Total Models: {len(self.discovered_models)}")
        print(f"⏰ Discovery Time: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")
        
        # Provider summary
        print(f"\n📊 Provider Summary:")
        provider_stats = {}
        for model in self.discovered_models:
            if model.provider not in provider_stats:
                provider_stats[model.provider] = {"count": 0, "size": 0}
            provider_stats[model.provider]["count"] += 1
            if model.size_mb:
                provider_stats[model.provider]["size"] += model.size_mb
        
        for provider, stats in provider_stats.items():
            provider_name = self.model_categories.get(provider, provider)
            print(f"  • {provider_name}: {stats['count']} models ({stats['size']:.1f} MB)")
        
        # Category summary
        print(f"\n🏷️  Category Summary:")
        category_stats = {}
        for model in self.discovered_models:
            if model.category not in category_stats:
                category_stats[model.category] = {"count": 0, "size": 0}
            category_stats[model.category]["count"] += 1
            if model.size_mb:
                category_stats[model.category]["size"] += model.size_mb
        
        for category, stats in sorted(category_stats.items()):
            print(f"  • {category}: {stats['count']} models ({stats['size']:.1f} MB)")
        
        # Top models by size
        print(f"\n📈 Top Models by Size:")
        sorted_models = sorted(
            [m for m in self.discovered_models if m.size_mb],
            key=lambda x: x.size_mb,
            reverse=True
        )[:5]
        
        for i, model in enumerate(sorted_models, 1):
            print(f"  {i}. {model.name} ({model.size_mb:.1f} MB) - {model.category}")

def main():
    """Main function for model discovery."""
    import argparse
    
    parser = argparse.ArgumentParser(description="Discover AI models in LM Studio models directory")
    parser.add_argument("--path", default="/Volumes/MICRO/LM_STUDIO_MODELS", 
                       help="Path to models directory")
    parser.add_argument("--output", default="configs/models/model_catalog.json",
                       help="Output path for model catalog")
    parser.add_argument("--verbose", "-v", action="store_true",
                       help="Enable verbose logging")
    
    args = parser.parse_args()
    
    if args.verbose:
        logging.getLogger().setLevel(logging.DEBUG)
    
    # Create model discovery instance
    discovery = ModelDiscovery(args.path)
    
    # Discover models
    models = discovery.discover_models()
    
    if not models:
        print("❌ No models discovered. Check the models path and try again.")
        return
    
    # Print summary
    discovery.print_summary()
    
    # Save catalog
    if discovery.save_catalog(args.output):
        print(f"\n✅ Model catalog saved to: {args.output}")
    else:
        print(f"\n❌ Failed to save model catalog")

if __name__ == "__main__":
    main()
