#!/bin/zsh
# 🚀 NEXUS YABAI Permission Setup Script
# Handles system permissions and SIP bypass for YABAI

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
    echo "║                    🚀 NEXUS YABAI                           ║"
    echo "║                  Permission Setup                            ║"
    echo "║                                                              ║"
    echo "║              Setting up system permissions                   ║"
    echo "║                    for YABAI & SKHD                          ║"
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

check_sip_status() {
    log "INFO" "Checking System Integrity Protection (SIP) status..."
    
    if csrutil status | grep -q "enabled"; then
        log "WARN" "SIP is ENABLED - YABAI will have limited functionality"
        log "INFO" "Some features may not work without SIP bypass"
        return 1
    else
        log "SUCCESS" "SIP is DISABLED - Full YABAI functionality available"
        return 0
    fi
}

setup_accessibility_permissions() {
    log "INFO" "Setting up Accessibility permissions..."
    
    # Check if Terminal has accessibility access
    if tccutil query Accessibility com.apple.Terminal 2>/dev/null | grep -q "allowed"; then
        log "SUCCESS" "Terminal already has Accessibility access"
    else
        log "WARN" "Terminal needs Accessibility access"
        log "INFO" "Please follow these steps:"
        echo ""
        echo "1. Go to System Preferences → Security & Privacy → Privacy"
        echo "2. Select 'Accessibility' from the left sidebar"
        echo "3. Click the lock icon to make changes"
        echo "4. Add Terminal to the list of allowed apps"
        echo "5. Check the box next to Terminal"
        echo ""
        read -p "Press Enter when you've completed these steps..."
        
        # Verify the permission was granted
        if tccutil query Accessibility com.apple.Terminal 2>/dev/null | grep -q "allowed"; then
            log "SUCCESS" "Terminal Accessibility permission confirmed"
        else
            log "ERROR" "Terminal Accessibility permission not granted"
            return 1
        fi
    fi
}

setup_input_monitoring_permissions() {
    log "INFO" "Setting up Input Monitoring permissions..."
    
    # Check if Terminal has input monitoring access
    if tccutil query InputMonitoring com.apple.Terminal 2>/dev/null | grep -q "allowed"; then
        log "SUCCESS" "Terminal already has Input Monitoring access"
    else
        log "WARN" "Terminal needs Input Monitoring access"
        log "INFO" "Please follow these steps:"
        echo ""
        echo "1. Go to System Preferences → Security & Privacy → Privacy"
        echo "2. Select 'Input Monitoring' from the left sidebar"
        echo "3. Click the lock icon to make changes"
        echo "4. Add Terminal to the list of allowed apps"
        echo "5. Check the box next to Terminal"
        echo ""
        read -p "Press Enter when you've completed these steps..."
        
        # Verify the permission was granted
        if tccutil query InputMonitoring com.apple.Terminal 2>/dev/null | grep -q "allowed"; then
            log "SUCCESS" "Terminal Input Monitoring permission confirmed"
        else
            log "ERROR" "Terminal Input Monitoring permission not granted"
            return 1
        fi
    fi
}

setup_full_disk_access() {
    log "INFO" "Setting up Full Disk Access permissions..."
    
    # Check if Terminal has full disk access
    if tccutil query SystemPolicyAllFiles com.apple.Terminal 2>/dev/null | grep -q "allowed"; then
        log "SUCCESS" "Terminal already has Full Disk Access"
    else
        log "WARN" "Terminal needs Full Disk Access"
        log "INFO" "Please follow these steps:"
        echo ""
        echo "1. Go to System Preferences → Security & Privacy → Privacy"
        echo "2. Select 'Full Disk Access' from the left sidebar"
        echo "3. Click the lock icon to make changes"
        echo "4. Add Terminal to the list of allowed apps"
        echo "5. Check the box next to Terminal"
        echo ""
        read -p "Press Enter when you've completed these steps..."
        
        # Verify the permission was granted
        if tccutil query SystemPolicyAllFiles com.apple.Terminal 2>/dev/null | grep -q "allowed"; then
            log "SUCCESS" "Terminal Full Disk Access confirmed"
        else
            log "ERROR" "Terminal Full Disk Access not granted"
            return 1
        fi
    fi
}

install_launchd_services() {
    log "INFO" "Installing launchd services for YABAI and SKHD..."
    
    local project_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
    local user_launch_agents="$HOME/Library/LaunchAgents"
    
    # Create LaunchAgents directory if it doesn't exist
    mkdir -p "$user_launch_agents"
    
    # Install YABAI service
    if cp "$project_root/configs/yabai.plist" "$user_launch_agents/"; then
        log "SUCCESS" "YABAI service configuration installed"
    else
        log "ERROR" "Failed to install YABAI service configuration"
        return 1
    fi
    
    # Install SKHD service
    if cp "$project_root/configs/skhd.plist" "$user_launch_agents/"; then
        log "SUCCESS" "SKHD service configuration installed"
    else
        log "ERROR" "Failed to install SKHD service configuration"
        return 1
    fi
    
    # Load the services
    log "INFO" "Loading launchd services..."
    
    if launchctl load "$user_launch_agents/yabai.plist" 2>/dev/null; then
        log "SUCCESS" "YABAI service loaded"
    else
        log "WARN" "YABAI service already loaded or failed to load"
    fi
    
    if launchctl load "$user_launch_agents/skhd.plist" 2>/dev/null; then
        log "SUCCESS" "SKHD service loaded"
    else
        log "WARN" "SKHD service already loaded or failed to load"
    fi
}

create_quick_start_script() {
    log "INFO" "Creating quick start script..."
    
    local project_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
    local quick_start="$project_root/start_nexus_services.sh"
    
    cat > "$quick_start" << 'EOF'
#!/bin/zsh
# 🚀 NEXUS Quick Start Script
# Starts YABAI and SKHD services

set -euo pipefail

echo "🚀 Starting NEXUS services..."

# Start YABAI
if command -v yabai >/dev/null 2>&1; then
    echo "✅ Starting YABAI..."
    yabai --start
else
    echo "❌ YABAI not found. Please install it first."
    exit 1
fi

# Start SKHD
if command -v skhd >/dev/null 2>&1; then
    echo "✅ Starting SKHD..."
    skhd --config "$(dirname "$0")/configs/skhd/skhdrc" &
else
    echo "❌ SKHD not found. Please install it first."
    exit 1
fi

echo "🎉 NEXUS services started successfully!"
echo "   YABAI: Window management active"
echo "   SKHD: Hotkeys active"
echo ""
echo "📋 Quick test:"
echo "   • Cmd+Shift+H/J/K/L: Focus windows"
echo "   • Ctrl+Cmd+1-9: Switch spaces"
echo "   • Cmd+Shift+F: Toggle float"
EOF

    chmod +x "$quick_start"
    log "SUCCESS" "Quick start script created: $quick_start"
}

main() {
    print_banner
    
    log "INFO" "Starting NEXUS YABAI permission setup..."
    echo ""
    
    # Check SIP status
    check_sip_status
    echo ""
    
    # Setup permissions
    log "INFO" "Setting up required system permissions..."
    echo ""
    
    if setup_accessibility_permissions; then
        log "SUCCESS" "Accessibility permissions configured"
    else
        log "ERROR" "Failed to configure Accessibility permissions"
        return 1
    fi
    echo ""
    
    if setup_input_monitoring_permissions; then
        log "SUCCESS" "Input Monitoring permissions configured"
    else
        log "ERROR" "Failed to configure Input Monitoring permissions"
        return 1
    fi
    echo ""
    
    if setup_full_disk_access; then
        log "SUCCESS" "Full Disk Access permissions configured"
    else
        log "ERROR" "Failed to configure Full Disk Access permissions"
        return 1
    fi
    echo ""
    
    # Install launchd services
    if install_launchd_services; then
        log "SUCCESS" "Launchd services installed and loaded"
    else
        log "ERROR" "Failed to install launchd services"
        return 1
    fi
    echo ""
    
    # Create quick start script
    create_quick_start_script
    echo ""
    
    log "SUCCESS" "NEXUS YABAI permission setup completed!"
    echo ""
    echo "🎯 What's been configured:"
    echo "   ✅ System permissions (Accessibility, Input Monitoring, Full Disk Access)"
    echo "   ✅ Launchd services for YABAI and SKHD"
    echo "   ✅ Quick start script for easy service management"
    echo ""
    echo "🚀 Next steps:"
    echo "   1. Install YABAI: brew install yabai"
    echo "   2. Install SKHD: brew install skhd"
    echo "   3. Run: ./start_nexus_services.sh"
    echo ""
    echo "📚 For more information, see the NEXUS documentation."
}

# Run main function
main "$@"
