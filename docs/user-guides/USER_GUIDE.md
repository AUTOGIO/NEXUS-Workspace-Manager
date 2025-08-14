# 🚀 NEXUS User Guide

> **AI-Powered Workspace Intelligence for Apple Silicon**

**Version:** 0.1.0  
**Author:** Eduardo Giovannini  
**Last Updated:** December 2024  
**License:** MIT

---

## 📋 Table of Contents

1. [Getting Started](#getting-started)
2. [System Requirements](#system-requirements)
3. [Installation](#installation)
4. [First Launch](#first-launch)
5. [Workspace Profiles](#workspace-profiles)
6. [AI Integration](#ai-integration)
7. [YABAI Integration](#yabai-integration)
8. [Dashboard & Monitoring](#dashboard--monitoring)
9. [Customization](#customization)
10. [Troubleshooting](#troubleshooting)
11. [Advanced Features](#advanced-features)
12. [Support & Community](#support--community)

---

## 🚀 Getting Started

### What is NEXUS?

**NEXUS** (Neural EXperience Unified System) is an AI-powered workspace intelligence system designed specifically for Apple Silicon Macs. It combines the power of YABAI tiling window management with intelligent AI integration, real-time analytics, and automated workspace optimization.

### Key Features

- 🤖 **AI-Powered Intelligence**: Neural Engine optimized inference
- 🖥️ **Adaptive Multi-Display**: Automatic optimization for 1-3 displays
- 📊 **Real-Time Analytics**: Screen time tracking and productivity monitoring
- ⚡ **Performance Optimization**: Apple Silicon native acceleration
- 🔄 **Automated Workflows**: Smart profile switching and tool management
- 🛡️ **Privacy-First**: Complete local processing, no external dependencies

---

## 💻 System Requirements

### Minimum Requirements

- **Operating System**: macOS 12.0 (Monterey) or later
- **Hardware**: Apple M1 Mac or later (optimized for M3)
- **Memory**: 8GB unified memory (16GB+ recommended)
- **Storage**: 10GB available space for models and data
- **Display**: 1-3 displays (automatically adapts to your setup)

### Recommended Setup

- **Operating System**: macOS 14.0 (Sonoma) or later
- **Hardware**: Apple M3 Mac with 16GB+ unified memory
- **Memory**: 16GB+ unified memory
- **Storage**: 20GB+ available space
- **Display**: 2-3 displays for optimal workspace management

### Required Software

- **YABAI**: Tiling window manager
- **SKHD**: Global hotkey daemon
- **Python**: 3.11+ with uv package manager
- **Homebrew**: For package installation

---

## 📦 Installation

### Step 1: Install Prerequisites

```bash
# Install Homebrew (if not already installed)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install YABAI and SKHD
brew install yabai skhd

# Install Python 3.11+
brew install python@3.11

# Install uv package manager
curl -LsSf https://astral.sh/uv/install.sh | sh
```

### Step 2: Clone NEXUS

```bash
# Clone the repository
git clone https://github.com/eduardogiovannini/nexus-workspace.git

# Navigate to project directory
cd nexus-workspace
```

### Step 3: Setup Environment

```bash
# Create virtual environment
uv venv --python 3.11

# Activate virtual environment
source .venv/bin/activate

# Install dependencies
uv pip install -e .

# Make launcher executable
chmod +x scripts/setup/launcher.sh
```

### Step 4: Configure YABAI

```bash
# Start YABAI service
yabai --start-service

# Start SKHD service
skhd --start-service

# Verify services are running
yabai -m query --spaces
```

---

## 🎯 First Launch

### Launch NEXUS

```bash
# Launch NEXUS main interface
./scripts/setup/launcher.sh

# Or launch with specific profile
./scripts/setup/launcher.sh work_profile
```

### First-Time Setup

1. **System Check**: Run system status check to verify all components
2. **Profile Selection**: Choose your primary workspace profile
3. **AI Model Setup**: Configure AI model preferences
4. **Display Configuration**: Set up multi-display layout
5. **Customization**: Adjust settings to your preferences

### Quick Start Commands

```bash
# Check system status
./scripts/setup/launcher.sh status

# Launch dashboard
./scripts/setup/launcher.sh dashboard

# Load specific profile
./scripts/setup/launcher.sh ai_research_profile
```

---

## 🎨 Workspace Profiles

### Available Profiles

NEXUS comes with 12 pre-configured workspace profiles designed for different use cases:

#### **Productivity Profiles**
- **Work Profile**: Development tools, IDEs, communication apps
- **Business Profile**: Business applications, analytics, meetings
- **Focus Profile**: Distraction-free deep work environment

#### **Creative Profiles**
- **Content Creation Profile**: Video editing, design, writing tools
- **AI Development Profile**: AI/ML development environment
- **AI Research Profile**: Research tools, AI models, analysis

#### **Personal Profiles**
- **Personal Profile**: Social media, entertainment, personal apps
- **Gaming Profile**: Gaming environment, streaming tools
- **Learning Profile**: Educational tools, documentation, tutorials

#### **AI-Specific Profiles**
- **AI Business Profile**: AI-powered business optimization
- **AI Gaming Profile**: AI-enhanced gaming experience
- **AI Learning Profile**: AI-assisted learning environment

### Profile Management

#### **Loading Profiles**
```bash
# Load profile from launcher
./scripts/setup/launcher.sh work_profile

# Load profile programmatically
source configs/profiles/work_profile.sh
```

#### **Customizing Profiles**
```bash
# Copy existing profile
cp configs/profiles/work_profile.sh configs/profiles/my_custom_profile.sh

# Edit profile configuration
nano configs/profiles/my_custom_profile.sh
```

#### **Profile Switching**
- **Automatic**: Context-aware automatic switching
- **Manual**: Manual profile selection
- **Scheduled**: Time-based profile switching
- **AI-Powered**: Intelligent profile optimization

---

## 🤖 AI Integration

### AI Model Management

NEXUS automatically discovers and manages AI models from your LM Studio directory:

#### **Model Discovery**
```bash
# Discover all available models
python tools/ai/discover_models.py

# Discover with custom path
python tools/ai/discover_models.py --path /custom/models/path

# Save catalog to custom location
python tools/ai/discover_models.py --output custom_catalog.json
```

#### **Model Configuration**

Models are automatically categorized and optimized:

- **High Performance**: Large models for complex tasks (8GB+ memory)
- **Balanced**: Medium models for general use (4-8GB memory)
- **Lightweight**: Small models for quick tasks (2-4GB memory)

#### **Workspace-Specific Models**

Each workspace profile automatically selects optimal models:

- **Work Profile**: Coding and analysis models
- **AI Research**: Research and reasoning models
- **Content Creation**: Creative and language models
- **Personal**: Entertainment and conversation models

### AI Features

#### **Intelligent Workspace Optimization**
- **Context Awareness**: AI analyzes current workspace context
- **Performance Optimization**: Automatic model selection based on available resources
- **Predictive Loading**: Pre-loads models based on usage patterns
- **Fallback Systems**: Robust error handling and model switching

#### **AI-Powered Suggestions**
- **Workspace Layout**: Suggests optimal window arrangements
- **Tool Selection**: Recommends tools based on current task
- **Performance Tips**: Provides optimization suggestions
- **Learning Insights**: Analyzes productivity patterns

---

## 🖥️ YABAI Integration

### YABAI Automation Bridge

NEXUS includes an advanced automation bridge that enhances YABAI functionality:

#### **Shell Scripts**

Command-line access to YABAI features:

```bash
# Window focus navigation
yabai-focus-north      # Focus window above
yabai-focus-south      # Focus window below
yabai-focus-east       # Focus window to the right
yabai-focus-west       # Focus window to the left

# Space management
yabai-switch-space 2   # Switch to space 2

# Window control
yabai-toggle-float     # Toggle window float state
```

#### **Gesture Support**

BetterTouchTool integration for touch gestures:

- **Swipe Up**: Focus window north
- **Swipe Down**: Focus window south
- **Swipe Left**: Focus window west
- **Swipe Right**: Focus window east
- **Pinch In**: Toggle window float
- **Pinch Out**: Maximize window

#### **Keyboard Shortcuts**

Keyboard Maestro integration for hotkeys:

- **Cmd+Shift+K**: Focus window north
- **Cmd+Shift+J**: Focus window south
- **Cmd+Shift+H**: Focus window west
- **Cmd+Shift+L**: Focus window east
- **Cmd+Shift+F**: Toggle window float
- **Ctrl+Number**: Switch to specific space

### YABAI Configuration

#### **Automatic Configuration**
NEXUS automatically configures YABAI for optimal performance:

```yaml
# configs/yabai_config.yaml
displays:
  - name: "HZ30GAMER"
    width: 3440
    height: 1440
    layout: "bsp"
  - name: "LG ULTRAWIDE"
    width: 1920
    height: 1080
    layout: "bsp"
```

#### **Custom Rules**
Add custom YABAI rules for specific applications:

```bash
# Add custom rules
echo 'yabai -m rule --add app="^Terminal$" manage=off' >> ~/.yabai
echo 'yabai -m rule --add app="^Finder$" manage=off' >> ~/.yabai

# Restart YABAI to apply rules
yabai --restart-service
```

---

## 📊 Dashboard & Monitoring

### Streamlit Dashboard

NEXUS includes a comprehensive Streamlit dashboard for monitoring and control:

#### **Launching Dashboard**
```bash
# Launch from launcher
./scripts/setup/launcher.sh dashboard

# Launch directly
cd dashboard && streamlit run interactive_guide.py
```

#### **Dashboard Features**
- **System Status**: Real-time system monitoring
- **Workspace Analytics**: Productivity and usage patterns
- **AI Model Status**: Model performance and usage
- **Performance Metrics**: CPU, memory, and GPU usage
- **Configuration**: Easy access to system settings

### Performance Monitoring

#### **Real-Time Metrics**
- **System Resources**: CPU, memory, GPU usage
- **Application Performance**: App-specific metrics
- **Network Usage**: Network activity monitoring
- **Storage Performance**: Disk I/O and space usage

#### **Productivity Analytics**
- **Screen Time**: Application usage tracking
- **Focus Metrics**: Deep work session analysis
- **Workspace Efficiency**: Productivity optimization insights
- **Trend Analysis**: Long-term performance trends

---

## ⚙️ Customization

### Environment Configuration

Customize NEXUS behavior through environment variables:

#### **Basic Configuration**
```bash
# Copy example configuration
cp configs/environments/nexus.env.example .env.local

# Edit configuration
nano .env.local
```

#### **Key Settings**
```bash
# AI Configuration
NEXUS_AI_ENABLED="true"
NEXUS_AUTO_OPTIMIZE="true"
NEXUS_MODEL_AUTO_LOAD="true"

# Performance Settings
NEXUS_MAX_MEMORY_USAGE="80"
NEXUS_CPU_THREAD_LIMIT="8"
NEXUS_NEURAL_ENGINE_ENABLED="true"

# Notification Settings
NEXUS_NOTIFICATIONS_ENABLED="true"
NEXUS_NOTIFY_PROFILE_SWITCH="true"
```

### Profile Customization

#### **Creating Custom Profiles**
```bash
# Create new profile
cp configs/profiles/work_profile.sh configs/profiles/custom_profile.sh

# Edit profile
nano configs/profiles/custom_profile.sh
```

#### **Profile Structure**
```bash
#!/bin/bash
# Profile: Custom Profile
# Description: My custom workspace configuration

# Application launchers
launch_apps() {
    # Launch your custom applications
    open -a "Your App"
}

# Workspace configuration
configure_workspace() {
    # Configure workspace settings
    yabai -m space --layout bsp
}

# Execute profile
launch_apps
configure_workspace
```

### Integration Customization

#### **BetterTouchTool Gestures**
Customize touch gestures in BetterTouchTool:

```json
{
  "gestures": [
    {
      "name": "Focus North",
      "trigger": "swipe_up",
      "action": "run_script",
      "script": "~/bin/yabai-focus-north"
    }
  ]
}
```

#### **Keyboard Maestro Macros**
Create custom keyboard shortcuts:

```json
{
  "macros": [
    {
      "name": "Focus North",
      "hotkey": "cmd+shift+k",
      "action": "run_script",
      "script": "~/bin/yabai-focus-north"
    }
  ]
}
```

---

## 🔧 Troubleshooting

### Common Issues

#### **YABAI Not Working**
```bash
# Check YABAI status
yabai -m query --spaces

# Restart YABAI service
yabai --restart-service

# Check YABAI logs
tail -f /var/log/yabai.log
```

#### **AI Models Not Loading**
```bash
# Check model path
ls -la /Volumes/MICRO/LM_STUDIO_MODELS

# Run model discovery
python tools/ai/discover_models.py

# Check model configuration
cat configs/models/model_config.yaml
```

#### **Performance Issues**
```bash
# Check system resources
./scripts/setup/launcher.sh status

# Monitor performance
cd dashboard && streamlit run interactive_guide.py

# Check logs
tail -f logs/nexus.log
```

### Debug Mode

Enable debug mode for detailed troubleshooting:

```bash
# Set debug environment variable
export NEXUS_DEBUG_ENABLED="true"

# Run with verbose logging
./scripts/setup/launcher.sh --verbose
```

### Getting Help

#### **Self-Service Resources**
- **Documentation**: Comprehensive guides and references
- **Troubleshooting**: Common issues and solutions
- **FAQ**: Frequently asked questions
- **Video Tutorials**: Step-by-step video guides

#### **Community Support**
- **GitHub Issues**: Bug reports and feature requests
- **Discussions**: Community support and questions
- **Wiki**: User-contributed documentation
- **Discord**: Real-time community chat

---

## 🚀 Advanced Features

### Automation Workflows

#### **N8N Integration**
Automate complex workflows with N8N:

```bash
# Start N8N service
make n8n-start

# Access N8N dashboard
open http://localhost:5679
```

#### **Custom Workflows**
Create custom automation workflows:

```json
{
  "workflow": {
    "name": "Morning Routine",
    "triggers": ["time", "8:00 AM"],
    "actions": [
      "load_work_profile",
      "start_analytics",
      "launch_dashboard"
    ]
  }
}
```

### Advanced AI Features

#### **Model Fine-tuning**
Customize AI models for your specific use case:

```python
from nexus.core.ai_model_manager import AIModelManager

# Initialize manager
manager = AIModelManager()

# Fine-tune model
manager.fine_tune_model(
    base_model="lmstudio-community/Qwen3-4B-Instruct-2507-MLX-4bit",
    training_data="your_training_data.json",
    output_path="custom_model"
)
```

#### **Custom Inference Pipelines**
Create custom AI inference pipelines:

```python
# Custom inference pipeline
pipeline = manager.create_pipeline([
    "text_preprocessing",
    "model_inference",
    "post_processing",
    "output_formatting"
])

# Execute pipeline
result = pipeline.execute("Your input text")
```

### Performance Optimization

#### **Memory Management**
Optimize memory usage for large models:

```bash
# Set memory limits
export NEXUS_MODEL_MEMORY_LIMIT="6GB"
export NEXUS_MAX_MEMORY_USAGE="75"

# Enable memory optimization
export NEXUS_MEMORY_OPTIMIZATION="true"
```

#### **GPU Acceleration**
Enable GPU acceleration for better performance:

```bash
# Enable Neural Engine
export NEXUS_NEURAL_ENGINE_ENABLED="true"

# Enable GPU acceleration
export NEXUS_GPU_ACCELERATION="true"

# Set GPU memory limit
export NEXUS_GPU_MEMORY_LIMIT="4GB"
```

---

## 📞 Support & Community

### Getting Help

#### **Documentation Resources**
- **User Guide**: This comprehensive guide
- **API Reference**: Technical API documentation
- **Configuration Guide**: System configuration reference
- **Troubleshooting**: Common issues and solutions

#### **Community Resources**
- **GitHub Repository**: [github.com/eduardogiovannini/nexus-workspace](https://github.com/eduardogiovannini/nexus-workspace)
- **Issues**: [GitHub Issues](https://github.com/eduardogiovannini/nexus-workspace/issues)
- **Discussions**: [GitHub Discussions](https://github.com/eduardogiovannini/nexus-workspace/discussions)
- **Wiki**: [Project Wiki](https://github.com/eduardogiovannini/nexus-workspace/wiki)

### Contributing

#### **How to Contribute**
1. **Fork the Repository**: Create your own fork
2. **Create Feature Branch**: Work on new features
3. **Make Changes**: Implement your improvements
4. **Test Thoroughly**: Ensure quality and functionality
5. **Submit Pull Request**: Share your contributions

#### **Contribution Areas**
- **Documentation**: Improve guides and references
- **Features**: Add new functionality
- **Bug Fixes**: Fix reported issues
- **Testing**: Improve test coverage
- **Localization**: Add language support

### Professional Support

#### **Enterprise Support**
- **Custom Deployments**: Tailored enterprise solutions
- **Training & Workshops**: Team training and workshops
- **Consulting Services**: Expert consultation and optimization
- **Priority Support**: Dedicated support channels

#### **Contact Information**
- **Email**: eduardo@giovannini.dev
- **GitHub**: [@eduardogiovannini](https://github.com/eduardogiovannini)
- **Website**: [giovannini.dev](https://giovannini.dev)

---

## 📚 Additional Resources

### Learning Resources
- **Video Tutorials**: Step-by-step video guides
- **Interactive Examples**: Hands-on learning exercises
- **Best Practices**: Recommended usage patterns
- **Case Studies**: Real-world implementation examples

### Reference Materials
- **Command Reference**: Complete command listing
- **Configuration Reference**: All configuration options
- **API Reference**: Complete API documentation
- **Changelog**: Version history and updates

### Community Projects
- **Extensions**: Community-created extensions
- **Themes**: Custom visual themes
- **Workflows**: Shared automation workflows
- **Templates**: Workspace profile templates

---

## 🎉 Conclusion

Congratulations! You're now ready to use NEXUS, the AI-powered workspace intelligence system for Apple Silicon.

### Quick Reference

```bash
# Essential Commands
./scripts/setup/launcher.sh          # Main launcher
./scripts/setup/launcher.sh status   # System status
./scripts/setup/launcher.sh dashboard # Launch dashboard

# Profile Management
./scripts/setup/launcher.sh work_profile      # Load work profile
./scripts/setup/launcher.sh ai_research_profile # Load AI research profile

# AI Model Management
python tools/ai/discover_models.py   # Discover models
make mlx-test                        # Test MLX integration

# YABAI Integration
yabai-focus-north                    # Focus window north
yabai-switch-space 2                 # Switch to space 2
```

### Next Steps

1. **Explore Profiles**: Try different workspace profiles
2. **Customize Settings**: Adjust configuration to your preferences
3. **Discover AI Models**: Explore your AI model collection
4. **Join Community**: Connect with other NEXUS users
5. **Contribute**: Share your improvements and ideas

### Stay Updated

- **Watch Repository**: Get notified of updates
- **Join Discussions**: Participate in community conversations
- **Follow Updates**: Stay informed about new features
- **Share Feedback**: Help improve NEXUS

---

**Thank you for choosing NEXUS! We're excited to see how you'll transform your workspace with AI-powered intelligence.** 🚀✨

---

*This guide is part of the NEXUS documentation suite. For the latest updates and additional resources, visit our [GitHub repository](https://github.com/eduardogiovannini/nexus-workspace).* 