# 🤝 Contributing to NEXUS

> **Thank you for your interest in contributing to NEXUS!**

We welcome contributions from the community and appreciate your help in making NEXUS the best AI-powered workspace intelligence system available.

## 📋 Table of Contents

- [Getting Started](#-getting-started)
- [Development Setup](#-development-setup)
- [Code Standards](#-code-standards)
- [Testing](#-testing)
- [Documentation](#-documentation)
- [Pull Request Process](#-pull-request-process)
- [Issue Reporting](#-issue-reporting)
- [Community Guidelines](#-community-guidelines)

## 🚀 Getting Started

### **Before You Begin**

1. **Fork the repository** on GitHub
2. **Clone your fork** locally
3. **Set up the development environment**
4. **Create a feature branch**

```bash
# Fork and clone
git clone https://github.com/yourusername/NEXUS.git
cd NEXUS

# Set up development environment
make setup

# Create feature branch
git checkout -b feature/amazing-feature
```

### **Quick Start**

```bash
# 1. Install development dependencies
make install-dev

# 2. Set up pre-commit hooks
make git-setup

# 3. Run initial tests
make test

# 4. Start development
make dev
```

## 🛠️ Development Setup

### **System Requirements**

- **macOS**: 12.0 (Monterey) or later
- **Python**: 3.7 or higher
- **YABAI**: Installed and configured
- **Git**: Latest version
- **Make**: Available (usually pre-installed)

### **Required Tools**

```bash
# Install Homebrew (if not installed)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install core dependencies
brew install python@3.9 yabai skhd

# Install development tools
brew install pre-commit shellcheck

# Install Python development tools
pip install pre-commit black isort flake8 mypy bandit
```

### **Environment Setup**

```bash
# Create virtual environment
python3 -m venv venv
source venv/bin/activate

# Install dependencies
make install-dev

# Set up pre-commit hooks
pre-commit install

# Verify setup
make system-check
```

## 📏 Code Standards

### **Python Code Style**

We follow **PEP 8** with some modifications:

- **Line length**: 88 characters (Black default)
- **Import sorting**: isort with Black profile
- **Type hints**: Required for all functions
- **Docstrings**: Google style

#### **Example Code**

```python
"""NEXUS AI Model Manager.

This module provides intelligent AI model management for workspace optimization.
"""

from typing import Dict, List, Optional
import logging
from dataclasses import dataclass

logger = logging.getLogger(__name__)


@dataclass
class ModelInfo:
    """Information about an AI model."""
    
    name: str
    path: str
    format: str
    size: int
    purpose: str
    memory_required: float
    performance_score: float


class AIModelManager:
    """Advanced AI model management for workspace optimization."""
    
    def __init__(self, model_path: Optional[str] = None) -> None:
        """Initialize the AI model manager.
        
        Args:
            model_path: Optional path to model collection.
        """
        self.model_path = model_path or "/Volumes/MICRO/models"
        self.models: Dict[str, ModelInfo] = {}
    
    def load_model_collection(self) -> Dict[str, ModelInfo]:
        """Load and scan the model collection.
        
        Returns:
            Dictionary of model information.
        """
        # Implementation here
        pass
```

### **Shell Script Standards**

- **Shebang**: Always use `#!/bin/bash`
- **Error handling**: Use `set -euo pipefail`
- **Functions**: Use descriptive names
- **Comments**: Explain complex logic

#### **Example Shell Script**

```bash
#!/bin/bash
set -euo pipefail

# NEXUS Workspace Profile Manager
# Manages workspace profiles and configurations

readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly CONFIG_DIR="${SCRIPT_DIR}/../configs/profiles"

log_info() {
    echo "[INFO] $*"
}

log_error() {
    echo "[ERROR] $*" >&2
}

load_workspace_profile() {
    local profile_name="$1"
    local profile_file="${CONFIG_DIR}/${profile_name}_profile.sh"
    
    if [[ ! -f "$profile_file" ]]; then
        log_error "Profile not found: $profile_file"
        return 1
    fi
    
    log_info "Loading profile: $profile_name"
    source "$profile_file"
}
```

### **YAML Configuration**

- **Indentation**: 2 spaces
- **Quotes**: Use quotes for strings with special characters
- **Comments**: Explain complex configurations

#### **Example YAML**

```yaml
# NEXUS Configuration
# Workspace management settings

displays:
  - name: "HZ30GAMER"
    position: "left"
    resolution: "2560x1080"
    purpose: "Browsers & Web Tools"
  
  - name: "LG ULTRAWIDE"
    position: "center"
    resolution: "3440x1440"
    purpose: "AI & Development Tools"
  
  - name: "iMac"
    position: "right"
    resolution: "4480x2520"
    purpose: "Productivity & Communication"

ai_integration:
  model_recommendations:
    work:
      primary: "Meta-Llama-3.1-8B-Instruct-Q6_K"
      coding: "DeepSeek-R1-0528-Qwen3-8B-MLX-4bit"
      reasoning: "Phi-4-mini-reasoning-MLX-4bit"
```

## 🧪 Testing

### **Running Tests**

```bash
# Run all tests
make test

# Run fast tests only
make test-fast

# Run integration tests
make test-integration

# Run with coverage
pytest tests/ --cov=nexus --cov-report=html
```

### **Writing Tests**

#### **Unit Tests**

```python
"""Tests for AI Model Manager."""

import pytest
from unittest.mock import Mock, patch
from scripts.ai.ai_model_manager import AIModelManager, ModelInfo


class TestAIModelManager:
    """Test cases for AIModelManager."""
    
    def setup_method(self):
        """Set up test fixtures."""
        self.manager = AIModelManager("/tmp/test_models")
    
    def test_init_with_default_path(self):
        """Test initialization with default model path."""
        manager = AIModelManager()
        assert manager.model_path == "/Volumes/MICRO/models"
    
    def test_load_model_collection_empty(self):
        """Test loading empty model collection."""
        with patch("os.path.exists", return_value=False):
            result = self.manager.load_model_collection()
            assert result == {}
    
    @pytest.mark.integration
    def test_model_selection_with_memory(self):
        """Test model selection based on available memory."""
        # Integration test implementation
        pass
```

#### **Integration Tests**

```python
"""Integration tests for NEXUS components."""

import pytest
from scripts.ai.ai_model_manager import AIModelManager


@pytest.mark.integration
class TestNEXUSIntegration:
    """Integration tests for NEXUS system."""
    
    def test_workspace_optimization_workflow(self):
        """Test complete workspace optimization workflow."""
        manager = AIModelManager()
        
        # Test workflow steps
        context = manager.get_workspace_context()
        assert context is not None
        
        models = manager.select_optimal_models(context)
        assert len(models) > 0
        
        optimizations = manager.suggest_workspace_optimizations()
        assert optimizations is not None
```

### **Test Coverage**

We aim for **90%+ code coverage**:

```bash
# Generate coverage report
pytest tests/ --cov=nexus --cov-report=html --cov-report=term-missing

# View coverage in browser
open htmlcov/index.html
```

## 📚 Documentation

### **Code Documentation**

- **Docstrings**: Required for all functions and classes
- **Type hints**: Required for all function signatures
- **Comments**: Explain complex logic
- **README**: Keep updated with new features

### **API Documentation**

```python
def suggest_workspace_optimizations(self) -> Dict[str, any]:
    """Generate AI-powered workspace optimization suggestions.
    
    Analyzes current workspace context and suggests optimizations
    based on AI model analysis and performance metrics.
    
    Returns:
        Dictionary containing:
            - suggestions: List of optimization suggestions
            - confidence: Confidence score (0.0 to 1.0)
            - processing_time: Time taken for analysis
            - model_used: Name of the model used for analysis
    
    Raises:
        ModelNotLoadedError: If no AI model is loaded
        ContextAnalysisError: If workspace context cannot be analyzed
    
    Example:
        >>> manager = AIModelManager()
        >>> optimizations = manager.suggest_workspace_optimizations()
        >>> print(optimizations['suggestions'])
        ['Move development tools to center display', 'Optimize memory usage']
    """
```

### **User Documentation**

- **User Guide**: Step-by-step instructions
- **Installation Guide**: Setup procedures
- **API Reference**: Technical documentation
- **Examples**: Code examples and use cases

## 🔄 Pull Request Process

### **Before Submitting**

1. **Ensure tests pass**
2. **Update documentation**
3. **Follow code standards**
4. **Add appropriate labels**

```bash
# Prepare for submission
make git-commit

# Run final checks
make ci-test
```

### **Pull Request Template**

```markdown
## Description
Brief description of changes

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Documentation update
- [ ] Performance improvement
- [ ] Refactoring

## Testing
- [ ] Unit tests pass
- [ ] Integration tests pass
- [ ] Manual testing completed

## Documentation
- [ ] Code documented
- [ ] User documentation updated
- [ ] API documentation updated

## Checklist
- [ ] Code follows style guidelines
- [ ] Self-review completed
- [ ] Tests added for new functionality
- [ ] Documentation updated
- [ ] No breaking changes (or documented)

## Screenshots (if applicable)
Add screenshots for UI changes

## Related Issues
Closes #123
```

### **Review Process**

1. **Automated checks** must pass
2. **Code review** by maintainers
3. **Testing** on target platforms
4. **Documentation** review
5. **Final approval** and merge

## 🐛 Issue Reporting

### **Bug Reports**

Use the **Bug Report** template:

```markdown
## Bug Description
Clear description of the bug

## Steps to Reproduce
1. Step 1
2. Step 2
3. Step 3

## Expected Behavior
What should happen

## Actual Behavior
What actually happens

## Environment
- macOS Version: 12.0
- Python Version: 3.9.0
- NEXUS Version: 2.0.0
- YABAI Version: 4.0.0

## Additional Information
Screenshots, logs, etc.
```

### **Feature Requests**

Use the **Feature Request** template:

```markdown
## Feature Description
Clear description of the feature

## Use Case
Why this feature is needed

## Proposed Implementation
How it could be implemented

## Alternatives Considered
Other approaches considered

## Additional Information
Mockups, examples, etc.
```

## 🤝 Community Guidelines

### **Code of Conduct**

We are committed to providing a welcoming and inclusive environment:

- **Be respectful** and inclusive
- **Be collaborative** and constructive
- **Be professional** and helpful
- **Be patient** with newcomers

### **Communication**

- **GitHub Issues**: For bugs and feature requests
- **GitHub Discussions**: For questions and ideas
- **Pull Requests**: For code contributions
- **Documentation**: For improvements and clarifications

### **Recognition**

Contributors are recognized in:

- **README.md**: Contributors section
- **Release notes**: Feature acknowledgments
- **Documentation**: Author credits
- **GitHub**: Contributor statistics

## 🎯 Areas for Contribution

### **High Priority**

- **AI Integration**: Model optimization and selection
- **Performance**: System optimization and monitoring
- **Testing**: Test coverage and automation
- **Documentation**: User guides and API docs

### **Medium Priority**

- **UI/UX**: Dashboard improvements
- **Automation**: Workflow enhancements
- **Integration**: Third-party tool support
- **Analytics**: Data collection and analysis

### **Low Priority**

- **Examples**: Code examples and tutorials
- **Translations**: Internationalization
- **Themes**: Visual customization
- **Plugins**: Extension system

## 📞 Getting Help

### **Resources**

- **Documentation**: `docs/` directory
- **Examples**: `examples/` directory
- **Tests**: `tests/` directory
- **Issues**: GitHub Issues

### **Contact**

- **Maintainers**: @nexus-maintainers
- **Discussions**: GitHub Discussions
- **Email**: team@nexus-workspace.com

---

## 🎉 Thank You!

**Thank you for contributing to NEXUS!** Your contributions help make this the best AI-powered workspace intelligence system available.

**Together, we're building the future of workspace management!** 🚀
