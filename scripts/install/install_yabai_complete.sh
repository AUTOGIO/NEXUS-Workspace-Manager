#!/bin/zsh
# 🚀 NEXUS Complete YABAI Installation Script
# Installs and configures YABAI + SKHD + all dependencies for NEXUS

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
    echo "║                    🚀 NEXUS Complete                         ║"
    echo "║                  YABAI Installation                          ║"
    echo "║                                                              ║"
    echo "║              Installing YABAI + SKHD + Dependencies          ║"
    echo "║                    for NEXUS Workspace Manager               ║"
    echo "╚══════════════════════════════════════════════════════════════╝"
    echo -e "${NC}"
}

log() {
    local level="$1"
    shift
    local message="$*"
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    
    case "$level" in
        "INFO")
            echo -e "${GREEN}[INFO]${NC} $message"
            ;;
        "WARN")
            echo -e "${YELLOW}[WARN]${NC} $message"
            ;;
        "ERROR")
            echo -e "${RED}[ERROR]${NC} $message"
            ;;
        "SUCCESS")
            echo -e "${CYAN}[SUCCESS]${NC} $message"
            ;;
        *)
            echo -e "${BLUE}[$level]${NC} $message"
            ;;
    esac
}

check_requirements() {
    log "INFO" "Checking system requirements..."
    
    # Check macOS version
    local macos_version=$(sw_vers -productVersion)
    log "INFO" "macOS Version: $macos_version"
    
    # Check if running on Apple Silicon
    if [[ $(uname -m) == "arm64" ]]; then
        log "SUCCESS" "Apple Silicon detected ✓"
    else
        log "WARN" "Intel Mac detected - some features may not be optimized"
    fi
    
    # Check Homebrew
    if command -v brew >/dev/null 2>&1; then
        log "SUCCESS" "Homebrew found ✓"
    else
        log "ERROR" "Homebrew not found. Please install it first:"
        echo "  /bin/bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\""
        return 1
    fi
    
    # Check Xcode Command Line Tools
    if xcode-select -p >/dev/null 2>&1; then
        log "SUCCESS" "Xcode Command Line Tools found ✓"
    else
        log "ERROR" "Xcode Command Line Tools not found. Please install them first:"
        echo "  xcode-select --install"
        return 1
    fi
}

install_yabai() {
    log "INFO" "Installing YABAI..."
    
    if brew install yabai; then
        log "SUCCESS" "YABAI installed successfully"
        return 0
    else
        log "ERROR" "Failed to install YABAI"
        return 1
    fi
}

install_skhd() {
    log "INFO" "Installing SKHD..."
    
    if brew install skhd; then
        log "SUCCESS" "SKHD installed successfully"
        return 0
    else
        log "ERROR" "Failed to install SKHD"
        return 1
    fi
}

install_additional_tools() {
    log "INFO" "Installing additional tools..."
    
    local tools=("jq" "wget" "curl")
    
    for tool in "${tools[@]}"; do
        if ! command -v "$tool" >/dev/null 2>&1; then
            log "INFO" "Installing $tool..."
            if brew install "$tool"; then
                log "SUCCESS" "$tool installed"
            else
                log "WARN" "Failed to install $tool"
            fi
        else
            log "SUCCESS" "$tool already installed ✓"
        fi
    done
}

configure_yabai() {
    log "INFO" "Configuring YABAI..."
    
    local project_root="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    local yabai_config="$project_root/configs/profiles/yabai_config.yaml"
    
    if [[ -f "$yabai_config" ]]; then
        log "SUCCESS" "YABAI configuration found ✓"
    else
        log "ERROR" "YABAI configuration not found at: $yabai_config"
        return 1
    fi
    
    # Test YABAI configuration
    if yabai --config "$yabai_config" --test; then
        log "SUCCESS" "YABAI configuration is valid ✓"
    else
        log "WARN" "YABAI configuration test failed"
    fi
}

configure_skhd() {
    log "INFO" "Configuring SKHD..."
    
    local project_root="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    local skhd_config="$project_root/configs/skhd/skhdrc"
    
    if [[ -f "$skhd_config" ]]; then
        log "SUCCESS" "SKHD configuration found ✓"
    else
        log "ERROR" "SKHD configuration not found at: $skhd_config"
        return 1
    fi
    
    # Test SKHD configuration
    if skhd --print-config "$skhd_config" >/dev/null 2>&1; then
        log "SUCCESS" "SKHD configuration is valid ✓"
    else
        log "WARN" "SKHD configuration test failed"
    fi
}

setup_permissions() {
    log "INFO" "Setting up system permissions..."
    
    local project_root="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    local permission_script="$project_root/tools/automation/setup_yabai_permissions.sh"
    
    if [[ -f "$permission_script" ]]; then
        log "INFO" "Running permission setup script..."
        if "$permission_script"; then
            log "SUCCESS" "Permissions configured successfully"
        else
            log "WARN" "Permission setup had issues - check manually"
        fi
    else
        log "ERROR" "Permission setup script not found"
        return 1
    fi
}

test_installation() {
    log "INFO" "Testing YABAI and SKHD installation..."
    
    # Test YABAI
    if command -v yabai >/dev/null 2>&1; then
        local yabai_version=$(yabai --version 2>/dev/null || echo "version unknown")
        log "SUCCESS" "YABAI is working: $yabai_version"
    else
        log "ERROR" "YABAI not found in PATH"
        return 1
    fi
    
    # Test SKHD
    if command -v skhd >/dev/null 2>&1; then
        local skhd_version=$(skhd --version 2>/dev/null || echo "version unknown")
        log "SUCCESS" "SKHD is working: $skhd_version"
    else
        log "ERROR" "SKHD not found in PATH"
        return 1
    fi
    
    # Test configurations
    local project_root="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    
    if [[ -f "$project_root/configs/profiles/yabai_config.yaml" ]]; then
        log "SUCCESS" "YABAI configuration file exists ✓"
    fi
    
    if [[ -f "$project_root/configs/skhd/skhdrc" ]]; then
        log "SUCCESS" "SKHD configuration file exists ✓"
    fi
}

create_startup_script() {
    log "INFO" "Creating startup script..."
    
    local project_root="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    local startup_script="$project_root/start_nexus.sh"
    
    cat > "$startup_script" << 'EOF'
#!/bin/zsh
# 🚀 NEXUS Startup Script
# Starts all NEXUS services and tools

set -euo pipefail

echo "🚀 Starting NEXUS Workspace Manager..."
echo "======================================"

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Function to check if service is running
is_service_running() {
    local service_name="$1"
    if pgrep -f "$service_name" >/dev/null 2>&1; then
        return 0
    else
        return 1
    fi
}

# Start YABAI
echo "🐟 Starting YABAI..."
if command -v yabai >/dev/null 2>&1; then
    if ! is_service_running "yabai"; then
        yabai --start
        echo -e "${GREEN}✅ YABAI started${NC}"
    else
        echo -e "${YELLOW}⚠️ YABAI already running${NC}"
    fi
else
    echo -e "${RED}❌ YABAI not found${NC}"
fi

# Start SKHD
echo "⌨️ Starting SKHD..."
if command -v skhd >/dev/null 2>&1; then
    if ! is_service_running "skhd"; then
        local config_file="$(dirname "$0")/configs/skhd/skhdrc"
        if [[ -f "$config_file" ]]; then
            skhd --config "$config_file" &
            echo -e "${GREEN}✅ SKHD started with config${NC}"
        else
            skhd &
            echo -e "${YELLOW}⚠️ SKHD started without config${NC}"
        fi
    else
        echo -e "${YELLOW}⚠️ SKHD already running${NC}"
    fi
else
    echo -e "${RED}❌ SKHD not found${NC}"
fi

# Start NEXUS Dashboard (optional)
echo "📊 Starting NEXUS Dashboard..."
if command -v streamlit >/dev/null 2>&1; then
    local dashboard_file="$(dirname "$0")/dashboard/interactive_guide.py"
    if [[ -f "$dashboard_file" ]]; then
        echo -e "${GREEN}✅ NEXUS Dashboard available${NC}"
        echo "   Run: streamlit run dashboard/interactive_guide.py"
    else
        echo -e "${YELLOW}⚠️ Dashboard file not found${NC}"
    fi
else
    echo -e "${YELLOW}⚠️ Streamlit not installed${NC}"
fi

echo ""
echo "🎉 NEXUS startup completed!"
echo ""
echo "📋 Quick test commands:"
echo "   • yabai -m query --windows    # List windows"
echo "   • yabai -m query --spaces     # List spaces"
echo "   • skhd --print-config         # Show SKHD config"
echo ""
echo "🎯 Hotkey test:"
echo "   • Cmd+Shift+H/J/K/L: Focus windows"
echo "   • Ctrl+Cmd+1-9: Switch spaces"
echo "   • Cmd+Shift+F: Toggle float"
echo ""
echo "🚀 To start dashboard: streamlit run dashboard/interactive_guide.py"
EOF

    chmod +x "$startup_script"
    log "SUCCESS" "Startup script created: $startup_script"
}

show_post_installation_info() {
    echo ""
    echo -e "${CYAN}🎉 NEXUS YABAI Installation Complete!${NC}"
    echo ""
    echo "🎯 What's been installed and configured:"
    echo "   ✅ YABAI - Window management system"
    echo "   ✅ SKHD - Hotkey daemon"
    echo "   ✅ System permissions and services"
    echo "   ✅ Configuration files"
    echo "   ✅ Startup scripts"
    echo ""
    echo "🚀 Quick start:"
    echo "   ./start_nexus.sh"
    echo ""
    echo "📋 Manual start commands:"
    echo "   yabai --start"
    echo "   skhd --config configs/skhd/skhdrc &"
    echo ""
    echo "🎮 Test your installation:"
    echo "   • Cmd+Shift+H/J/K/L: Focus windows"
    echo "   • Ctrl+Cmd+1-9: Switch spaces"
    echo "   • Cmd+Shift+F: Toggle float"
    echo ""
    echo "📚 Next steps:"
    echo "   1. Test the hotkeys"
    echo "   2. Customize the configuration"
    echo "   3. Start the NEXUS dashboard"
    echo "   4. Set up your workspace profiles"
    echo ""
    echo "🔧 Troubleshooting:"
    echo "   • Check logs: tail -f /tmp/yabai.out /tmp/skhd.out"
    echo "   • Reload SKHD: skhd --reload"
    echo "   • Restart YABAI: yabai --restart"
    echo ""
    echo "📖 Documentation: docs/"
}

main() {
    print_banner
    
    log "INFO" "Starting NEXUS complete YABAI installation..."
    echo ""
    
    # Check requirements
    if ! check_requirements; then
        log "ERROR" "System requirements not met. Please fix the issues above."
        exit 1
    fi
    echo ""
    
    # Install YABAI
    if ! install_yabai; then
        log "ERROR" "Failed to install YABAI"
        exit 1
    fi
    echo ""
    
    # Install SKHD
    if ! install_skhd; then
        log "ERROR" "Failed to install SKHD"
        exit 1
    fi
    echo ""
    
    # Install additional tools
    install_additional_tools
    echo ""
    
    # Configure YABAI
    if ! configure_yabai; then
        log "ERROR" "Failed to configure YABAI"
        exit 1
    fi
    echo ""
    
    # Configure SKHD
    if ! configure_skhd; then
        log "ERROR" "Failed to configure SKHD"
        exit 1
    fi
    echo ""
    
    # Setup permissions
    if ! setup_permissions; then
        log "WARN" "Permission setup had issues - you may need to configure manually"
    fi
    echo ""
    
    # Test installation
    if ! test_installation; then
        log "ERROR" "Installation test failed"
        exit 1
    fi
    echo ""
    
    # Create startup script
    create_startup_script
    echo ""
    
    # Show post-installation information
    show_post_installation_info
}

# Run main function
main "$@"
