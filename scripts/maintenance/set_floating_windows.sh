#!/bin/zsh
# 🚫 Set Floating Windows Script
# Ensures Finder, iTerm, Terminal, and System Settings are always floating

set -euo pipefail

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo "🚫 Setting Critical Apps as Floating Windows..."
echo "================================================"
echo ""

# Apps that should always float
FLOATING_APPS=(
    "Finder"
    "Terminal"
    "iTerm"
    "iTerm2"
    "System Settings"
    "System Preferences"
)

# Function to set an app as floating
set_app_floating() {
    local app_name="$1"
    
    echo "🎯 Setting $app_name as floating window..."
    
    # Remove any existing rules for this app
    local existing_rules=$(yabai -m rule --list | jq -r ".[] | select(.app == \"^$app_name$\") | .index" 2>/dev/null || echo "")
    
    if [[ -n "$existing_rules" ]]; then
        echo "   Removing existing rule..."
        for rule_index in $existing_rules; do
            yabai -m rule --remove "$rule_index" 2>/dev/null || true
        done
    fi
    
    # Add new rule for floating
    if yabai -m rule --add app="^$app_name$" 2>/dev/null; then
        echo -e "${GREEN}   ✅ Rule added for $app_name${NC}"
        
        # Force any existing windows of this app to float
        local windows=$(yabai -m query --windows | jq -r ".[] | select(.app == \"$app_name\") | .id" 2>/dev/null || echo "")
        
        if [[ -n "$windows" ]]; then
            echo "   Converting existing windows to float..."
            for window_id in $windows; do
                yabai -m window "$window_id" --toggle float 2>/dev/null || true
            done
        fi
        
        return 0
    else
        echo -e "${RED}   ❌ Failed to add rule for $app_name${NC}"
        return 1
    fi
}

# Function to verify floating status
verify_floating_status() {
    echo ""
    echo "🔍 Verifying floating window configuration..."
    echo ""
    
    local success_count=0
    local total_apps=${#FLOATING_APPS[@]}
    
    for app_name in "${FLOATING_APPS[@]}"; do
        # Check if rule exists
        local rule_exists=$(yabai -m rule --list | jq -r ".[] | select(.app == \"^$app_name$\") | .app" 2>/dev/null || echo "")
        
        if [[ -n "$rule_exists" ]]; then
            echo -e "${GREEN}✅ $app_name: Rule configured${NC}"
            ((success_count++))
        else
            echo -e "${RED}❌ $app_name: No rule found${NC}"
        fi
    done
    
    echo ""
    echo "📊 Floating Window Configuration Summary:"
    echo "   Configured: $success_count/$total_apps apps"
    
    if [[ $success_count -eq $total_apps ]]; then
        echo -e "${GREEN}🎉 SUCCESS: All critical apps are set as floating windows!${NC}"
        return 0
    else
        echo -e "${YELLOW}⚠️ PARTIAL: Some apps may need manual configuration${NC}"
        return 1
    fi
}

# Function to test floating behavior
test_floating_behavior() {
    echo ""
    echo "🧪 Testing floating window behavior..."
    echo ""
    
    echo "📋 Instructions for testing:"
    echo "   1. Open Finder, Terminal, iTerm, or System Settings"
    echo "   2. These windows should appear as floating (not tiled)"
    echo "   3. You can move them freely around the screen"
    echo "   4. They won't be affected by YABAI tiling rules"
    echo ""
    echo "🔧 If windows don't float automatically:"
    echo "   - Use Cmd+Shift+F to toggle float mode"
    echo "   - Or restart the app to apply new rules"
    echo ""
}

# Main execution
main() {
    # Check if YABAI is running
    if ! pgrep -f "yabai" >/dev/null 2>&1; then
        echo -e "${RED}❌ YABAI is not running. Please start it first.${NC}"
        exit 1
    fi
    
    echo "🎯 Configuring ${#FLOATING_APPS[@]} apps as floating windows..."
    echo ""
    
    # Set each app as floating
    local success_count=0
    for app_name in "${FLOATING_APPS[@]}"; do
        if set_app_floating "$app_name"; then
            ((success_count++))
        fi
        echo ""
    done
    
    # Verify configuration
    verify_floating_status
    
    # Test instructions
    test_floating_behavior
    
    echo "🚀 Next steps:"
    echo "   1. Test by opening the configured apps"
    echo "   2. Verify they appear as floating windows"
    echo "   3. Use Cmd+Shift+F to toggle float if needed"
    echo "   4. Restart apps to ensure new rules apply"
    echo ""
    echo "🔧 To restart YABAI: ./restart_nexus.sh"
}

# Run main function
main "$@"
