# NEXUS - Neural EXperience Unified System
# Makefile for development and deployment

.PHONY: help install install-dev test lint format clean docs build deploy

# Default target
help:
	@echo "NEXUS - Neural EXperience Unified System"
	@echo "=========================================="
	@echo ""
	@echo "Available commands:"
	@echo "  install      - Install production dependencies"
	@echo "  install-dev  - Install development dependencies"
	@echo "  test         - Run tests with coverage"
	@echo "  lint         - Run linting and type checking"
	@echo "  format       - Format code with black and isort"
	@echo "  clean        - Clean build artifacts"
	@echo "  docs         - Build documentation"
	@echo "  build        - Build package"
	@echo "  deploy       - Deploy to production"
	@echo "  setup        - Initial project setup"
	@echo "  nexus        - Launch NEXUS main interface"
	@echo "  dashboard    - Launch Streamlit dashboard"
	@echo "  ai-test      - Test AI integration"
	@echo "  profile-test - Test workspace profiles"

# Installation
install:
	@echo "Installing production dependencies..."
	pip install -r requirements.txt

install-dev:
	@echo "Installing development dependencies..."
	pip install -r requirements-dev.txt
	pre-commit install

# Testing
test:
	@echo "Running tests..."
	pytest tests/ -v --cov=nexus --cov-report=html --cov-report=term-missing

test-fast:
	@echo "Running fast tests..."
	pytest tests/ -v -m "not slow"

test-integration:
	@echo "Running integration tests..."
	pytest tests/ -v -m "integration"

# Code Quality
lint:
	@echo "Running linting..."
	flake8 nexus/ tests/ --max-line-length=88 --extend-ignore=E203,W503
	mypy nexus/
	bandit -r nexus/ -f json -o bandit-report.json

format:
	@echo "Formatting code..."
	black nexus/ tests/ --line-length=88
	isort nexus/ tests/ --profile=black --line-length=88

format-check:
	@echo "Checking code formatting..."
	black nexus/ tests/ --check --line-length=88
	isort nexus/ tests/ --check-only --profile=black --line-length=88

# Documentation
docs:
	@echo "Building documentation..."
	cd docs && make html

docs-serve:
	@echo "Serving documentation..."
	cd docs/_build/html && python -m http.server 8000

# Build and Deploy
build:
	@echo "Building package..."
	python -m build

clean:
	@echo "Cleaning build artifacts..."
	rm -rf build/
	rm -rf dist/
	rm -rf *.egg-info/
	rm -rf htmlcov/
	rm -rf .coverage
	rm -rf .pytest_cache/
	rm -rf .mypy_cache/
	find . -type d -name "__pycache__" -exec rm -rf {} +
	find . -type f -name "*.pyc" -delete

# Development Setup
setup:
	@echo "Setting up NEXUS development environment..."
	@echo "1. Installing dependencies..."
	make install-dev
	@echo "2. Setting up pre-commit hooks..."
	pre-commit install
	@echo "3. Making scripts executable..."
	chmod +x *.sh scripts/*.sh configs/profiles/*.sh
	@echo "4. Creating necessary directories..."
	mkdir -p logs data
	@echo "5. Setting up YABAI..."
	yabai --start-service || echo "YABAI service already running"
	@echo "✅ NEXUS development environment ready!"

# NEXUS Commands
nexus:
	@echo "Launching NEXUS main interface..."
	./launcher.sh

dashboard:
	@echo "Launching Streamlit dashboard..."
	cd dashboard && streamlit run workspace_dashboard.py

ai-test:
	@echo "Testing AI integration..."
	python3 scripts/ai/ai_model_manager.py

profile-test:
	@echo "Testing workspace profiles..."
	@echo "Testing Work Profile..."
	./configs/profiles/work_profile.sh
	@echo "Testing Personal Profile..."
	./configs/profiles/personal_profile.sh
	@echo "Testing AI Research Profile..."
	./configs/profiles/ai_research_profile.sh

# System Commands
yabai-status:
	@echo "Checking YABAI status..."
	yabai -m query --displays

yabai-restart:
	@echo "Restarting YABAI service..."
	yabai --restart-service

system-check:
	@echo "Running system checks..."
	@echo "1. Checking YABAI..."
	yabai -m query --displays || echo "YABAI not running"
	@echo "2. Checking Python dependencies..."
	python3 -c "import streamlit, psutil, yaml, mlx" || echo "Missing dependencies"
	@echo "3. Checking model collection..."
	ls -la /Volumes/MICRO/models/ || echo "Model collection not found"
	@echo "4. Checking script permissions..."
	ls -la *.sh scripts/*.sh configs/profiles/*.sh

# Performance and Monitoring
benchmark:
	@echo "Running performance benchmarks..."
	python3 scripts/ai/ai_model_manager.py --benchmark

monitor:
	@echo "Starting system monitoring..."
	./scripts/analytics/screen_time_collector.sh monitor

# Git and Version Control
git-setup:
	@echo "Setting up Git hooks..."
	pre-commit install
	git config core.hooksPath .git/hooks

git-commit:
	@echo "Preparing commit..."
	make format
	make lint
	make test-fast
	@echo "✅ Ready for commit!"

# Docker (if needed)
docker-build:
	@echo "Building Docker image..."
	docker build -t nexus-workspace .

docker-run:
	@echo "Running NEXUS in Docker..."
	docker run -it --rm nexus-workspace

# CI/CD
ci-test:
	@echo "Running CI tests..."
	make format-check
	make lint
	make test
	make build

# Helpers
version:
	@echo "NEXUS Version: 2.0.0"
	@echo "Python Version: $(shell python3 --version)"
	@echo "YABAI Version: $(shell yabai --version 2>/dev/null || echo 'Not installed')"

status:
	@echo "NEXUS System Status"
	@echo "=================="
	@echo "YABAI: $(shell yabai -m query --displays >/dev/null 2>&1 && echo '✅ Running' || echo '❌ Not running')"
	@echo "Python: $(shell python3 --version)"
	@echo "Dependencies: $(shell python3 -c 'import streamlit, psutil, yaml' 2>/dev/null && echo '✅ Installed' || echo '❌ Missing')"
	@echo "Models: $(shell ls /Volumes/MICRO/models/ 2>/dev/null && echo '✅ Available' || echo '❌ Not found')"

# Development workflow
dev: setup
	@echo "Starting development workflow..."
	make nexus

# Production deployment
deploy: clean build
	@echo "Deploying NEXUS..."
	@echo "✅ NEXUS deployed successfully!"

# Quick start for new users
quickstart:
	@echo "NEXUS Quick Start"
	@echo "================"
	@echo "1. Installing dependencies..."
	make install
	@echo "2. Setting up system..."
	make setup
	@echo "3. Launching NEXUS..."
	make nexus
	@echo "✅ NEXUS ready to use!"
