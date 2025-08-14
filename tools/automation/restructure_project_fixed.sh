#!/bin/zsh

# 🏗️ NEXUS Project Restructuring Script (Fixed)
# Migrates the project to follow Python & DevOps best practices

set -e  # Exit on any error

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'

echo "${BLUE}🏗️  NEXUS Project Restructuring Script (Fixed)${NC}"
echo "====================================================="
echo ""

# Get the project root directory
PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
echo "Current directory: $(pwd)"
echo "Script directory: $(dirname "${BASH_SOURCE[0]}")"
echo "Project root: $PROJECT_ROOT"
cd "$PROJECT_ROOT"
echo "Changed to: $(pwd)"
echo ""

echo "${BLUE}📁 Project root: $PROJECT_ROOT${NC}"
echo ""

# Function to create directory if it doesn't exist
create_dir() {
    local dir="$1"
    if [ ! -d "$dir" ]; then
        mkdir -p "$dir"
        echo "${GREEN}✅ Created directory: $dir${NC}"
    else
        echo "${YELLOW}⚠️  Directory already exists: $dir${NC}"
    fi
}

# Function to copy file with backup
copy_file() {
    local src="$1"
    local dest="$2"
    
    if [ -f "$src" ]; then
        # Create backup
        local backup="${src}.backup.$(date +%Y%m%d_%H%M%S)"
        cp "$src" "$backup"
        echo "${YELLOW}📋 Created backup: $backup${NC}"
        
        # Copy file
        cp "$src" "$dest"
        echo "${GREEN}✅ Copied: $src → $dest${NC}"
    else
        echo "${RED}❌ Source file not found: $src${NC}"
    fi
}

echo "${BLUE}🔨 Creating new directory structure...${NC}"
echo ""

# Create new directory structure
create_dir "src/nexus"
create_dir "src/nexus/core"
create_dir "src/nexus/dashboard"
create_dir "src/nexus/profiles"
create_dir "src/nexus/profiles/profiles"
create_dir "src/nexus/integrations"
create_dir "src/nexus/analytics"
create_dir "src/nexus/utils"

create_dir "scripts/setup"
create_dir "scripts/maintenance"
create_dir "scripts/automation"

create_dir "tests/unit"
create_dir "tests/integration"
create_dir "tests/fixtures"

create_dir "data/analytics"
create_dir "data/cache"

create_dir "infra/docker"
create_dir "infra/kubernetes"
create_dir "infra/terraform"

create_dir "build/dist"
create_dir "build/wheels"

create_dir "tools/pre-commit"
create_dir "tools/linting"
create_dir "tools/formatting"

create_dir "requirements"

echo ""
echo "${BLUE}📦 Copying Python files to new structure...${NC}"
echo ""

# Copy Python files to new structure
if [ -f "src/nexus/dashboard/interactive_dashboard.py" ]; then
    echo "${GREEN}✅ Dashboard already in place${NC}"
elif [ -f "dashboard/interactive_guide.py" ]; then
    copy_file "dashboard/interactive_guide.py" "src/nexus/dashboard/interactive_dashboard.py"
else
    echo "${YELLOW}⚠️  Dashboard file not found${NC}"
fi

if [ -f "src/nexus/core/ai_model_manager.py" ]; then
    echo "${GREEN}✅ AI model manager already in place${NC}"
elif [ -f "src/nexus/core/ai_model_manager.py" ]; then
    echo "${GREEN}✅ AI model manager already in place${NC}"
else
    echo "${YELLOW}⚠️  AI model manager not found${NC}"
fi

if [ -f "src/nexus/core/dynamic_layout_manager.py" ]; then
    echo "${GREEN}✅ Dynamic layout manager already in place${NC}"
elif [ -f "src/nexus/core/dynamic_layout_manager.py" ]; then
    echo "${GREEN}✅ Dynamic layout manager already in place${NC}"
else
    echo "${YELLOW}⚠️  Dynamic layout manager not found${NC}"
fi

echo ""
echo "${BLUE}📋 Moving configuration files...${NC}"
echo ""

# Move configuration files
if [ -d "configs" ]; then
    echo "${GREEN}✅ Configs directory already in place${NC}"
else
    echo "${YELLOW}⚠️  Configs directory not found${NC}"
fi

echo ""
echo "${BLUE}📚 Moving documentation...${NC}"
echo ""

# Move documentation files
if [ -f "docs/SHORTCUTS_REFERENCE.md" ]; then
    echo "${GREEN}✅ Shortcuts reference already in place${NC}"
else
    echo "${YELLOW}⚠️  Shortcuts reference not found${NC}"
fi

if [ -f "docs/PROJECT_STRUCTURE_BEST_PRACTICES.md" ]; then
    echo "${GREEN}✅ Project structure guide already in place${NC}"
else
    echo "${YELLOW}⚠️  Project structure guide not found${NC}"
fi

echo ""
echo "${BLUE}🔧 Creating __init__.py files...${NC}"
echo ""

# Create __init__.py files for Python packages
touch "src/nexus/__init__.py"
touch "src/nexus/core/__init__.py"
touch "src/nexus/dashboard/__init__.py"
touch "src/nexus/profiles/__init__.py"
touch "src/nexus/integrations/__init__.py"
touch "src/nexus/analytics/__init__.py"
touch "src/nexus/utils/__init__.py"

echo "${GREEN}✅ Created __init__.py files${NC}"

echo ""
echo "${BLUE}📋 Moving requirements files...${NC}"
echo ""

# Move requirements files
if [ -f "requirements.txt" ]; then
    copy_file "requirements.txt" "requirements/requirements.txt"
fi

if [ -f "requirements-dev.txt" ]; then
    copy_file "requirements-dev.txt" "requirements/requirements-dev.txt"
fi

# Create requirements-test.txt
echo "# Testing dependencies for NEXUS Workspace Manager" > "requirements/requirements-test.txt"
echo "pytest>=7.0.0" >> "requirements/requirements-test.txt"
echo "pytest-cov>=4.0.0" >> "requirements/requirements-test.txt"
echo "pytest-mock>=3.10.0" >> "requirements/requirements-test.txt"
echo "${GREEN}✅ Created requirements-test.txt${NC}"

echo ""
echo "${BLUE}🔧 Creating setup.py for Python packaging...${NC}"
echo ""

# Create setup.py for Python packaging
cat > "setup.py" << 'EOF'
#!/usr/bin/env python3
"""
NEXUS - Neural EXperience Unified System
AI-Powered Workspace Intelligence for Apple Silicon
"""

from setuptools import setup, find_packages

with open("README.md", "r", encoding="utf-8") as fh:
    long_description = fh.read()

with open("requirements/requirements.txt", "r", encoding="utf-8") as fh:
    requirements = [line.strip() for line in fh if line.strip() and not line.startswith("#")]

setup(
    name="nexus-workspace-manager",
    version="3.0.0",
    author="NEXUS Team",
    author_email="team@nexus-workspace.com",
    description="AI-Powered Workspace Intelligence for Apple Silicon",
    long_description=long_description,
    long_description_content_type="text/markdown",
    url="https://github.com/yourusername/NEXUS",
    packages=find_packages(where="src"),
    package_dir={"": "src"},
    classifiers=[
        "Development Status :: 4 - Beta",
        "Intended Audience :: Developers",
        "License :: OSI Approved :: MIT License",
        "Operating System :: MacOS",
        "Programming Language :: Python :: 3",
        "Programming Language :: Python :: 3.8",
        "Programming Language :: Python :: 3.9",
        "Programming Language :: Python :: 3.10",
        "Programming Language :: Python :: 3.11",
        "Topic :: Desktop Environment",
        "Topic :: System :: Systems Administration",
    ],
    python_requires=">=3.8",
    install_requires=requirements,
    extras_require={
        "dev": [
            line.strip() for line in open("requirements/requirements-dev.txt")
            if line.strip() and not line.startswith("#")
        ],
        "test": [
            line.strip() for line in open("requirements/requirements-test.txt")
            if line.strip() and not line.startswith("#")
        ],
    },
    entry_points={
        "console_scripts": [
            "nexus=nexus.cli:main",
        ],
    },
    include_package_data=True,
    zip_safe=False,
)
EOF

echo "${GREEN}✅ Created setup.py${NC}"

echo ""
echo "${BLUE}🔧 Creating pyproject.toml...${NC}"
echo ""

# Update pyproject.toml
cat > "pyproject.toml" << 'EOF'
[build-system]
requires = ["setuptools>=45", "wheel", "setuptools_scm[toml]>=6.2"]
build-backend = "setuptools.build_meta"

[project]
name = "nexus-workspace-manager"
dynamic = ["version"]
description = "AI-Powered Workspace Intelligence for Apple Silicon"
readme = "README.md"
license = {text = "MIT"}
authors = [
    {name = "NEXUS Team", email = "team@nexus-workspace.com"}
]
maintainers = [
    {name = "NEXUS Team", email = "team@nexus-workspace.com"}
]
keywords = ["workspace", "productivity", "ai", "macos", "yabai"]
classifiers = [
    "Development Status :: 4 - Beta",
    "Intended Audience :: Developers",
    "License :: OSI Approved :: MIT License",
    "Operating System :: MacOS",
    "Programming Language :: Python :: 3",
    "Programming Language :: Python :: 3.8",
    "Programming Language :: Python :: 3.9",
    "Programming Language :: Python :: 3.10",
    "Programming Language :: Python :: 3.11",
    "Topic :: Desktop Environment",
    "Topic :: System :: Systems Administration",
]
requires-python = ">=3.8"
dependencies = [
    "streamlit>=1.28.0",
    "pandas>=1.5.0",
    "numpy>=1.21.0",
    "matplotlib>=3.5.0",
    "seaborn>=0.11.0",
    "plotly>=5.0.0",
    "psutil>=5.9.0",
    "pyyaml>=6.0",
    "click>=8.0.0",
    "rich>=13.0.0",
]

[project.optional-dependencies]
dev = [
    "pytest>=7.0.0",
    "pytest-cov>=4.0.0",
    "pytest-mock>=3.10.0",
    "black>=23.0.0",
    "flake8>=6.0.0",
    "mypy>=1.0.0",
    "pre-commit>=3.0.0",
]
test = [
    "pytest>=7.0.0",
    "pytest-cov>=4.0.0",
    "pytest-mock>=3.10.0",
]

[project.scripts]
nexus = "nexus.cli:main"

[project.urls]
Homepage = "https://github.com/yourusername/NEXUS"
Documentation = "https://github.com/yourusername/NEXUS#readme"
Repository = "https://github.com/yourusername/NEXUS.git"
"Bug Tracker" = "https://github.com/yourusername/NEXUS/issues"

[tool.setuptools]
package-dir = {"" = "src"}

[tool.setuptools.packages.find]
where = ["src"]

[tool.black]
line-length = 88
target-version = ['py38', 'py39', 'py310', 'py311']
include = '\.pyi?$'
extend-exclude = '''
/(
  # directories
  \.eggs
  | \.git
  | \.hg
  | \.mypy_cache
  | \.tox
  | \.venv
  | build
  | dist
)/
'''

[tool.pytest.ini_options]
minversion = "6.0"
addopts = "-ra -q --strict-markers --strict-config"
testpaths = ["tests"]
python_files = ["test_*.py", "*_test.py"]
python_classes = ["Test*"]
python_functions = ["test_*"]

[tool.coverage.run]
source = ["src"]
omit = [
    "*/tests/*",
    "*/test_*",
    "*/__pycache__/*",
    "*/venv/*",
    "*/env/*",
]

[tool.coverage.report]
exclude_lines = [
    "pragma: no cover",
    "def __repr__",
    "if self.debug:",
    "if settings.DEBUG",
    "raise AssertionError",
    "raise NotImplementedError",
    "if 0:",
    "if __name__ == .__main__.:",
    "class .*\\bProtocol\\):",
    "@(abc\\.)?abstractmethod",
]
EOF

echo "${GREEN}✅ Updated pyproject.toml${NC}"

echo ""
echo "${BLUE}🔧 Creating Makefile targets...${NC}"
echo ""

# Add new targets to Makefile
cat >> "Makefile" << 'EOF'

# =============================================================================
# 🏗️  PROJECT RESTRUCTURING TARGETS
# =============================================================================

.PHONY: restructure install-dev install-test build-package clean-build

restructure: ## Restructure project to follow best practices
	@echo "🏗️  Restructuring project..."
	@./scripts/restructure_project_fixed.sh

install-dev: ## Install development dependencies
	@echo "📦 Installing development dependencies..."
	@pip install -e ".[dev]"

install-test: ## Install testing dependencies
	@echo "🧪 Installing testing dependencies..."
	@pip install -e ".[test]"

build-package: ## Build Python package
	@echo "📦 Building Python package..."
	@python -m build

clean-build: ## Clean build artifacts
	@echo "🧹 Cleaning build artifacts..."
	@rm -rf build/ dist/ *.egg-info/
	@find . -type d -name __pycache__ -delete
	@find . -type f -name "*.pyc" -delete

# =============================================================================
# 🧪 TESTING TARGETS
# =============================================================================

.PHONY: test test-unit test-integration test-cov

test: ## Run all tests
	@echo "🧪 Running all tests..."
	@pytest

test-unit: ## Run unit tests only
	@echo "🧪 Running unit tests..."
	@pytest tests/unit/

test-integration: ## Run integration tests only
	@echo "🧪 Running integration tests..."
	@pytest tests/integration/

test-cov: ## Run tests with coverage
	@echo "🧪 Running tests with coverage..."
	@pytest --cov=src/nexus --cov-report=html --cov-report=term

# =============================================================================
# 🔧 CODE QUALITY TARGETS
# =============================================================================

.PHONY: format lint type-check

format: ## Format code with black
	@echo "🎨 Formatting code..."
	@black src/ tests/

lint: ## Lint code with flake8
	@echo "🔍 Linting code..."
	@flake8 src/ tests/

type-check: ## Type check with mypy
	@echo "🔍 Type checking..."
	@mypy src/

quality: format lint type-check ## Run all quality checks
EOF

echo "${GREEN}✅ Added new Makefile targets${NC}"

echo ""
echo "${BLUE}🔧 Creating pre-commit configuration...${NC}"
echo ""

# Create pre-commit configuration
cat > ".pre-commit-config.yaml" << 'EOF'
repos:
  - repo: https://github.com/pre-commit/pre-commit-hooks
    rev: v4.4.0
    hooks:
      - id: trailing-whitespace
      - id: end-of-file-fixer
      - id: check-yaml
      - id: check-added-large-files
      - id: check-merge-conflict
      - id: debug-statements

  - repo: https://github.com/psf/black
    rev: 23.3.0
    hooks:
      - id: black
        language_version: python3

  - repo: https://github.com/pycqa/flake8
    rev: 6.0.0
    hooks:
      - id: flake8
        additional_dependencies: [flake8-docstrings]

  - repo: https://github.com/pre-commit/mirrors-mypy
    rev: v1.3.0
    hooks:
      - id: mypy
        additional_dependencies: [types-all]
        exclude: ^tests/

  - repo: https://github.com/pycqa/isort
    rev: 5.12.0
    hooks:
      - id: isort
        args: ["--profile", "black"]

  - repo: https://github.com/asottile/pyupgrade
    rev: v3.3.1
    hooks:
      - id: pyupgrade
        args: [--py38-plus]
EOF

echo "${GREEN}✅ Created pre-commit configuration${NC}"

echo ""
echo "${BLUE}🔧 Creating Docker configuration...${NC}"
echo ""

# Create Dockerfile
cat > "infra/docker/Dockerfile" << 'EOF'
FROM python:3.11-slim

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
ENV PYTHONPATH=/app/src

# Set work directory
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements
COPY requirements/requirements.txt /app/requirements.txt

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy source code
COPY src/ /app/src/
COPY configs/ /app/configs/

# Create non-root user
RUN useradd --create-home --shell /bin/bash nexus
USER nexus

# Expose port for Streamlit
EXPOSE 8501

# Default command
CMD ["streamlit", "run", "src/nexus/dashboard/interactive_dashboard.py", "--server.port=8501", "--server.address=0.0.0.0"]
EOF

echo "${GREEN}✅ Created Dockerfile${NC}"

# Create docker-compose.yml
cat > "infra/docker/docker-compose.yml" << 'EOF'
version: '3.8'

services:
  nexus:
    build: .
    ports:
      - "8501:8501"
    volumes:
      - ../configs:/app/configs:ro
      - ../data:/app/data
    environment:
      - PYTHONPATH=/app/src
    restart: unless-stopped

  nexus-dev:
    build: .
    ports:
      - "8502:8501"
    volumes:
      - ../src:/app/src
      - ../configs:/app/configs:ro
      - ../data:/app/data
    environment:
      - PYTHONPATH=/app/src
      - ENVIRONMENT=development
    restart: unless-stopped
EOF

echo "${GREEN}✅ Created docker-compose.yml${NC}"

echo ""
echo "${BLUE}🔧 Creating CI/CD configuration...${NC}"
echo ""

# Create GitHub Actions workflow
mkdir -p ".github/workflows"
cat > ".github/workflows/ci.yml" << 'EOF'
name: CI/CD Pipeline

on:
  push:
    branches: [ main, develop ]
  pull_request:
    branches: [ main, develop ]

jobs:
  test:
    runs-on: ubuntu-latest
    strategy:
      matrix:
        python-version: [3.8, 3.9, 3.10, 3.11]

    steps:
    - uses: actions/checkout@v3
    
    - name: Set up Python ${{ matrix.python-version }}
      uses: actions/setup-python@v4
      with:
        python-version: ${{ matrix.python-version }}
    
    - name: Install dependencies
      run: |
        python -m pip install --upgrade pip
        pip install -r requirements/requirements-dev.txt
        pip install -e .
    
    - name: Run tests
      run: |
        pytest --cov=src/nexus --cov-report=xml
    
    - name: Upload coverage to Codecov
      uses: codecov/codecov-action@v3
      with:
        file: ./coverage.xml

  quality:
    runs-on: ubuntu-latest
    
    steps:
    - uses: actions/checkout@v3
    
    - name: Set up Python
      uses: actions/setup-python@v4
      with:
        python-version: 3.11
    
    - name: Install dependencies
      run: |
        python -m pip install --upgrade pip
        pip install -r requirements/requirements-dev.txt
        pip install -e .
    
    - name: Run code quality checks
      run: |
        black --check src/ tests/
        flake8 src/ tests/
        mypy src/
EOF

echo "${GREEN}✅ Created CI/CD configuration${NC}"

echo ""
echo "${BLUE}📋 Creating project documentation...${NC}"
echo ""

# Create project documentation
cat > "docs/DEVELOPMENT.md" << 'EOF'
# 🚀 Development Guide

## Setup Development Environment

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/NEXUS.git
   cd NEXUS
   ```

2. **Install development dependencies**
   ```bash
   make install-dev
   ```

3. **Install pre-commit hooks**
   ```bash
   pre-commit install
   ```

## Development Workflow

1. **Create a feature branch**
   ```bash
   git checkout -b feature/your-feature-name
   ```

2. **Make your changes**
   - Follow the coding standards
   - Add tests for new functionality
   - Update documentation

3. **Run quality checks**
   ```bash
   make quality
   ```

4. **Run tests**
   ```bash
   make test
   ```

5. **Commit your changes**
   ```bash
   git add .
   git commit -m "feat: add your feature description"
   ```

6. **Push and create a pull request**
   ```bash
   git push origin feature/your-feature-name
   ```

## Code Standards

- **Formatting**: Use Black for code formatting
- **Linting**: Use Flake8 for code linting
- **Type Checking**: Use MyPy for type checking
- **Testing**: Use pytest for testing

## Project Structure

See [PROJECT_STRUCTURE_BEST_PRACTICES.md](PROJECT_STRUCTURE_BEST_PRACTICES.md) for details.
EOF

echo "${GREEN}✅ Created development guide${NC}"

echo ""
echo "${BLUE}🎉 Project restructuring complete!${NC}"
echo ""
echo "${GREEN}✅ What was created:${NC}"
echo "  📁 New directory structure following Python best practices"
echo "  📦 Python package configuration (setup.py, pyproject.toml)"
echo "  🧪 Testing framework setup"
echo "  🔧 Code quality tools (pre-commit, black, flake8, mypy)"
echo "  🐳 Docker configuration"
echo "  🚀 CI/CD pipeline setup"
echo "  📚 Comprehensive documentation"
echo ""
echo "${BLUE}🚀 Next steps:${NC}"
echo "  1. Review the new structure"
echo "  2. Install development dependencies: make install-dev"
echo "  3. Install pre-commit hooks: pre-commit install"
echo "  4. Run tests: make test"
echo "  5. Start developing!"
echo ""
echo "${YELLOW}📋 Note: Original files have been backed up with .backup.YYYYMMDD_HHMMSS${NC}"
echo "${YELLOW}📋 You can review and delete backups once you're satisfied with the new structure${NC}"
