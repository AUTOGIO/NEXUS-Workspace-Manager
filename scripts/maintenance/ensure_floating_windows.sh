#!/bin/zsh
# 🚫 Ensure Floating Windows Script
# Makes Finder, iTerm, Terminal, and System Settings always float

set -euo pipefail

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo "🚫 Ensuring Critical Apps are Floating Windows..."
echo "================================================="
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

# Function to make all windows of an app float
make_app_windows_float() {
    local app_name="$1"
    
    echo "🎯 Making $app_name windows float..."
    
    # Get all windows of this app
    local windows=$(yabai -m query --windows | jq -r ".[] | select(.app == \"$app_name\") | .id" 2>/dev/null || echo "")
    
    if [[ -n "$windows" ]]; then
        echo "   Found ${#windows[@]} window(s) to convert..."
        
        for window_id in $windows; do
            # Check current floating status
            local current_status=$(yabai -m query --windows | jq -r ".[] | select(.id == $window_id) | .\"is-floating\"" 2>/dev/null || echo "false")
            
            if [[ "$current_status" == "false" ]]; then
                echo "   Converting window $window_id to float..."
                yabai -m window "$window_id" --toggle float 2>/dev/null && \
                echo -e "${GREEN}     ✅ Window $window_id now floating${NC}" || \
                echo -e "${RED}     ❌ Failed to float window $window_id${NC}"
            else
                echo -e "${GREEN}     ✅ Window $window_id already floating${NC}"
            fi
        done
    else
        echo "   No windows currently open for $app_name"
    fi
}

# Function to verify floating status
verify_floating_status() {
    echo ""
    echo "🔍 Verifying floating window status..."
    echo ""
    
    local total_windows=0
    local floating_windows=0
    
    for app_name in "${FLOATING_APPS[@]}"; do
        local windows=$(yabai -m query --windows | jq -r ".[] | select(.app == \"$app_name\") | .id" 2>/dev/null || echo "")
        
        if [[ -n "$windows" ]]; then
            echo "📍 $app_name:"
            
            for window_id in $windows; do
                local floating_status=$(yabai -m query --windows | jq -r ".[] | select(.id == $window_id) | .\"is-floating\"" 2>/dev/null || echo "false")
                local window_title=$(yabai -m query --windows | jq -r ".[] | select(.id == $window_id) | .title" 2>/dev/null || echo "Unknown")
                
                ((total_windows++))
                
                if [[ "$floating_status" == "true" ]]; then
                    echo -e "   ✅ Window $window_id: $window_title (FLOATING)${NC}"
                    ((floating_windows++))
                else
                    echo -e "   ❌ Window $window_id: $window_title (NOT FLOATING)${NC}"
                fi
            done
        else
            echo "📍 $app_name: No windows open"
        fi
        echo ""
    done
    
    echo "📊 Floating Window Status Summary:"
    echo "   Total windows: $total_windows"
    echo "   Floating windows: $floating_windows"
    echo "   Non-floating windows: $((total_windows - floating_windows))"
    
    if [[ $total_windows -gt 0 && $floating_windows -eq $total_windows ]]; then
        echo -e "${GREEN}🎉 SUCCESS: All critical app windows are floating!${NC}"
        return 0
    elif [[ $total_windows -gt 0 ]]; then
        echo -e "${YELLOW}⚠️ PARTIAL: Some windows still need to be converted${NC}"
        return 1
    else
        echo -e "${BLUE}ℹ️ No critical app windows are currently open${NC}"
        return 0
    fi
}

# Function to create floating rules for future windows
create_floating_rules() {
    echo "📋 Creating floating rules for future windows..."
    
    # Remove existing rules for these apps
    local existing_rules=$(yabai -m rule --list | jq -r ".[] | select(.app | test(\"^($(IFS='|'; echo "${FLOATING_APPS[*]}"))$\")) | .index" 2>/dev/null || echo "")
    
    if [[ -n "$existing_rules" ]]; then
        echo "   Removing existing rules..."
        for rule_index in $existing_rules; do
            yabai -m rule --remove "$rule_index" 2>/dev/null || true
        done
    fi
    
    # Add new rules for floating
    for app_name in "${FLOATING_APPS[@]}"; do
        echo "   Adding floating rule for $app_name..."
        yabai -m rule --add app="^$app_name$" 2>/dev/null && \
        echo -e "${GREEN}     ✅ Rule added for $app_name${NC}" || \
        echo -e "${RED}     ❌ Failed to add rule for $app_name${NC}"
    done
    
    echo -e "${GREEN}✅ Floating rules created${NC}"
}

# Function to provide testing instructions
provide_testing_instructions() {
    echo ""
    echo "🧪 Testing Instructions:"
    echo "========================"
    echo ""
    echo "1. 📱 Open any of these apps:"
    for app in "${FLOATING_APPS[@]}"; do
        echo "   • $app"
    done
    echo ""
    echo "2. 🔍 Verify the window behavior:"
    echo "   • Floating windows can be moved freely"
    echo "   • They don't snap to the tiling grid"
    echo "   • They maintain their size and position"
    echo ""
    echo "3. 🔧 If windows don't float automatically:"
    echo "   • Use Cmd+Shift+F to toggle float mode"
    echo "   • Or restart the app to apply new rules"
    echo ""
    echo "4. 🎯 Test with multiple windows:"
    echo "   • Open several instances of the same app"
    echo "   • All should be floating independently"
    echo ""
}

# Main execution
main() {
    # Check if YABAI is running
    if ! pgrep -f "yabai" >/dev/null 2>&1; then
        echo -e "${RED}❌ YABAI is not running. Please start it first.${NC}"
        exit 1
    fi
    
    echo "🎯 Processing ${#FLOATING_APPS[@]} critical apps..."
    echo ""
    
    # Step 1: Make existing windows float
    for app_name in "${FLOATING_APPS[@]}"; do
        make_app_windows_float "$app_name"
        echo ""
    done
    
    # Step 2: Create rules for future windows
    create_floating_rules
    
    # Step 3: Verify current status
    verify_floating_status
    
    # Step 4: Provide testing instructions
    provide_testing_instructions
    
    echo "🚀 Next steps:"
    echo "   1. Test by opening the configured apps"
    echo "   2. Verify they appear as floating windows"
    echo "   3. Use Cmd+Shift+F to toggle float if needed"
    echo "   4. Restart apps to ensure new rules apply"
    echo ""
    echo "🔧 To restart YABAI: ./restart_nexus.sh"
    echo "📚 See PROJECT_ORGANIZATION_SUMMARY.md for full details"
}

# Run main function
main "$@"
