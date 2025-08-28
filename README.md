# 🚀 NEXUS - AI-Powered Workspace Intelligence

> **The Ultimate AI-Powered Workspace Management System for Apple Silicon**

[![Project Status](https://img.shields.io/badge/status-Production%20Ready-brightgreen)](https://github.com/yourusername/nexus)
[![macOS](https://img.shields.io/badge/macOS-12.0+-blue)](https://www.apple.com/macos/)
[![Python](https://img.shields.io/badge/Python-3.11+-yellow)](https://www.python.org/)
[![Apple Silicon](https://img.shields.io/badge/Apple%20Silicon-M1%2FM2%2FM3-orange)](https://www.apple.com/mac/)

## 🌟 **What's New in NEXUS Enhanced**

🚀 **Just Released: NEXUS Enhanced Automations v1.0.0**

- **15 Enhanced BetterTouchTool Gestures** for intuitive workspace control
- **18 Keyboard Maestro Macros** for keyboard-based automation
- **16 Apple Shortcuts** for native macOS integration
- **8 Shell Script Shortcuts** for command-line access
- **AI-Powered Workspace Optimization** with 90%+ confidence
- **Context-Aware Profile Selection** for automatic workspace adaptation
- **Intelligent Auto-Scheduling** based on time and activity
- **Real-Time Performance Monitoring** and optimization

## 🎯 **Overview**

NEXUS is a revolutionary AI-powered workspace management system designed specifically for Apple Silicon Macs. It combines the power of YABAI tiling window management with cutting-edge AI intelligence to create the most productive workspace experience possible.

### ✨ **Key Features**

- **🧠 AI-Powered Intelligence**: Context-aware workspace optimization
- **🎨 Gesture Control**: 15 intuitive BetterTouchTool gestures
- **⌨️ Keyboard Automation**: 18 powerful Keyboard Maestro macros
- **📱 Native Integration**: 16 Apple Shortcuts for seamless workflow
- **🖥️ Smart Window Management**: YABAI integration with AI optimization
- **🔄 Auto-Scheduling**: Intelligent workspace adaptation
- **📊 Performance Monitoring**: Real-time system health tracking
- **🎯 Multi-Profile Support**: 12 specialized workspace profiles

## 🚀 **Quick Start**

### Prerequisites

- macOS 12.0+ (Sequoia/Tahoe recommended)
- Apple Silicon Mac (M1/M2/M3) for optimal performance
- Python 3.11+ with `uv` package manager

### Installation

```bash
# Clone the repository
git clone https://github.com/yourusername/nexus.git
cd nexus

# Run the enhanced automations installer
chmod +x scripts/setup/install_enhanced_automations.sh
./scripts/setup/install_enhanced_automations.sh
```

### First Launch

```bash
# Launch the interactive menu
nexus-quick-menu

# Or use AI-powered optimization
nexus-ai-optimize

# Analyze your workspace
nexus status

# Switch profiles
nexus-profile-switcher --list
```

## 🖥️ **Command Line Interface (CLI)**

NEXUS provides a powerful command-line interface for advanced users:

### **Main Commands**
```bash
nexus --help                    # Show all available commands
nexus status                    # Check system status
nexus version                   # Show version information
nexus profile list             # List available profiles
nexus profile switch <name>    # Switch to a profile
nexus layout save <name>       # Save current layout
nexus layout restore <name>    # Restore saved layout
nexus optimize --ai            # AI-powered optimization
```

### **AI Optimization Commands**
```bash
nexus-ai-optimize              # Optimize workspace
nexus-ai-optimize --profile <name>  # Target specific profile
nexus-ai-optimize --list-models     # Show available AI models
nexus-ai-optimize --verbose         # Detailed output
```

### **Profile Management Commands**
```bash
nexus-profile-switcher --list           # List all profiles
nexus-profile-switcher --switch <name>  # Switch to profile
nexus-profile-switcher --info <name>    # Profile details
nexus-profile-switcher --force          # Force switch
```

### **Interactive Menu System**
```bash
nexus-quick-menu               # Launch interactive menu
nexus-quick-menu --action status  # Execute specific action
nexus-quick-menu --no-interactive # Non-interactive mode
```

## 🎨 **Enhanced Automation Features**

### 🎯 **BetterTouchTool Gestures**

Transform your workspace with intuitive gestures:

- **3-finger swipe up + hold**: NEXUS Profile Switcher
- **4-finger pinch in**: Deep Focus Mode Toggle
- **3-finger swipe down + hold**: Intelligent Layout
- **2-finger swipes**: Smart Window Focus (North/South/East/West)
- **4-finger swipe up + hold**: Neural Optimization
- **5-finger tap**: Sunrise Setup (morning hours)

### ⌨️ **Keyboard Maestro Macros**

Powerful keyboard shortcuts for everything:

- **Cmd+Shift+AI**: AI Research Mode
- **Cmd+Shift+P**: AI Performance Mode
- **Cmd+Shift+Q**: Quick AI Inference
- **Cmd+Shift+M**: Meeting Mode
- **Cmd+Shift+G**: Gaming Mode
- **Cmd+Shift+Esc**: Emergency Reset

### 🧠 **AI-Powered Intelligence**

The system automatically:

- **Analyzes your workspace context** in real-time
- **Recommends optimal profiles** with 90%+ confidence
- **Optimizes layouts** based on your current activity
- **Schedules workspace changes** intelligently
- **Monitors system performance** and suggests improvements

## 🏗️ **Project Structure**

```
NEXUS-Workspace-Manager-v2.0.0-PROD/
├── bin/                       # Executable binaries and scripts
│   ├── nexus                  # Main CLI executable
│   ├── nexus-ai-optimize      # AI optimization tool
│   ├── nexus-profile-switcher # Profile switching tool
│   ├── nexus-quick-menu       # Interactive menu system
│   └── setup                  # Setup utility
├── configs/                   # Configuration files
│   ├── environments/          # Environment-specific configs
│   ├── integrations/          # Third-party integrations
│   │   ├── bettertouchtool_preset.bttpreset
│   │   ├── keyboard_maestro_macros.kmmacros
│   │   ├── n8n/              # N8N workflow automation
│   │   └── raycast_yabai_extension/
│   ├── layouts/              # Window layout configurations
│   ├── profiles/             # Workspace profiles (12 profiles)
│   ├── settings/             # General settings (API keys, etc.)
│   ├── skhd/                 # SKHD hotkey daemon configs
│   ├── yabai/                # YABAI window manager configs
│   ├── adaptive_layout.yaml  # Adaptive layout config
│   ├── current_display_config.json
│   ├── dynamic_layout_config.yaml
│   └── nexus.yaml            # Main NEXUS configuration
├── dashboard/                # Streamlit dashboard components
│   ├── api_keys_ui.py        # API key management UI
│   ├── interactive_guide.py  # Interactive setup guide
│   ├── model_analytics_ui.py # AI model analytics
│   └── model_management_ui.py # Model management interface
├── data/                     # Data storage and snapshots
│   ├── cache/                # Cache files
│   ├── logs/                 # Log files
│   └── models/               # AI model storage
├── deployments/              # Deployment configurations
│   ├── development/          # Development environment
│   ├── production/           # Production environment
│   └── staging/              # Staging environment
├── docs/                     # Comprehensive documentation
│   ├── user-guides/          # User documentation
│   ├── developer-guides/     # Developer documentation
│   ├── api/                  # API documentation
│   └── configuration/        # Configuration guides
├── scripts/                  # Automation and utility scripts
│   ├── automation/           # Workspace automation scripts
│   ├── install/              # Installation scripts
│   ├── maintenance/          # Maintenance and troubleshooting
│   ├── deployment/           # Deployment scripts
│   └── setup/                # Setup and configuration scripts
├── src/                      # Source code (Python package)
│   └── nexus/                # Core NEXUS package
│       ├── cli/              # Command-line interface
│       ├── core/             # Core functionality
│       ├── dashboard/        # Dashboard components
│       ├── models/           # AI model management
│       ├── profiles/         # Profile management
│       └── utils/            # Utility functions
├── tests/                    # Test suite
│   ├── unit/                 # Unit tests
│   ├── integration/          # Integration tests
│   └── pytest.ini           # Pytest configuration
├── tools/                    # Development tools and utilities
│   ├── ai/                   # AI integration tools
│   ├── analytics/            # Analytics and monitoring tools
│   ├── shortcuts/            # Shortcut management tools
│   ├── enhanced-profile-loader # Profile loader utility
│   ├── skhd-bridge          # SKHD integration bridge
│   └── yabai-bridge         # YABAI integration bridge
├── pyproject.toml           # Python project configuration
├── Makefile                 # Build automation and tasks
├── uv.lock                  # Dependency lock file
└── README.md                # This file
```

## 🔧 **Development Setup**

### Environment Setup

```bash
# Create virtual environment
uv venv --python 3.11

# Activate environment
source .venv/bin/activate

# Install dependencies
uv pip install -e .
```

### Code Quality

```bash
# Format code
make format

# Type checking
make type-check

# Run tests
make test

# Lint code
make lint
```

## 📚 **Documentation**

- **[User Guide](docs/user-guides/USER_GUIDE.md)**: Complete user documentation
- **[Enhanced Automations Guide](docs/user-guides/ENHANCED_AUTOMATIONS_GUIDE.md)**: Automation features guide
- **[Interactive Guide](dashboard/interactive_guide.py)**: Interactive dashboard
- **[Project Structure](docs/developer-guides/PROJECT_STRUCTURE.md)**: Developer documentation
- **[Installation Guide](docs/installation/INSTALLATION.md)**: Setup instructions

## 🎮 **Usage Examples**

### Basic Workspace Management

```bash
# Load a specific profile
./scripts/setup/launcher.sh work_profile

# Launch dashboard
./scripts/setup/launcher.sh dashboard

# Check system status
./scripts/setup/launcher.sh status
```

### AI-Powered Features

```bash
# AI layout optimization
nexus-ai-optimize

# Workspace analysis
nexus-workspace-analyze

# Context-aware profile selection
nexus-context-profile

# Auto-schedule workspace
nexus-auto-schedule
```

### Advanced Automation

```bash
# Create workspace snapshot
nexus-create-snapshot

# Smart profile selection
nexus-smart-focus

# Emergency system reset
nexus-emergency-reset
```

## 🤝 **Contributing**

We welcome contributions! Please see our [Contributing Guide](CONTRIBUTING.md) for details.

### Development Workflow

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests
5. Submit a pull request

## 📄 **License**

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 **Acknowledgments**

- **YABAI**: Tiling window manager for macOS
- **SKHD**: Global hotkey daemon
- **BetterTouchTool**: Advanced gesture recognition
- **Keyboard Maestro**: Powerful automation tool
- **Apple Shortcuts**: Native macOS automation
- **MLX**: Apple's machine learning framework

## 🆘 **Support**

- **Documentation**: Check the docs folder
- **Issues**: Report bugs on GitHub
- **Discussions**: Join the community
- **Wiki**: Additional resources

---

**🚀 Transform your workspace with NEXUS Enhanced Automations - The future of productivity is here!**

*Built with ❤️ for Apple Silicon and powered by AI intelligence*