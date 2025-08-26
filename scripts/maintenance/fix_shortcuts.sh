#!/bin/zsh
# 🔧 Fix NEXUS Shortcuts Script
# Troubleshoots and fixes shortcut issues

set -euo pipefail

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo "🔧 Fixing NEXUS Shortcuts..."
echo "============================="
echo ""

# Function to check service status
check_service() {
    local service_name="$1"
    local process_name="$2"
    
    echo "🔍 Checking $service_name..."
    
    if pgrep -f "$process_name" >/dev/null 2>&1; then
        echo -e "${GREEN}✅ $service_name is running${NC}"
        return 0
    else
        echo -e "${RED}❌ $service_name is not running${NC}"
        return 1
    fi
}

# Function to restart service
restart_service() {
    local service_name="$1"
    local start_command="$2"
    
    echo "🔄 Restarting $service_name..."
    
    # Kill existing process
    pkill -f "$service_name" 2>/dev/null || true
    sleep 1
    
    # Start new process
    if eval "$start_command"; then
        echo -e "${GREEN}✅ $service_name restarted successfully${NC}"
        return 0
    else
        echo -e "${RED}❌ Failed to restart $service_name${NC}"
        return 1
    fi
}

# Function to test basic shortcuts
test_shortcuts() {
    echo ""
    echo "🧪 Testing Basic Shortcuts..."
    echo ""
    
    echo "📋 Please try these shortcuts now:"
    echo "   1. Cmd+Shift+H → Should focus left window"
    echo "   2. Cmd+Shift+L → Should focus right window"
    echo "   3. Cmd+Shift+J → Should focus window below"
    echo "   4. Cmd+Shift+K → Should focus window above"
    echo ""
    echo "🎯 If these work, your shortcuts are fixed!"
    echo "❌ If they don't work, we need to investigate further"
    echo ""
}

# Function to verify configuration
verify_config() {
    echo "📋 Verifying Configuration..."
    
    # Check SKHD config
    if [[ -f ~/.skhdrc ]]; then
        local hotkey_count=$(grep -c "^[^#].*:" ~/.skhdrc 2>/dev/null || echo "0")
        echo -e "${GREEN}✅ SKHD config found with $hotkey_count hotkeys${NC}"
    else
        echo -e "${RED}❌ SKHD config not found${NC}"
        return 1
    fi
    
    # Check YABAI config
    if [[ -f configs/yabai/yabai_config.yaml ]]; then
        echo -e "${GREEN}✅ YABAI config found${NC}"
    else
        echo -e "${RED}❌ YABAI config not found${NC}"
        return 1
    fi
    
    return 0
}

# Main execution
main() {
    echo "🎯 Starting NEXUS shortcut troubleshooting..."
    echo ""
    
    # Step 1: Check current status
    echo "📊 Current Service Status:"
    local yabai_ok=false
    local skhd_ok=false
    
    if check_service "YABAI" "yabai"; then
        yabai_ok=true
    fi
    
    if check_service "SKHD" "skhd"; then
        skhd_ok=true
    fi
    
    echo ""
    
    # Step 2: Verify configuration
    if ! verify_config; then
        echo -e "${RED}❌ Configuration issues found${NC}"
        exit 1
    fi
    
    # Step 3: Restart services if needed
    if [[ "$yabai_ok" == "false" ]]; then
        echo "🔄 YABAI needs to be restarted..."
        if restart_service "YABAI" "yabai --start-service"; then
            yabai_ok=true
        fi
    fi
    
    if [[ "$skhd_ok" == "false" ]]; then
        echo "🔄 SKHD needs to be restarted..."
        if restart_service "SKHD" "skhd --config ~/.skhdrc &"; then
            skhd_ok=true
        fi
    fi
    
    # Step 4: Final verification
    echo ""
    echo "🔍 Final Verification:"
    sleep 2
    
    if check_service "YABAI" "yabai" && check_service "SKHD" "skhd"; then
        echo ""
        echo -e "${GREEN}🎉 All services are running!${NC}"
        
        # Test shortcuts
        test_shortcuts
        
        echo "🚀 Next steps:"
        echo "   1. Try the shortcuts listed above"
        echo "   2. If they work, you're all set!"
        echo "   3. If they don't work, run this script again"
        echo ""
        echo "🔧 To restart everything: ./restart_nexus.sh"
        
    else
        echo ""
        echo -e "${RED}❌ Some services are still not working${NC}"
        echo "🔧 Try running: ./restart_nexus.sh"
    fi
}

# Run main function
main "$@"
