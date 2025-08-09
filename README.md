# 🚀 NEXUS - Neural EXperience Unified System

> **AI-Powered Workspace Intelligence for Apple Silicon**

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Python 3.7+](https://img.shields.io/badge/python-3.7+-blue.svg)](https://www.python.org/downloads/)
[![Apple Silicon](https://img.shields.io/badge/Apple%20Silicon-M3%20Optimized-green.svg)](https://developer.apple.com/metal/)
[![YABAI](https://img.shields.io/badge/YABAI-Tiling%20WM-orange.svg)](https://github.com/koekeishiya/yabai)

## 📋 Table of Contents

- [Overview](#-overview)
- [Features](#-features)
- [Architecture](#-architecture)
- [Quick Start](#-quick-start)
- [Installation](#-installation)
- [Configuration](#-configuration)
- [Usage](#-usage)
- [API Reference](#-api-reference)
- [Contributing](#-contributing)
- [License](#-license)

## 🎯 Overview

**NEXUS** is an advanced AI-powered workspace management system designed specifically for Apple Silicon Macs. It combines the power of YABAI tiling window management with intelligent AI integration, real-time analytics, and automated workspace optimization.

### **Key Capabilities**
- 🤖 **AI-Powered Intelligence**: Neural Engine optimized inference
- 🖥️ **Adaptive Multi-Display**: Automatic optimization for 1-3 displays
- 📊 **Real-Time Analytics**: Screen time tracking and productivity monitoring
- ⚡ **Performance Optimization**: Apple Silicon native acceleration
- 🔄 **Automated Workflows**: Smart profile switching and tool management
- 🛡️ **Privacy-First**: Complete local processing, no external dependencies

## ✨ Features

### **Core Workspace Management**
- **Intelligent Profile Switching**: AI-driven workspace optimization
- **Dynamic Layout Management**: Real-time tool swapping across displays
- **Adaptive Multi-Display**: Automatic 1-3 display configuration
- **Performance Monitoring**: Real-time system and application analytics

### **AI Integration**
- **Neural Engine Optimization**: Apple M3 native acceleration
- **Local Model Support**: MLX, GGUF, and Hugging Face models
- **Context-Aware Suggestions**: Intelligent workspace recommendations
- **Real-Time Analysis**: Instant workspace optimization

### **Analytics & Monitoring**
- **Screen Time Tracking**: Application usage analytics
- **Productivity Metrics**: Focus and efficiency monitoring
- **Performance Benchmarking**: System optimization tracking
- **Data Visualization**: Streamlit-powered dashboards

### **Automation & Integration**
- **N8N Workflows**: Advanced automation capabilities
- **Keyboard Maestro**: Enhanced keyboard shortcuts
- **BetterTouchTool**: Gesture-based controls
- **Raycast Integration**: Quick access and search

## 🏗️ Architecture

```
NEXUS/
├── 📁 Core System
│   ├── launcher.sh              # Main entry point
│   ├── configs/                 # Configuration management
│   └── scripts/                 # Core functionality
├── 🤖 AI Integration
│   ├── scripts/ai/              # AI model management
│   └── configs/models/          # Model configurations
├── 📊 Analytics & Monitoring
│   ├── scripts/analytics/       # Data collection
│   └── dashboard/               # Visualization
├── ⚙️ Automation
│   ├── scripts/automation/      # Workflow automation
│   └── configs/integrations/    # Third-party integrations
├── 📚 Documentation
│   ├── docs/user-guides/        # User documentation
│   ├── docs/installation/       # Setup guides
│   └── docs/api/               # Technical documentation
└── 📈 Data & Logs
    ├── logs/                    # System logs
    └── data/                    # Analytics data
```

## 🚀 Quick Start

### **Prerequisites**
- macOS 12.0 (Monterey) or later
- Apple M3 Mac (optimized for M3 iMac)
- YABAI installed and running
- Python 3.7+ with required packages

### **Installation**
```bash
# Clone the repository
git clone https://github.com/yourusername/NEXUS.git
cd NEXUS

# Make scripts executable
chmod +x *.sh scripts/*.sh configs/profiles/*.sh

# Install Python dependencies
pip install -r requirements.txt

# Start YABAI service
yabai --start-service

# Launch NEXUS
./launcher.sh
```

### **First-Time Setup**
```bash
# 1. Navigate to NEXUS directory
cd ~/Desktop/Projects/YABAI

# 2. Make scripts executable
chmod +x *.sh scripts/*.sh configs/profiles/*.sh

# 3. Start YABAI service
yabai --start-service

# 4. Launch NEXUS main interface
./launcher.sh

# 5. Select option 12) System Status Check
# 6. Load a workspace profile (option 1-4)
# 7. Test AI integration (option 7)
# 8. Launch dashboard (option 11)
```

## 📦 Installation

### **System Requirements**
- **Operating System**: macOS 12.0 (Monterey) or later
- **Hardware**: Apple M3 Mac (16GB+ unified memory recommended)
- **Display**: 1-3 displays (automatically adapts to your setup)
- **Storage**: 10GB available space for models and data

### **Dependencies**

#### **Core Dependencies**
```bash
# YABAI (Tiling Window Manager)
brew install yabai

# SKHD (Global Hotkey Daemon)
brew install skhd

# Python 3.7+
brew install python@3.9

# Required Python packages
pip install streamlit psutil pyyaml mlx-lm transformers
```

#### **Optional Dependencies**
```bash
# N8N (Workflow Automation)
npm install -g n8n

# BetterTouchTool (Gesture Controls)
# Download from: https://folivora.ai/bettertouchtool

# Keyboard Maestro (Macro Automation)
# Download from: https://www.keyboardmaestro.com/

# Raycast (Quick Access)
# Download from: https://www.raycast.com/
```

### **Model Collection Setup**
```bash
# Create model directory
mkdir -p /Volumes/MICRO/models

# Download recommended models
# - Qwen2.5-0.5B-Instruct-MLX-4bit (Neural Engine optimized)
# - Meta-Llama-3.1-8B-Instruct-Q6_K (High performance)
# - Phi-4-mini-reasoning-MLX-4bit (Reasoning tasks)
```

## ⚙️ Configuration

### **Main Configuration**
```yaml
# configs/yabai_config.yaml
displays:
  - name: "HZ30GAMER"
    position: "left"
    resolution: "2560x1080"
  - name: "LG ULTRAWIDE"
    position: "center"
    resolution: "3440x1440"
  - name: "iMac"
    position: "right"
    resolution: "4480x2520"

ai_integration:
  model_recommendations:
    work:
      primary: "Meta-Llama-3.1-8B-Instruct-Q6_K"
      coding: "DeepSeek-R1-0528-Qwen3-8B-MLX-4bit"
      reasoning: "Phi-4-mini-reasoning-MLX-4bit"
      quick: "TinyLlama-1.1B-Chat-v1.0-mlx"
    personal:
      primary: "Qwen2.5-0.5B-Instruct-MLX-4bit"
      entertainment: "Gemma-3n-E4B-it-MLX-4bit"
    ai_research:
      primary: "Qwen3-14B-MLX-4bit"
      reasoning: "Phi-4-reasoning-plus-MLX-4bit"
      vision: "Qwen2.5-VL-7B-Instruct-GGUF"

  selection_strategies:
    - memory_based
    - performance_based
    - context_aware
    - auto_optimization

  integration_settings:
    enhanced_ai_script: true
    python_manager: true
    auto_load_models: true
    background_monitoring: true
```

### **Workspace Profiles**
```bash
# Work Profile (Development & Productivity)
./configs/profiles/work_profile.sh

# Personal Profile (Entertainment & Social)
./configs/profiles/personal_profile.sh

# AI Research Profile (AI & ML Development)
./configs/profiles/ai_research_profile.sh

# Daily Routine (Default Setup)
./configs/profiles/daily_routine.sh
```

## 🎯 Usage

### **Daily Workflow**

#### **Morning Setup**
```bash
# 1. Load work profile
./configs/profiles/work_profile.sh

# 2. Enable AI integration
./scripts/ai/enhanced_ai_integration.sh

# 3. Start analytics monitoring
./scripts/analytics/screen_time_collector.sh monitor

# 4. Launch dashboard
cd dashboard && streamlit run workspace_dashboard.py
```

#### **Evening Wind-Down**
```bash
# 1. Switch to personal profile
./configs/profiles/personal_profile.sh

# 2. Review daily analytics
./scripts/analytics/activity_watch_integration.sh report

# 3. Generate productivity summary
python3 scripts/analytics/generate_daily_report.py
```

### **AI Integration**

#### **Neural Engine Optimization**
```python
# Enhanced workspace analysis
from scripts.ai.ai_model_manager import AIModelManager

manager = AIModelManager()
context = manager.get_workspace_context()
optimization = manager.suggest_workspace_optimizations()

print(f"🧠 Workspace Analysis: {optimization['suggestions']}")
print(f"⚡ Processing Time: {optimization['processing_time']:.2f}s")
```

#### **Model Management**
```python
# Intelligent model selection
manager = AIModelManager()
available_memory = manager.get_available_memory()
optimal_models = manager.select_optimal_models(available_memory)

print(f"📊 Selected Models: {optimal_models['work']}")
print(f"🧠 Memory Usage: {optimal_models['memory_usage']}GB")
```

### **Dashboard & Monitoring**

#### **Streamlit Dashboard**
```bash
# Launch main dashboard
cd dashboard && streamlit run workspace_dashboard.py

# Launch dynamic layout dashboard
./launch_dynamic_layout.sh dashboard
```

#### **Analytics Commands**
```bash
# Screen time monitoring
./scripts/analytics/screen_time_collector.sh monitor

# Activity watch integration
./scripts/analytics/activity_watch_integration.sh monitor

# Generate reports
python3 scripts/analytics/generate_reports.py
```

## 📚 API Reference

### **Core Classes**

#### **AIModelManager**
```python
class AIModelManager:
    """Advanced AI model management for workspace optimization"""
    
    def __init__(self):
        """Initialize model manager with workspace context"""
    
    def load_model_collection(self) -> Dict:
        """Scan and load available AI models"""
    
    def get_workspace_context(self) -> WorkspaceContext:
        """Gather real-time workspace context"""
    
    def select_optimal_models(self, context: WorkspaceContext) -> Dict:
        """Select optimal models based on context and memory"""
    
    def suggest_workspace_optimizations(self) -> Dict:
        """Generate AI-powered workspace optimization suggestions"""
```

#### **M3NeuralEngineMLX**
```python
class M3NeuralEngineMLX:
    """Apple M3 Neural Engine optimization using MLX framework"""
    
    def __init__(self, model_path: str = None):
        """Initialize Neural Engine with optional model path"""
    
    def neural_engine_generate(self, prompt: str, max_tokens: int = 150) -> Dict:
        """Generate text using Neural Engine optimized inference"""
    
    def chat_interface(self, enable_continuous: bool = False) -> Dict:
        """Interactive chat session with Neural Engine"""
    
    def benchmark_neural_engine(self, test_prompts: List[str]) -> Dict:
        """Comprehensive performance benchmarking"""
```

### **Configuration Classes**

#### **WorkspaceProfile**
```python
class WorkspaceProfile:
    """Workspace profile configuration and management"""
    
    def __init__(self, profile_name: str):
        """Initialize workspace profile"""
    
    def load_profile(self) -> bool:
        """Load workspace profile configuration"""
    
    def apply_profile(self) -> Dict:
        """Apply profile settings to current workspace"""
    
    def optimize_profile(self, context: Dict) -> Dict:
        """AI-powered profile optimization"""
```

### **Utility Functions**

#### **Display Management**
```python
def detect_displays() -> List[Dict]:
    """Detect and configure multi-display setup"""

def optimize_display_layout(displays: List[Dict]) -> Dict:
    """Optimize display layout for workspace efficiency"""

def swap_tools_across_displays(tool_config: Dict) -> bool:
    """Swap tools across displays based on context"""
```

#### **Analytics Functions**
```python
def collect_screen_time_data() -> Dict:
    """Collect screen time and application usage data"""

def analyze_productivity_patterns(data: Dict) -> Dict:
    """Analyze productivity patterns and trends"""

def generate_optimization_recommendations(analysis: Dict) -> List[str]:
    """Generate workspace optimization recommendations"""
```

## 🤝 Contributing

### **Development Setup**
```bash
# Fork the repository
git clone https://github.com/yourusername/NEXUS.git
cd NEXUS

# Create virtual environment
python3 -m venv venv
source venv/bin/activate

# Install development dependencies
pip install -r requirements-dev.txt

# Run tests
python -m pytest tests/

# Run linting
flake8 scripts/ tests/
```

### **Code Standards**
- **Python**: PEP 8 compliance
- **Shell Scripts**: ShellCheck validation
- **Documentation**: Comprehensive docstrings
- **Testing**: 90%+ code coverage
- **Type Hints**: Full type annotation

### **Pull Request Process**
1. Fork the repository
2. Create feature branch (`git checkout -b feature/amazing-feature`)
3. Commit changes (`git commit -m 'Add amazing feature'`)
4. Push to branch (`git push origin feature/amazing-feature`)
5. Open Pull Request

### **Issue Reporting**
- Use GitHub Issues for bug reports
- Include system information and logs
- Provide reproducible test cases
- Follow the issue template

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

### **Third-Party Licenses**
- **YABAI**: MIT License
- **MLX**: Apache 2.0 License
- **Streamlit**: Apache 2.0 License
- **Transformers**: Apache 2.0 License

## 🙏 Acknowledgments

- **YABAI Team**: Tiling window manager foundation
- **Apple**: Apple Silicon and Neural Engine optimization
- **MLX Team**: Apple Silicon AI framework
- **Open Source Community**: Libraries and tools

## 📞 Support

### **Documentation**
- **User Guide**: `docs/user-guides/USER_GUIDE.md`
- **Installation**: `docs/installation/INSTALLATION.md`
- **Interactive Guide**: `docs/user-guides/INTERACTIVE_GUIDE.md`
- **API Documentation**: `docs/api/`

### **Community**
- **GitHub Issues**: Bug reports and feature requests
- **Discussions**: Community support and questions
- **Wiki**: User-contributed documentation

### **Professional Support**
- **Enterprise**: Custom deployments and support
- **Consulting**: Workspace optimization services
- **Training**: Workshops and training sessions

---

## 🎉 Get Started

**Ready to transform your workspace with AI-powered intelligence?**

```bash
# Quick start
git clone https://github.com/yourusername/NEXUS.git
cd NEXUS
chmod +x *.sh scripts/*.sh configs/profiles/*.sh
./launcher.sh
```

**🚀 NEXUS - Your AI-Powered Workspace Intelligence System**

*Transform your multi-display workflow with intelligent automation!* 🎯

---

**Built with ❤️ for macOS and Apple Silicon** 