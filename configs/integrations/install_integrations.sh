#!/bin/zsh

# YABAI Workspace Manager - Integration Installer
# Installs Keyboard Maestro, BetterTouchTool, and Raycast integrations

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'

echo "${BLUE}🎯 YABAI Workspace Manager - Integration Installer${NC}"
echo "======================================================"
echo ""

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"

# Function to check if an application is installed
check_app_installed() {
    local app_name=$1
    local app_path=$2
    
    if [ -d "$app_path" ]; then
        echo "${GREEN}✅ $app_name is installed${NC}"
        return 0
    else
        echo "${YELLOW}⚠️  $app_name is not installed${NC}"
        return 1
    fi
}

# Function to install Keyboard Maestro macros
install_keyboard_maestro() {
    echo "${BLUE}📱 Installing Keyboard Maestro Macros...${NC}"
    
    local km_dir="$HOME/Library/Application Support/Keyboard Maestro/Keyboard Maestro Macros"
    
    if [ -d "$km_dir" ]; then
        # Copy the macro file
        cp "$SCRIPT_DIR/keyboard_maestro_macros.kmmacros" "$km_dir/"
        echo "${GREEN}✅ Keyboard Maestro macros installed${NC}"
        echo "${YELLOW}📋 Hotkeys configured:${NC}"
        echo "  • Ctrl+Alt+Cmd+W: Load Work Profile"
        echo "  • Ctrl+Alt+Cmd+P: Load Personal Profile"
        echo "  • Ctrl+Alt+Cmd+R: Load AI Research Profile"
        echo "  • Ctrl+Alt+Cmd+Space: Quick Window Management"
    else
        echo "${RED}❌ Keyboard Maestro directory not found${NC}"
        echo "${YELLOW}Please install Keyboard Maestro first${NC}"
    fi
}

# Function to install BetterTouchTool preset
install_bettertouchtool() {
    echo "${BLUE}👆 Installing BetterTouchTool Preset...${NC}"
    
    local btt_dir="$HOME/Library/Application Support/BetterTouchTool"
    
    if [ -d "$btt_dir" ]; then
        # Copy the preset file
        cp "$SCRIPT_DIR/bettertouchtool_preset.bttpreset" "$btt_dir/"
        echo "${GREEN}✅ BetterTouchTool preset installed${NC}"
        echo "${YELLOW}👆 Gestures configured:${NC}"
        echo "  • Three Finger Swipe Up: Mission Control"
        echo "  • Four Finger Tap: Rotate Layout"
        echo "  • Two Finger Swipe Left: Next Display"
        echo "  • Two Finger Swipe Right: Previous Display"
    else
        echo "${RED}❌ BetterTouchTool directory not found${NC}"
        echo "${YELLOW}Please install BetterTouchTool first${NC}"
    fi
}

# Function to install Raycast extension
install_raycast_extension() {
    echo "${BLUE}🚀 Installing Raycast Extension...${NC}"
    
    local raycast_dir="$HOME/.raycast/extensions"
    
    if [ -d "$raycast_dir" ]; then
        # Create extension directory
        local extension_dir="$raycast_dir/yabai-workspace-manager"
        mkdir -p "$extension_dir"
        
        # Copy extension files
        cp "$SCRIPT_DIR/raycast_yabai_extension/index.tsx" "$extension_dir/"
        cp "$SCRIPT_DIR/raycast_yabai_extension/package.json" "$extension_dir/"
        
        echo "${GREEN}✅ Raycast extension installed${NC}"
        echo "${YELLOW}🔍 Search for 'YABAI Workspace Manager' in Raycast${NC}"
    else
        echo "${RED}❌ Raycast extensions directory not found${NC}"
        echo "${YELLOW}Please install Raycast first${NC}"
    fi
}

# Function to create skhd configuration
install_skhd_config() {
    echo "${BLUE}⌨️  Installing skhd Configuration...${NC}"
    
    local skhd_config="$HOME/.skhdrc"
    
    # Create skhd config if it doesn't exist
    if [ ! -f "$skhd_config" ]; then
        touch "$skhd_config"
    fi
    
    # Add YABAI workspace shortcuts
    cat >> "$skhd_config" << 'EOF'

# YABAI Workspace Manager Shortcuts
# Workspace Profiles
ctrl + alt + cmd - w : /bin/zsh -c "cd $HOME/Desktop/YABAI && source workspace_profiles/work_profile.sh"
ctrl + alt + cmd - p : /bin/zsh -c "cd $HOME/Desktop/YABAI && source workspace_profiles/personal_profile.sh"
ctrl + alt + cmd - r : /bin/zsh -c "cd $HOME/Desktop/YABAI && source workspace_profiles/ai_research_profile.sh"

# Window Management
ctrl + alt + cmd - left  : yabai -m window --display prev
ctrl + alt + cmd - right : yabai -m window --display next
ctrl + alt + cmd - up    : yabai -m window --display 1
ctrl + alt + cmd - down  : yabai -m window --display 2

# Space Management
ctrl + alt + cmd - 1 : yabai -m space --focus 1
ctrl + alt + cmd - 2 : yabai -m space --focus 2
ctrl + alt + cmd - 3 : yabai -m space --focus 3
ctrl + alt + cmd - 4 : yabai -m space --focus 4
ctrl + alt + cmd - 5 : yabai -m space --focus 5
ctrl + alt + cmd - 6 : yabai -m space --focus 6

# Layout Controls
ctrl + alt + cmd - f : yabai -m window --toggle float
ctrl + alt + cmd - s : yabai -m space --rotate 90
ctrl + alt + cmd - b : yabai -m space --mirror y-axis
EOF
    
    echo "${GREEN}✅ skhd configuration updated${NC}"
    echo "${YELLOW}⌨️  Hotkeys configured:${NC}"
    echo "  • Ctrl+Alt+Cmd+W: Work Profile"
    echo "  • Ctrl+Alt+Cmd+P: Personal Profile"
    echo "  • Ctrl+Alt+Cmd+R: AI Research Profile"
    echo "  • Ctrl+Alt+Cmd+Arrow: Move windows between displays"
    echo "  • Ctrl+Alt+Cmd+1-6: Focus spaces"
    echo "  • Ctrl+Alt+Cmd+F: Toggle float"
    echo "  • Ctrl+Alt+Cmd+S: Rotate layout"
    
    # Restart skhd if it's running
    if pgrep -x "skhd" > /dev/null; then
        echo "${YELLOW}🔄 Restarting skhd...${NC}"
        brew services restart skhd
    fi
}

# Function to show installation status
show_status() {
    echo "${BLUE}📊 Installation Status${NC}"
    echo "========================"
    
    # Check applications
    check_app_installed "Keyboard Maestro" "/Applications/Keyboard Maestro.app"
    check_app_installed "BetterTouchTool" "/Applications/BetterTouchTool.app"
    check_app_installed "Raycast" "/Applications/Raycast.app"
    
    # Check YABAI
    if yabai -m query --displays >/dev/null 2>&1; then
        echo "${GREEN}✅ YABAI is running${NC}"
    else
        echo "${YELLOW}⚠️  YABAI is not running${NC}"
    fi
    
    # Check skhd
    if pgrep -x "skhd" > /dev/null; then
        echo "${GREEN}✅ skhd is running${NC}"
    else
        echo "${YELLOW}⚠️  skhd is not running${NC}"
    fi
}

# Function to show help
show_help() {
    echo "${BLUE}📖 Integration Installer Help${NC}"
    echo "================================"
    echo ""
    echo "${GREEN}Usage:${NC}"
    echo "  $0 [command]"
    echo ""
    echo "${GREEN}Commands:${NC}"
    echo "  all        - Install all integrations"
    echo "  km         - Install Keyboard Maestro macros"
    echo "  btt        - Install BetterTouchTool preset"
    echo "  raycast    - Install Raycast extension"
    echo "  skhd       - Install skhd configuration"
    echo "  status     - Show installation status"
    echo "  help       - Show this help message"
    echo ""
    echo "${GREEN}Prerequisites:${NC}"
    echo "  • Keyboard Maestro (optional)"
    echo "  • BetterTouchTool (optional)"
    echo "  • Raycast (optional)"
    echo "  • skhd: brew install skhd"
    echo "  • YABAI: brew install yabai"
    echo ""
    echo "${YELLOW}Note:${NC} Install the applications first, then run this installer"
}

# Main script
case "${1:-help}" in
    "all")
        echo "${GREEN}🚀 Installing all integrations...${NC}"
        install_keyboard_maestro
        install_bettertouchtool
        install_raycast_extension
        install_skhd_config
        show_status
        ;;
    "km")
        install_keyboard_maestro
        ;;
    "btt")
        install_bettertouchtool
        ;;
    "raycast")
        install_raycast_extension
        ;;
    "skhd")
        install_skhd_config
        ;;
    "status")
        show_status
        ;;
    "help"|*)
        show_help
        ;;
esac 