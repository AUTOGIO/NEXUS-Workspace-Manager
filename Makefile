# 🚀 NEXUS Enhanced Automations Makefile
# AI-Powered Workspace Intelligence for Apple Silicon

.PHONY: help install setup venv install-deps install dev test format type-check pre-commit clean deploy docs info

# Project configuration
PROJECT_NAME := nexus
PYTHON_VERSION := 3.11
VENV_DIR := .venv
PYTHON := python3
UV := uv
PIP := uv pip

# Default target
help: ## Show this help message
	@echo "🚀 NEXUS Enhanced Automations - AI-Powered Workspace Intelligence"
	@echo ""
	@echo "Available commands:"
	@echo ""
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-20s\033[0m %s\n", $$1, $$2}'
	@echo ""
	@echo "🎯 Quick Start: make setup"
	@echo "🧠 AI Features: make test-ai"
	@echo "📱 Dashboard: make dashboard"

# Setup and installation
setup: ## Complete project setup (venv + deps + install)
	@echo "🚀 Setting up NEXUS Enhanced Automations..."
	$(MAKE) venv
	$(MAKE) install-deps
	$(MAKE) install
	@echo "✅ Setup complete! Run 'make help' for available commands."

venv: ## Create virtual environment
	@echo "🐍 Creating virtual environment..."
	$(UV) venv --python $(PYTHON_VERSION)
	@echo "✅ Virtual environment created at $(VENV_DIR)"

install-deps: ## Install all dependencies
	@echo "📦 Installing dependencies..."
	$(PIP) install -e .
	$(PIP) install -e ".[dev]"
	@echo "✅ Dependencies installed"

install: ## Install NEXUS in development mode
	@echo "🔧 Installing NEXUS in development mode..."
	$(PIP) install -e .
	@echo "✅ NEXUS installed"

dev: ## Install development dependencies
	@echo "🔧 Installing development dependencies..."
	$(PIP) install -e ".[dev]"
	@echo "✅ Development dependencies installed"

# Testing and quality
test: ## Run all tests
	@echo "🧪 Running tests..."
	$(PYTHON) -m pytest tests/ -v --cov=src/nexus

test-unit: ## Run unit tests only
	@echo "🧪 Running unit tests..."
	$(PYTHON) -m pytest tests/unit/ -v

test-integration: ## Run integration tests only
	@echo "🧪 Running integration tests..."
	$(PYTHON) -m pytest tests/integration/ -v

test-ai: ## Test AI features
	@echo "🧠 Testing AI features..."
	$(PYTHON) -m pytest tests/ -m ai -v

test-yabai: ## Test YABAI integration
	@echo "🖥️ Testing YABAI integration..."
	$(PYTHON) -m pytest tests/ -m yabai -v

# Code quality
format: ## Format code with Black
	@echo "🎨 Formatting code..."
	$(PYTHON) -m black src/ tests/ --line-length 88

type-check: ## Run type checking with MyPy
	@echo "🔍 Running type checks..."
	$(PYTHON) -m mypy src/nexus/

pre-commit: ## Install pre-commit hooks
	@echo "🔧 Installing pre-commit hooks..."
	$(PYTHON) -m pre_commit install

pre-commit-run: ## Run pre-commit hooks on all files
	@echo "🔧 Running pre-commit hooks..."
	$(PYTHON) -m pre_commit run --all-files

# Enhanced automation features
install-enhanced: ## Install enhanced automation features
	@echo "🚀 Installing NEXUS Enhanced Automations..."
	chmod +x scripts/setup/install_enhanced_automations.sh
	./scripts/setup/install_enhanced_automations.sh

test-gestures: ## Test BetterTouchTool gestures
	@echo "🎨 Testing gesture system..."
	@echo "✅ Gestures installed. Import preset in BetterTouchTool:"
	@echo "   configs/integrations/nexus_enhanced_gestures.bttpreset"

test-macros: ## Test Keyboard Maestro macros
	@echo "⌨️ Testing macro system..."
	@echo "✅ Macros installed. Import in Keyboard Maestro:"
	@echo "   configs/integrations/nexus_enhanced_macros.kmmacros"

test-shortcuts: ## Test shell script shortcuts
	@echo "🖥️ Testing shell shortcuts..."
	@echo "Available shortcuts:"
	@ls -la ~/bin/nexus-* 2>/dev/null || echo "No shortcuts found. Run 'make install-enhanced' first."

# AI and MLX features
mlx-test: ## Test MLX integration
	@echo "🧠 Testing MLX integration..."
	$(PYTHON) -c "import mlx; print(f'MLX version: {mlx.__version__}')"

test-ai-bridge: ## Test AI automation bridge
	@echo "🤖 Testing AI automation bridge..."
	$(PYTHON) tools/ai/nexus_enhanced_bridge.py --help

# N8N integration
n8n-start: ## Start N8N workflow automation
	@echo "🔄 Starting N8N..."
	cd integrations/n8n && docker-compose up -d

# Dashboard and monitoring
dashboard: ## Launch NEXUS dashboard
	@echo "📱 Launching NEXUS dashboard..."
	cd dashboard && $(PYTHON) -m streamlit run interactive_guide.py

# System management
status: ## Check system status
	@echo "📊 Checking NEXUS system status..."
	./scripts/setup/launcher.sh status

start-yabai: ## Start YABAI service
	@echo "🖥️ Starting YABAI..."
	yabai --start-service

# Cleaning and maintenance
clean: ## Clean build artifacts
	@echo "🧹 Cleaning build artifacts..."
	rm -rf build/ dist/ *.egg-info/
	find . -type d -name __pycache__ -exec rm -rf {} +
	find . -type f -name "*.pyc" -delete

clean-venv: ## Remove virtual environment
	@echo "🧹 Removing virtual environment..."
	rm -rf $(VENV_DIR)

clean-logs: ## Clean log files
	@echo "🧹 Cleaning log files..."
	rm -rf logs/*.log

clean-data: ## Clean data files
	@echo "🧹 Cleaning data files..."
	rm -rf data/snapshots/*.json

# Deployment and documentation
deploy: ## Deploy NEXUS
	@echo "🚀 Deploying NEXUS..."
	$(MAKE) test
	$(MAKE) clean
	$(PIP) install build
	$(PYTHON) -m build

docs: ## Build documentation
	@echo "📚 Building documentation..."
	@echo "Documentation available in docs/ directory"

# Information and help
info: ## Show project information
	@echo "🚀 NEXUS Enhanced Automations v1.0.0"
	@echo "🎯 AI-Powered Workspace Intelligence for Apple Silicon"
	@echo ""
	@echo "📁 Project structure:"
	@echo "  • Enhanced BetterTouchTool gestures (15 gestures)"
	@echo "  • Enhanced Keyboard Maestro macros (18 macros)"
	@echo "  • Enhanced Apple Shortcuts (16 shortcuts)"
	@echo "  • AI-powered workspace optimization"
	@echo "  • Context-aware profile selection"
	@echo ""
	@echo "🔧 Available commands:"
	@echo "  • make install-enhanced    - Install enhanced automations"
	@echo "  • make test-gestures       - Test gesture system"
	@echo "  • make test-macros         - Test macro system"
	@echo "  • make test-shortcuts      - Test shell shortcuts"
	@echo "  • make dashboard           - Launch dashboard"
	@echo "  • make status              - Check system status"

# Development workflow
dev-workflow: ## Set up development workflow
	@echo "🔧 Setting up development workflow..."
	$(MAKE) pre-commit
	$(MAKE) install-deps
	@echo "✅ Development workflow ready!"

# Quick start for new users
quick-start: ## Quick start for new users
	@echo "🚀 Quick start for NEXUS Enhanced Automations..."
	@echo ""
	@echo "1. Install enhanced automations:"
	@echo "   make install-enhanced"
	@echo ""
	@echo "2. Test the system:"
	@echo "   nexus-quick-menu"
	@echo ""
	@echo "3. Try AI optimization:"
	@echo "   nexus-ai-optimize"
	@echo ""
	@echo "4. Launch dashboard:"
	@echo "   make dashboard"
	@echo ""
	@echo "🎉 Welcome to the future of workspace management!"

# Help targets
help-setup: ## Help with setup
	@echo "🔧 Setup Help:"
	@echo "  1. Run 'make setup' for complete installation"
	@echo "  2. Run 'make install-enhanced' for automation features"
	@echo "  3. Run 'make dashboard' to launch the interface"

help-ai: ## Help with AI features
	@echo "🧠 AI Features Help:"
	@echo "  • nexus-ai-optimize        - AI layout optimization"
	@echo "  • nexus-workspace-analyze  - Workspace analysis"
	@echo "  • nexus-context-profile    - Context-aware profiles"

help-gestures: ## Help with gestures
	@echo "🎨 Gesture Help:"
	@echo "  • Import preset in BetterTouchTool"
	@echo "  • Use 3-finger swipes for profile switching"
	@echo "  • Use 2-finger swipes for window focus"

help-macros: ## Help with macros
	@echo "⌨️ Macro Help:"
	@echo "  • Import macros in Keyboard Maestro"
	@echo "  • Use Cmd+Shift combinations for quick access"
	@echo "  • Customize hotkeys as needed"

help-shortcuts: ## Help with shortcuts
	@echo "🖥️ Shortcut Help:"
	@echo "  • nexus-quick-menu        - Main menu"
	@echo "  • nexus-ai-optimize       - AI optimization"
	@echo "  • nexus-workspace-analyze - Workspace analysis"
