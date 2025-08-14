# 🚀 NEXUS - Neural EXperience Unified System
# AI-Powered Workspace Intelligence for Apple Silicon
#
# Author: Eduardo Giovannini
# Version: 0.1.0
# License: MIT

.PHONY: help install test lint clean deploy mlx-test n8n-start dashboard setup dev install-deps install-dev-deps install-mlx-deps install-n8n-deps install-analytics-deps

# Default target
help: ## Show this help message
	@echo "🚀 NEXUS - Neural EXperience Unified System"
	@echo "AI-Powered Workspace Intelligence for Apple Silicon"
	@echo ""
	@echo "Available targets:"
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "  \033[36m%-20s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

# Project configuration
PROJECT_NAME = nexus
PYTHON_VERSION = 3.11
VENV_DIR = .venv
PYTHON = python3
UV = uv
PIP = $(UV) pip

# Directories
SRC_DIR = src
TESTS_DIR = tests
CONFIGS_DIR = configs
SCRIPTS_DIR = scripts
DOCS_DIR = docs
LOGS_DIR = logs
DATA_DIR = data

# Files
PYPROJECT = pyproject.toml
LAUNCHER = $(SCRIPTS_DIR)/setup/launcher.sh

# Development setup
setup: ## Initial project setup
	@echo "🚀 Setting up NEXUS project..."
	@mkdir -p $(LOGS_DIR) $(DATA_DIR)
	@chmod +x $(LAUNCHER)
	@echo "✅ Setup complete!"

# Virtual environment management
venv: ## Create virtual environment
	@echo "🐍 Creating virtual environment..."
	$(UV) venv --python $(PYTHON_VERSION)
	@echo "✅ Virtual environment created!"

# Install dependencies
install-deps: ## Install production dependencies
	@echo "📦 Installing production dependencies..."
	$(PIP) install -e .
	@echo "✅ Production dependencies installed!"

install-dev-deps: ## Install development dependencies
	@echo "🔧 Installing development dependencies..."
	$(PIP) install -e ".[dev]"
	@echo "✅ Development dependencies installed!"

install-mlx-deps: ## Install MLX dependencies
	@echo "🤖 Installing MLX dependencies..."
	$(PIP) install -e ".[mlx]"
	@echo "✅ MLX dependencies installed!"

install-n8n-deps: ## Install N8N dependencies
	@echo "⚙️ Installing N8N dependencies..."
	$(PIP) install -e ".[n8n]"
	@echo "✅ N8N dependencies installed!"

install-analytics-deps: ## Install analytics dependencies
	@echo "📊 Installing analytics dependencies..."
	$(PIP) install -e ".[analytics]"
	@echo "✅ Analytics dependencies installed!"

# Full installation
install: setup venv install-deps ## Full project installation
	@echo "🎉 NEXUS installation complete!"
	@echo "Run './$(LAUNCHER)' to start!"

# Development installation
dev: setup venv install-deps install-dev-deps ## Development environment setup
	@echo "🔧 Development environment ready!"
	@echo "Run 'make test' to verify installation!"

# Testing
test: ## Run test suite
	@echo "🧪 Running tests..."
	$(PYTHON) -m pytest $(TESTS_DIR) -v --cov=$(SRC_DIR)/$(PROJECT_NAME) --cov-report=html --cov-report=term-missing

test-unit: ## Run unit tests only
	@echo "🧪 Running unit tests..."
	$(PYTHON) -m pytest $(TESTS_DIR)/unit -v

test-integration: ## Run integration tests only
	@echo "🧪 Running integration tests..."
	$(PYTHON) -m pytest $(TESTS_DIR)/integration -v

test-mlx: ## Run MLX-specific tests
	@echo "🤖 Running MLX tests..."
	$(PYTHON) -m pytest $(TESTS_DIR) -m mlx -v

test-n8n: ## Run N8N-specific tests
	@echo "⚙️ Running N8N tests..."
	$(PYTHON) -m pytest $(TESTS_DIR) -m n8n -v

test-yabai: ## Run YABAI-specific tests
	@echo "🖥️ Running YABAI tests..."
	$(PYTHON) -m pytest $(TESTS_DIR) -m yabai -v

# Code quality
lint: ## Run linting and formatting
	@echo "🔍 Running code quality checks..."
	$(PYTHON) -m black $(SRC_DIR) $(TESTS_DIR)
	$(PYTHON) -m flake8 $(SRC_DIR) $(TESTS_DIR)
	$(PYTHON) -m mypy $(SRC_DIR)

format: ## Format code with black
	@echo "🎨 Formatting code..."
	$(PYTHON) -m black $(SRC_DIR) $(TESTS_DIR)

type-check: ## Run type checking with mypy
	@echo "🔍 Running type checks..."
	$(PYTHON) -m mypy $(SRC_DIR)

# Pre-commit hooks
pre-commit: ## Install pre-commit hooks
	@echo "🔒 Installing pre-commit hooks..."
	$(PYTHON) -m pre_commit install

pre-commit-run: ## Run pre-commit hooks on all files
	@echo "🔒 Running pre-commit hooks..."
	$(PYTHON) -m pre_commit run --all-files

# MLX testing
mlx-test: ## Test MLX integration
	@echo "🤖 Testing MLX integration..."
	$(PYTHON) -c "import mlx; print(f'MLX version: {mlx.__version__}')"
	$(PYTHON) -c "import mlx_lm; print('MLX-LM imported successfully')"

# N8N integration
n8n-start: ## Start N8N service
	@echo "⚙️ Starting N8N service..."
	@if [ -f "$(CONFIGS_DIR)/integrations/n8n/run_n8n.sh" ]; then \
		chmod +x "$(CONFIGS_DIR)/integrations/n8n/run_n8n.sh"; \
		"$(CONFIGS_DIR)/integrations/n8n/run_n8n.sh"; \
	else \
		echo "❌ N8N integration not found"; \
	fi

# Dashboard
dashboard: ## Launch Streamlit dashboard
	@echo "📊 Launching NEXUS dashboard..."
	@if [ -d "$(DOCS_DIR)/dashboard" ]; then \
		cd "$(DOCS_DIR)/dashboard" && $(PYTHON) -m streamlit run interactive_guide.py --server.port 8501; \
	else \
		echo "❌ Dashboard not found"; \
	fi

# System management
status: ## Check system status
	@echo "🔍 Checking NEXUS system status..."
	@if [ -f "$(LAUNCHER)" ]; then \
		./$(LAUNCHER) status; \
	else \
		echo "❌ Launcher not found"; \
	fi

start-yabai: ## Start YABAI service
	@echo "🖥️ Starting YABAI service..."
	@if [ -f "$(LAUNCHER)" ]; then \
		./$(LAUNCHER) start_yabai; \
	else \
		echo "❌ Launcher not found"; \
	fi

# Cleaning
clean: ## Clean build artifacts and cache
	@echo "🧹 Cleaning project..."
	rm -rf build/
	rm -rf dist/
	rm -rf *.egg-info/
	rm -rf .pytest_cache/
	rm -rf .mypy_cache/
	rm -rf htmlcov/
	rm -f .coverage
	rm -f coverage.xml
	find . -type d -name "__pycache__" -exec rm -rf {} +
	find . -type f -name "*.pyc" -delete
	@echo "✅ Clean complete!"

clean-venv: ## Remove virtual environment
	@echo "🗑️ Removing virtual environment..."
	rm -rf $(VENV_DIR)
	@echo "✅ Virtual environment removed!"

clean-logs: ## Clean log files
	@echo "🗑️ Cleaning log files..."
	rm -rf $(LOGS_DIR)/*
	@echo "✅ Logs cleaned!"

clean-data: ## Clean data files
	@echo "🗑️ Cleaning data files..."
	rm -rf $(DATA_DIR)/*
	@echo "✅ Data cleaned!"

# Deployment
deploy: ## Deploy NEXUS system
	@echo "🚀 Deploying NEXUS system..."
	@if [ -f "$(LAUNCHER)" ]; then \
		chmod +x "$(LAUNCHER)"; \
		./$(LAUNCHER) check_requirements; \
		./$(LAUNCHER) start_yabai; \
		echo "✅ Deployment complete!"; \
	else \
		echo "❌ Launcher not found"; \
	fi

# Documentation
docs: ## Build documentation
	@echo "📚 Building documentation..."
	@if [ -d "$(DOCS_DIR)" ]; then \
		echo "Documentation structure:"; \
		tree "$(DOCS_DIR)" -I "__pycache__"; \
	else \
		echo "❌ Documentation directory not found"; \
	fi

# Project information
info: ## Show project information
	@echo "🚀 NEXUS - Neural EXperience Unified System"
	@echo "Version: 0.1.0"
	@echo "Author: Eduardo Giovannini"
	@echo "License: MIT"
	@echo ""
	@echo "Project structure:"
	@tree -I "__pycache__|.git|.venv|*.pyc|*.pyo|*.pyd|.pytest_cache|.mypy_cache|htmlcov|build|dist|*.egg-info" -L 2

# Development workflow
dev-workflow: ## Complete development workflow
	@echo "🔄 Running complete development workflow..."
	make clean
	make dev
	make lint
	make test
	make pre-commit-run
	@echo "✅ Development workflow complete!"

# Quick start
quick-start: ## Quick start for development
	@echo "⚡ Quick start for development..."
	make setup
	make venv
	make install-dev-deps
	make pre-commit
	@echo "✅ Quick start complete! Run 'make test' to verify."

# Help for specific areas
help-mlx: ## Show MLX-related help
	@echo "🤖 MLX Integration Help:"
	@echo "  make install-mlx-deps  - Install MLX dependencies"
	@echo "  make mlx-test         - Test MLX integration"
	@echo "  make test-mlx         - Run MLX-specific tests"

help-n8n: ## Show N8N-related help
	@echo "⚙️ N8N Integration Help:"
	@echo "  make install-n8n-deps - Install N8N dependencies"
	@echo "  make n8n-start        - Start N8N service"
	@echo "  make test-n8n         - Run N8N-specific tests"

help-testing: ## Show testing help
	@echo "🧪 Testing Help:"
	@echo "  make test             - Run all tests"
	@echo "  make test-unit        - Run unit tests only"
	@echo "  make test-integration - Run integration tests only"
	@echo "  make test-mlx         - Run MLX tests"
	@echo "  make test-n8n         - Run N8N tests"
	@echo "  make test-yabai       - Run YABAI tests"

help-quality: ## Show code quality help
	@echo "🔍 Code Quality Help:"
	@echo "  make lint             - Run all quality checks"
	@echo "  make format           - Format code with black"
	@echo "  make type-check       - Run type checking"
	@echo "  make pre-commit       - Install pre-commit hooks"
	@echo "  make pre-commit-run   - Run pre-commit hooks"

# Default target
.DEFAULT_GOAL := help
