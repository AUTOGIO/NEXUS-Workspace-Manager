#!/bin/bash
# 🔍 NEXUS System Requirements Checker
# Checks what tools and dependencies are already installed on the system
# 
# Author: Eduardo Giovannini
# Version: 1.0.0

set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

print_banner() {
    echo -e "${PURPLE}"
    echo "╔══════════════════════════════════════════════════════════════╗"
    echo "║                    🔍 NEXUS System Checker                   ║"
    echo "║              Checking what's already installed               ║"
    echo "╚══════════════════════════════════════════════════════════════╝"
    echo -e "${NC}"
}

check_tool() {
    local tool_name="$1"
    local command="$2"
    local description="$3"
    
    if command -v "$command" >/dev/null 2>&1; then
        local version=$($command --version 2>/dev/null | head -n1 || echo "version unknown")
        echo -e "${GREEN}✓ $tool_name${NC} - $description"
        echo "  Version: $version"
        return 0
    else
        echo -e "${RED}✗ $tool_name${NC} - $description (NOT INSTALLED)"
        return 1
    fi
}

check_python_package() {
    local package_name="$1"
    local description="$2"
    
    if python3 -c "import $package_name" 2>/dev/null; then
        echo -e "${GREEN}✓ Python: $package_name${NC} - $description"
        return 0
    else
        echo -e "${RED}✗ Python: $package_name${NC} - $description (NOT INSTALLED)"
        return 1
    fi
}

echo "Starting system requirements check..."
echo "======================================"

# Check Python
echo -e "\n${BLUE}🐍 Python Environment:${NC}"
python3 --version 2>/dev/null && echo -e "${GREEN}✓ Python3${NC}" || echo -e "${RED}✗ Python3${NC}"

# Check package managers
echo -e "\n${BLUE}📦 Package Managers:${NC}"
check_tool "Homebrew" "brew" "macOS package manager"
check_tool "UV" "uv" "Python package manager"
check_tool "Pip" "pip3" "Python package installer"

# Check system tools
echo -e "\n${BLUE}🛠️  System Tools:${NC}"
check_tool "YABAI" "yabai" "Window manager for macOS"
check_tool "SKHD" "skhd" "Hotkey daemon for macOS"
check_tool "JQ" "jq" "JSON processor"
check_tool "WGET" "wget" "File downloader"
check_tool "CURL" "curl" "HTTP client"

# Check development tools
echo -e "\n${BLUE}🔧 Development Tools:${NC}"
check_tool "Git" "git" "Version control system"
check_tool "Make" "make" "Build automation tool"
check_tool "GCC" "gcc" "C compiler"
check_tool "Clang" "clang" "C/C++ compiler"

# Check macOS-specific tools
echo -e "\n${BLUE}🍎 macOS Tools:${NC}"
check_tool "Xcode Command Line Tools" "xcode-select" "Developer tools"
check_tool "System Integrity Protection" "csrutil" "Security feature"

# Check if BetterTouchTool is installed
echo -e "\n${BLUE}🎯 Automation Tools:${NC}"
if [ -d "/Applications/BetterTouchTool.app" ]; then
    echo -e "${GREEN}✓ BetterTouchTool${NC} - Gesture automation tool"
else
    echo -e "${RED}✗ BetterTouchTool${NC} - Gesture automation tool (NOT INSTALLED)"
fi

# Check if Keyboard Maestro is installed
if [ -d "/Applications/Keyboard Maestro.app" ]; then
    echo -e "${GREEN}✓ Keyboard Maestro${NC} - Macro automation tool"
else
    echo -e "${RED}✗ Keyboard Maestro${NC} - Macro automation tool (NOT INSTALLED)"
fi

# Check system info
echo -e "\n${BLUE}💻 System Information:${NC}"
echo "macOS Version: $(sw_vers -productVersion)"
echo "Architecture: $(uname -m)"
echo "Kernel: $(uname -r)"

# Check available Python packages
echo -e "\n${BLUE}🐍 Python Packages:${NC}"
check_python_package "streamlit" "Web dashboard framework"
check_python_package "pandas" "Data manipulation library"
check_python_package "numpy" "Numerical computing library"
check_python_package "plotly" "Interactive plotting library"

echo -e "\n${CYAN}System check completed!${NC}"
echo "Check the results above to see what needs to be installed."
