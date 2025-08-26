#!/bin/bash

echo "🔍 NEXUS System Requirements Checker"
echo "======================================"
echo ""

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m'

echo "🐍 Python Environment:"
python3 --version 2>/dev/null && echo -e "${GREEN}✓ Python3${NC}" || echo -e "${RED}✗ Python3${NC}"
echo ""

echo "📦 Package Managers:"
if command -v brew >/dev/null 2>&1; then
    echo -e "${GREEN}✓ Homebrew${NC} - $(brew --version | head -n1)"
else
    echo -e "${RED}✗ Homebrew${NC} - NOT INSTALLED"
fi

if command -v uv >/dev/null 2>&1; then
    echo -e "${GREEN}✓ UV${NC} - Python package manager"
else
    echo -e "${RED}✗ UV${NC} - NOT INSTALLED"
fi

if command -v pip3 >/dev/null 2>&1; then
    echo -e "${GREEN}✓ Pip3${NC} - Python package installer"
else
    echo -e "${RED}✗ Pip3${NC} - NOT INSTALLED"
fi
echo ""

echo "🛠️  System Tools:"
if command -v yabai >/dev/null 2>&1; then
    echo -e "${GREEN}✓ YABAI${NC} - Window manager"
else
    echo -e "${RED}✗ YABAI${NC} - NOT INSTALLED"
fi

if command -v skhd >/dev/null 2>&1; then
    echo -e "${GREEN}✓ SKHD${NC} - Hotkey daemon"
else
    echo -e "${RED}✗ SKHD${NC} - NOT INSTALLED"
fi

if command -v jq >/dev/null 2>&1; then
    echo -e "${GREEN}✓ JQ${NC} - JSON processor"
else
    echo -e "${RED}✗ JQ${NC} - NOT INSTALLED"
fi

if command -v curl >/dev/null 2>&1; then
    echo -e "${GREEN}✓ CURL${NC} - HTTP client"
else
    echo -e "${RED}✗ CURL${NC} - NOT INSTALLED"
fi
echo ""

echo "🔧 Development Tools:"
if command -v git >/dev/null 2>&1; then
    echo -e "${GREEN}✓ Git${NC} - Version control"
else
    echo -e "${RED}✗ Git${NC} - NOT INSTALLED"
fi

if command -v make >/dev/null 2>&1; then
    echo -e "${GREEN}✓ Make${NC} - Build automation"
else
    echo -e "${RED}✗ Make${NC} - NOT INSTALLED"
fi

if command -v gcc >/dev/null 2>&1; then
    echo -e "${GREEN}✓ GCC${NC} - C compiler"
else
    echo -e "${RED}✗ GCC${NC} - NOT INSTALLED"
fi
echo ""

echo "🍎 macOS Tools:"
if xcode-select -p >/dev/null 2>&1; then
    echo -e "${GREEN}✓ Xcode Command Line Tools${NC}"
else
    echo -e "${RED}✗ Xcode Command Line Tools${NC} - NOT INSTALLED"
fi

if csrutil status >/dev/null 2>&1; then
    echo -e "${GREEN}✓ System Integrity Protection${NC}"
else
    echo -e "${RED}✗ System Integrity Protection${NC} - NOT INSTALLED"
fi
echo ""

echo "🎯 Automation Tools:"
if [ -d "/Applications/BetterTouchTool.app" ]; then
    echo -e "${GREEN}✓ BetterTouchTool${NC} - Gesture automation"
else
    echo -e "${RED}✗ BetterTouchTool${NC} - NOT INSTALLED"
fi

if [ -d "/Applications/Keyboard Maestro.app" ]; then
    echo -e "${GREEN}✓ Keyboard Maestro${NC} - Macro automation"
else
    echo -e "${RED}✗ Keyboard Maestro${NC} - NOT INSTALLED"
fi
echo ""

echo "💻 System Information:"
echo "macOS Version: $(sw_vers -productVersion)"
echo "Architecture: $(uname -m)"
echo "Kernel: $(uname -r)"
echo ""

echo "🐍 Python Packages:"
python3 -c "import streamlit" 2>/dev/null && echo -e "${GREEN}✓ Streamlit${NC}" || echo -e "${RED}✗ Streamlit${NC}"
python3 -c "import pandas" 2>/dev/null && echo -e "${GREEN}✓ Pandas${NC}" || echo -e "${RED}✗ Pandas${NC}"
python3 -c "import numpy" 2>/dev/null && echo -e "${GREEN}✓ Numpy${NC}" || echo -e "${RED}✗ Numpy${NC}"
python3 -c "import plotly" 2>/dev/null && echo -e "${GREEN}✓ Plotly${NC}" || echo -e "${RED}✗ Plotly${NC}"
echo ""

echo "✅ System check completed!"
