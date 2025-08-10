#!/bin/zsh

# 🧠 NEXUS Workspace Manager - SKHD Installer
# Installs and configures SKHD with NEXUS hotkey system

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'

echo "${BLUE}🧠 NEXUS Workspace Manager - SKHD Installer${NC}"
echo "=================================================="
echo ""

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"

# Function to check if Homebrew is installed
check_homebrew() {
    if ! command -v brew &> /dev/null; then
        echo "${RED}❌ Homebrew is not installed${NC}"
        echo "${YELLOW}Please install Homebrew first:${NC}"
        echo "  /bin/bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\""
        return 1
    else
        echo "${GREEN}✅ Homebrew is installed${NC}"
        return 0
    fi
}

# Function to install SKHD
install_skhd() {
    echo "${BLUE}📦 Installing SKHD...${NC}"
    
    if brew install skhd; then
        echo "${GREEN}✅ SKHD installed successfully${NC}"
        return 0
    else
        echo "${RED}❌ Failed to install SKHD${NC}"
        return 1
    fi
}

# Function to configure SKHD
configure_skhd() {
    echo "${BLUE}⚙️  Configuring SKHD...${NC}"
    
    local skhd_config="$HOME/.skhdrc"
    local nexus_config="$PROJECT_DIR/configs/skhd/skhdrc"
    
    # Backup existing config if it exists
    if [ -f "$skhd_config" ]; then
        echo "${YELLOW}📋 Backing up existing SKHD config...${NC}"
        cp "$skhd_config" "$skhd_config.backup.$(date +%Y%m%d_%H%M%S)"
        echo "${GREEN}✅ Backup created: $skhd_config.backup.$(date +%Y%m%d_%H%M%S)${NC}"
    fi
    
    # Copy NEXUS config
    if cp "$nexus_config" "$skhd_config"; then
        echo "${GREEN}✅ NEXUS SKHD configuration installed${NC}"
        return 0
    else
        echo "${RED}❌ Failed to install SKHD configuration${NC}"
        return 1
    fi
}

# Function to start SKHD service
start_skhd_service() {
    echo "${BLUE}🚀 Starting SKHD service...${NC}"
    
    if brew services start skhd; then
        echo "${GREEN}✅ SKHD service started${NC}"
        return 0
    else
        echo "${RED}❌ Failed to start SKHD service${NC}"
        return 1
    fi
}

# Function to test SKHD configuration
test_skhd_config() {
    echo "${BLUE}🧪 Testing SKHD configuration...${NC}"
    
    if skhd --print-config > /dev/null 2>&1; then
        echo "${GREEN}✅ SKHD configuration is valid${NC}"
        return 0
    else
        echo "${RED}❌ SKHD configuration has errors${NC}"
        echo "${YELLOW}Checking configuration file...${NC}"
        cat "$HOME/.skhdrc"
        return 1
    fi
}

# Function to show hotkey summary
show_hotkey_summary() {
    echo "${BLUE}🎯 NEXUS SKHD Hotkey Summary${NC}"
    echo "================================="
    echo ""
    echo "${GREEN}🚀 Workspace Profiles:${NC}"
    echo "  • Ctrl+Alt+Cmd+W: Work Profile"
    echo "  • Ctrl+Alt+Cmd+P: Personal Profile"
    echo "  • Ctrl+Alt+Cmd+R: AI Research Profile"
    echo "  • Ctrl+Alt+Cmd+F: Focus Profile"
    echo "  • Ctrl+Alt+Cmd+B: Business Profile"
    echo "  • Ctrl+Alt+Cmd+L: Learning Profile"
    echo "  • Ctrl+Alt+Cmd+G: Gaming Profile"
    echo "  • Ctrl+Alt+Cmd+C: Content Creation Profile"
    echo ""
    echo "${GREEN}🖥️  Display Management:${NC}"
    echo "  • Ctrl+Alt+Cmd+Arrow: Move windows between displays"
    echo "  • Ctrl+Alt+Cmd+1/2: Focus specific displays"
    echo ""
    echo "${GREEN}🪟 Window Management:${NC}"
    echo "  • Ctrl+Alt+Cmd+H/J/K/L: Focus windows"
    echo "  • Ctrl+Alt+Cmd+F: Toggle float"
    echo "  • Ctrl+Alt+Cmd+S: Toggle sticky"
    echo ""
    echo "${GREEN}🚀 NEXUS System:${NC}"
    echo "  • Ctrl+Alt+Cmd+D: Launch Dashboard"
    echo "  • Ctrl+Alt+Cmd+N: Launch NEXUS Launcher"
    echo "  • Ctrl+Alt+Cmd+A: Quick App Launcher"
    echo ""
    echo "${GREEN}🔧 Utilities:${NC}"
    echo "  • Ctrl+Alt+Shift+Y: Restart YABAI"
    echo "  • Ctrl+Alt+Shift+S: Restart SKHD"
    echo "  • Ctrl+Alt+Shift+R: Emergency Reset"
    echo ""
    echo "${YELLOW}💡 Tip: Use 'skhd --print-config' to see all active hotkeys${NC}"
}

# Function to show installation status
show_status() {
    echo "${BLUE}📊 Installation Status${NC}"
    echo "========================"
    
    # Check SKHD installation
    if command -v skhd &> /dev/null; then
        echo "${GREEN}✅ SKHD is installed${NC}"
    else
        echo "${RED}❌ SKHD is not installed${NC}"
    fi
    
    # Check SKHD service
    if brew services list | grep skhd | grep started > /dev/null; then
        echo "${GREEN}✅ SKHD service is running${NC}"
    else
        echo "${YELLOW}⚠️  SKHD service is not running${NC}"
    fi
    
    # Check configuration file
    if [ -f "$HOME/.skhdrc" ]; then
        echo "${GREEN}✅ SKHD configuration file exists${NC}"
    else
        echo "${RED}❌ SKHD configuration file not found${NC}"
    fi
    
    # Check YABAI
    if yabai -m query --displays >/dev/null 2>&1; then
        echo "${GREEN}✅ YABAI is running${NC}"
    else
        echo "${YELLOW}⚠️  YABAI is not running${NC}"
    fi
}

# Function to show help
show_help() {
    echo "${BLUE}📖 SKHD Installer Help${NC}"
    echo "========================="
    echo ""
    echo "${GREEN}Usage:${NC}"
    echo "  $0 [command]"
    echo ""
    echo "${GREEN}Commands:${NC}"
    echo "  install   - Install SKHD and configure NEXUS hotkeys"
    echo "  start     - Start SKHD service"
    echo "  stop      - Stop SKHD service"
    echo "  restart   - Restart SKHD service"
    echo "  status    - Show installation status"
    echo "  test      - Test SKHD configuration"
    echo "  hotkeys   - Show hotkey summary"
    echo "  help      - Show this help message"
    echo ""
    echo "${GREEN}Prerequisites:${NC}"
    echo "  • Homebrew installed"
    echo "  • YABAI running"
    echo "  • macOS with accessibility permissions"
    echo ""
    echo "${YELLOW}Note:${NC} After installation, you may need to grant accessibility permissions to SKHD"
}

# Main script
case "${1:-help}" in
    "install")
        echo "${GREEN}🚀 Installing SKHD with NEXUS configuration...${NC}"
        if check_homebrew && install_skhd && configure_skhd && start_skhd_service; then
            echo ""
            echo "${GREEN}🎉 SKHD installation completed successfully!${NC}"
            echo ""
            show_hotkey_summary
            echo ""
            echo "${YELLOW}⚠️  Important:${NC}"
            echo "1. Grant accessibility permissions to SKHD in System Preferences"
            echo "2. Test hotkeys with: $0 test"
            echo "3. View all hotkeys with: $0 hotkeys"
        else
            echo "${RED}❌ Installation failed${NC}"
            exit 1
        fi
        ;;
    "start")
        start_skhd_service
        ;;
    "stop")
        echo "${BLUE}🛑 Stopping SKHD service...${NC}"
        brew services stop skhd
        ;;
    "restart")
        echo "${BLUE}🔄 Restarting SKHD service...${NC}"
        brew services restart skhd
        ;;
    "status")
        show_status
        ;;
    "test")
        test_skhd_config
        ;;
    "hotkeys")
        show_hotkey_summary
        ;;
    "help"|*)
        show_help
        ;;
esac
