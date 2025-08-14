# 🏗️ NEXUS Project Structure

> **AI-Powered Workspace Intelligence for Apple Silicon**

## 📋 Overview

This document describes the organized and professional structure of the NEXUS project, following industry best practices for Python projects, automation tools, and AI integration.

## 🗂️ Directory Structure

```
nexus-workspace/
├── 📁 .github/                          # GitHub workflows and templates
│   ├── workflows/                        # CI/CD workflows
│   ├── ISSUE_TEMPLATE/                   # Issue templates
│   └── PULL_REQUEST_TEMPLATE/            # PR templates
├── 📁 assets/                            # Static assets
│   ├── images/                           # Project images and screenshots
│   ├── icons/                            # Application icons
│   └── diagrams/                         # Architecture diagrams
├── 📁 configs/                           # Configuration management
│   ├── environments/                     # Environment configurations
│   │   └── nexus.env.example            # Environment variables template
│   ├── profiles/                         # Workspace profiles
│   │   ├── work_profile.sh              # Work environment setup
│   │   ├── personal_profile.sh          # Personal environment setup
│   │   ├── ai_research_profile.sh       # AI research setup
│   │   ├── focus_profile.sh             # Focus mode setup
│   │   ├── gaming_profile.sh            # Gaming environment setup
│   │   ├── learning_profile.sh          # Learning environment setup
│   │   ├── ai_business_profile.sh       # AI business setup
│   │   ├── ai_content_creation_profile.sh # Content creation setup
│   │   ├── ai_development_profile.sh    # AI development setup
│   │   ├── ai_gaming_profile.sh         # AI gaming setup
│   │   ├── ai_learning_profile.sh       # AI learning setup
│   │   └── yabai_config.yaml            # YABAI configuration
│   ├── integrations/                     # Third-party integrations
│   │   ├── bettertouchtool_yabai_bridge.bttpreset
│   │   ├── keyboard_maestro_yabai_bridge.kmmacros
│   │   └── n8n/                         # N8N workflow automation
│   └── models/                           # AI model configurations
│       ├── model_config.yaml             # Model configuration
│       └── model_catalog.json            # Discovered models catalog
├── 📁 dashboard/                         # Streamlit dashboards
│   └── interactive_guide.py              # Main interactive dashboard
├── 📁 data/                              # Data storage
│   ├── analytics/                        # Analytics data
│   ├── logs/                             # System logs
│   └── cache/                            # Cache files
├── 📁 docs/                              # Documentation
│   ├── api/                              # API documentation
│   ├── user-guides/                      # User documentation
│   ├── developer-guides/                 # Developer guides
│   └── deployment/                       # Deployment guides
├── 📁 infra/                             # Infrastructure files
│   ├── docker/                           # Docker configurations
│   ├── kubernetes/                       # K8s configurations
│   └── terraform/                        # Infrastructure as code
├── 📁 logs/                              # Application logs
├── 📁 scripts/                           # Automation scripts
│   ├── setup/                            # Setup and installation
│   │   ├── launcher.sh                   # Main launcher script
│   │   └── Makefile                      # Build automation
│   ├── maintenance/                      # Maintenance scripts
│   └── deployment/                       # Deployment scripts
├── 📁 src/                               # Python source code
│   └── nexus/                            # Main package
│       ├── __init__.py                   # Package initialization
│       ├── cli/                          # Command-line interface
│       │   └── __init__.py
│       ├── core/                         # Core functionality
│       │   ├── __init__.py
│       │   ├── ai_model_manager.py       # AI model management
│       │   └── dynamic_layout_manager.py # Layout management
│       ├── dashboard/                    # Dashboard components
│       │   ├── __init__.py
│       │   ├── interactive_dashboard.py  # Interactive dashboard
│       │   └── workspace_dashboard.py    # Workspace dashboard
│       ├── profiles/                     # Profile management
│       │   └── __init__.py
│       └── utils/                        # Utility functions
│           └── __init__.py
├── 📁 tests/                             # Test suite
│   ├── __init__.py
│   ├── unit/                             # Unit tests
│   │   ├── test_ai_model_manager.py      # AI manager tests
│   │   └── test_analytics.py             # Analytics tests
│   ├── integration/                      # Integration tests
│   │   └── test_nexus_integration.py     # System integration tests
│   └── pytest.ini                        # Pytest configuration
├── 📁 tools/                             # Utility tools
│   ├── ai/                               # AI-related tools
│   │   ├── discover_models.py            # Model discovery script
│   │   └── yabai_automation_bridge.py    # YABAI automation bridge
│   ├── automation/                       # Automation tools
│   │   └── install_yabai_bridge.sh      # YABAI bridge installer
│   └── integrations/                     # Integration tools
├── 📁 .venv/                             # Virtual environment (symlink)
├── 📄 .envrc                             # Direnv configuration
├── 📄 .gitignore                         # Git ignore patterns
├── 📄 .pre-commit-config.yaml            # Pre-commit hooks
├── 📄 LICENSE                            # MIT license
├── 📄 Makefile                           # Root Makefile (symlink)
├── 📄 README.md                           # Project documentation
├── 📄 pyproject.toml                     # Project configuration
└── 📄 uv.lock                            # Dependency lock file
```

## 🔧 Key Components

### **Configuration Management (`configs/`)**
- **Environments**: Environment-specific configurations
- **Profiles**: Workspace profile definitions for different use cases
- **Integrations**: Third-party tool configurations (BetterTouchTool, Keyboard Maestro, N8N)
- **Models**: AI model configurations and catalogs

### **Scripts (`scripts/`)**
- **Setup**: Installation and setup automation
- **Maintenance**: System maintenance and cleanup
- **Deployment**: Production deployment automation

### **Source Code (`src/`)**
- **CLI**: Command-line interface components
- **Core**: Core business logic and functionality
- **Dashboard**: Streamlit dashboard components
- **Profiles**: Workspace profile management
- **Utils**: Utility functions and helpers

### **Tools (`tools/`)**
- **AI**: AI model discovery and management tools
- **Automation**: YABAI automation bridge and related tools
- **Integrations**: Integration setup and management tools

### **Documentation (`docs/`)**
- **API**: Technical API documentation
- **User Guides**: End-user documentation
- **Developer Guides**: Development and contribution guides
- **Deployment**: Production deployment guides

## 🚀 Project Setup

### **Prerequisites**
- Python 3.11+
- uv package manager
- YABAI and SKHD
- macOS 12.0+ (Monterey)

### **Installation**
```bash
# Clone repository
git clone https://github.com/eduardogiovannini/nexus-workspace.git
cd nexus-workspace

# Create virtual environment
uv venv --python 3.11

# Install dependencies
uv pip install -e .

# Setup project
make setup

# Make launcher executable
chmod +x scripts/setup/launcher.sh
```

### **Development Setup**
```bash
# Install development dependencies
uv pip install -e ".[dev]"

# Install pre-commit hooks
make pre-commit

# Run tests
make test

# Run linting
make lint
```

## 📊 AI Model Integration

### **Model Discovery**
The project includes an automated model discovery system that catalogs AI models from the LM Studio models directory:

```bash
# Discover models
python tools/ai/discover_models.py

# Discover with custom path
python tools/ai/discover_models.py --path /custom/models/path

# Save catalog to custom location
python tools/ai/discover_models.py --output custom_catalog.json
```

### **Model Configuration**
Models are configured in `configs/models/model_config.yaml` with:
- Provider-specific model mappings
- Performance profiles
- Workspace-specific model selection
- Fallback model configurations

## 🔄 Automation Features

### **YABAI Integration**
- **Automation Bridge**: Python-based bridge for YABAI functionality
- **Gesture Support**: BetterTouchTool integration for touch gestures
- **Keyboard Shortcuts**: Keyboard Maestro integration for hotkeys
- **Shell Scripts**: Command-line access to YABAI features

### **Workspace Profiles**
- **Automatic Switching**: Context-aware profile switching
- **AI Optimization**: AI-powered workspace optimization
- **Multi-Display Support**: Adaptive multi-display configurations

### **N8N Integration**
- **Workflow Automation**: Automated workspace management
- **Webhook Support**: Event-driven automation
- **Custom Workflows**: User-defined automation workflows

## 📈 Monitoring and Analytics

### **Performance Tracking**
- **System Monitoring**: CPU, memory, and GPU usage
- **Model Performance**: AI model inference metrics
- **Workspace Analytics**: Productivity and usage patterns

### **Logging and Debugging**
- **Structured Logging**: JSON-formatted logs with rotation
- **Performance Metrics**: Real-time performance monitoring
- **Error Tracking**: Comprehensive error reporting and recovery

## 🛡️ Security and Privacy

### **Security Features**
- **Secure Mode**: Enhanced security configurations
- **Encryption**: Data encryption for sensitive information
- **Access Control**: Role-based access control

### **Privacy Features**
- **Local Processing**: All AI processing done locally
- **Data Retention**: Configurable data retention policies
- **Anonymous Analytics**: Optional anonymous usage analytics

## 🔧 Development Workflow

### **Code Quality**
- **Type Hints**: Full type annotation support
- **Linting**: Black, Flake8, and MyPy integration
- **Testing**: Comprehensive test suite with pytest
- **Pre-commit**: Automated code quality checks

### **CI/CD Pipeline**
- **Automated Testing**: GitHub Actions for continuous testing
- **Code Quality**: Automated linting and type checking
- **Deployment**: Automated deployment to production

### **Version Control**
- **Git Hooks**: Pre-commit and post-commit hooks
- **Branch Strategy**: Feature branch workflow
- **Release Management**: Semantic versioning

## 📚 Documentation Standards

### **Code Documentation**
- **Docstrings**: Comprehensive function and class documentation
- **Type Hints**: Full type annotation for all functions
- **Examples**: Usage examples in docstrings

### **User Documentation**
- **User Guides**: Step-by-step user instructions
- **API Reference**: Complete API documentation
- **Troubleshooting**: Common issues and solutions

### **Developer Documentation**
- **Architecture**: System architecture documentation
- **Contributing**: Contribution guidelines and workflow
- **Deployment**: Production deployment procedures

## 🚀 Deployment

### **Production Deployment**
- **Environment Configuration**: Production environment setup
- **Performance Tuning**: Optimized performance configurations
- **Monitoring**: Production monitoring and alerting

### **Backup and Recovery**
- **Automated Backups**: Regular backup scheduling
- **Recovery Procedures**: Disaster recovery procedures
- **Data Protection**: Data integrity and protection

## 🔍 Troubleshooting

### **Common Issues**
- **YABAI Integration**: Troubleshooting YABAI connectivity
- **Model Loading**: AI model loading issues
- **Performance**: Performance optimization tips

### **Debug Mode**
- **Verbose Logging**: Enhanced logging for debugging
- **Performance Profiling**: Detailed performance analysis
- **Error Reporting**: Comprehensive error reporting

## 📞 Support and Community

### **Getting Help**
- **Documentation**: Comprehensive documentation
- **GitHub Issues**: Bug reports and feature requests
- **Community**: Community support and discussions

### **Contributing**
- **Development Setup**: Setting up development environment
- **Code Standards**: Coding standards and guidelines
- **Pull Request Process**: Contribution workflow

---

**This structure follows industry best practices for Python projects, automation tools, and AI integration, ensuring maintainability, scalability, and professional development workflows.**
