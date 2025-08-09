#!/bin/zsh

# YABAI Workspace Manager - Interactive Guide Launcher
# Launches the interactive Streamlit-based user guide

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'

echo "${BLUE}🎯 YABAI Workspace Manager - Interactive Guide${NC}"
echo "=================================================="
echo ""

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Check if Streamlit is installed
if ! command -v streamlit &> /dev/null; then
    echo "${YELLOW}⚠️  Streamlit not found. Installing dependencies...${NC}"
    
    # Install Python dependencies
    if [ -f "$SCRIPT_DIR/dashboard/requirements.txt" ]; then
        pip install -r "$SCRIPT_DIR/dashboard/requirements.txt"
    else
        pip install streamlit pandas plotly pyyaml psutil
    fi
fi

# Check if the interactive guide exists
if [ ! -f "$SCRIPT_DIR/dashboard/interactive_guide.py" ]; then
    echo "${RED}❌ Interactive guide not found at $SCRIPT_DIR/dashboard/interactive_guide.py${NC}"
    exit 1
fi

echo "${GREEN}✅ Launching Interactive User Guide...${NC}"
echo ""
echo "${YELLOW}📖 The interactive guide will open in your browser${NC}"
echo "${YELLOW}🔧 You can test features and check system status${NC}"
echo "${YELLOW}🚀 Use the sidebar to navigate between sections${NC}"
echo ""

# Change to the dashboard directory and launch
cd "$SCRIPT_DIR/dashboard"
streamlit run interactive_guide.py

echo ""
echo "${GREEN}✅ Interactive guide closed${NC}" 