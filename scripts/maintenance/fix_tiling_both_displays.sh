#!/bin/zsh
# 🔧 Fix Tiling for Both Displays
# Ensures both displays use BSP layout for automatic tiling

set -euo pipefail

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo "🔧 Fixing Tiling for Both Displays..."
echo "======================================"
echo ""

# Function to set BSP layout for a space
set_bsp_layout() {
    local space_index="$1"
    local display_id="$2"
    
    echo "🎯 Setting BSP layout for Space $space_index (Display $display_id)..."
    
    # Set BSP layout
    if yabai -m space "$space_index" --layout bsp 2>/dev/null; then
        echo -e "${GREEN}✅ BSP layout set for Space $space_index${NC}"
        
        # Set padding and gap
        yabai -m space "$space_index" --padding abs:10:10:10:10 2>/dev/null && \
        yabai -m space "$space_index" --gap abs:5 2>/dev/null && \
        echo -e "${GREEN}✅ Padding and gap set for Space $space_index${NC}"
        
        return 0
    else
        echo -e "${YELLOW}⚠️ Could not set BSP layout for Space $space_index (may be fullscreen)${NC}"
        return 1
    fi
}

# Function to check and fix all spaces
fix_all_spaces() {
    echo "🔍 Checking current space configurations..."
    echo ""
    
    # Get all spaces
    local spaces_json=$(yabai -m query --spaces)
    local total_spaces=$(echo "$spaces_json" | jq 'length')
    local fixed_count=0
    
    echo "📊 Found $total_spaces total spaces"
    echo ""
    
    # Process each space
    for i in $(seq 0 $((total_spaces - 1))); do
        local space_data=$(echo "$spaces_json" | jq ".[$i]")
        local space_index=$(echo "$space_data" | jq -r '.index')
        local space_type=$(echo "$space_data" | jq -r '.type')
        local display_id=$(echo "$space_data" | jq -r '.display')
        local is_fullscreen=$(echo "$space_data" | jq -r '.is_native_fullscreen')
        
        echo "📍 Space $space_index:"
        echo "   Type: $space_type"
        echo "   Display: $display_id"
        echo "   Fullscreen: $is_fullscreen"
        
        if [[ "$is_fullscreen" == "true" ]]; then
            echo -e "${YELLOW}   ⚠️ Skipping fullscreen space${NC}"
        elif [[ "$space_type" == "bsp" ]]; then
            echo -e "${GREEN}   ✅ Already using BSP layout${NC}"
            ((fixed_count++))
        else
            echo -e "${BLUE}   🔧 Converting to BSP layout...${NC}"
            if set_bsp_layout "$space_index" "$display_id"; then
                ((fixed_count++))
            fi
        fi
        
        echo ""
    done
    
    echo "🎉 Tiling fix completed!"
    echo "   Spaces with BSP layout: $fixed_count/$total_spaces"
    echo ""
    
    return $fixed_count
}

# Function to apply tiling rules
apply_tiling_rules() {
    echo "📋 Applying tiling rules..."
    
    # Clear existing rules
    yabai -m rule --remove-all 2>/dev/null || true
    
    # Add rules for common apps to ensure they tile
    local apps=("Cursor" "iTerm" "Safari" "Vivaldi" "Obsidian" "Notes" "WhatsApp" "Telegram")
    
    for app in "${apps[@]}"; do
        echo "   Adding rule for $app..."
        yabai -m rule --add app="^$app$" 2>/dev/null || echo "   ⚠️ Could not add rule for $app"
    done
    
    echo -e "${GREEN}✅ Tiling rules applied${NC}"
    echo ""
}

# Function to verify the fix
verify_fix() {
    echo "🔍 Verifying tiling configuration..."
    echo ""
    
    local spaces_json=$(yabai -m query --spaces)
    local bsp_spaces=$(echo "$spaces_json" | jq '[.[] | select(.type == "bsp")] | length')
    local total_spaces=$(echo "$spaces_json" | jq 'length')
    
    echo "📊 Space Layout Summary:"
    echo "   Total spaces: $total_spaces"
    echo "   BSP spaces: $bsp_spaces"
    echo "   Other layouts: $((total_spaces - bsp_spaces))"
    echo ""
    
    if [[ $bsp_spaces -eq $total_spaces ]]; then
        echo -e "${GREEN}🎉 SUCCESS: All spaces are now using BSP layout!${NC}"
        echo "   Both displays will now tile windows automatically."
        return 0
    else
        echo -e "${YELLOW}⚠️ PARTIAL: Some spaces still need attention${NC}"
        echo "   Fullscreen spaces cannot use BSP layout."
        return 1
    fi
}

# Main execution
main() {
    # Check if YABAI is running
    if ! pgrep -f "yabai" >/dev/null 2>&1; then
        echo -e "${RED}❌ YABAI is not running. Please start it first.${NC}"
        exit 1
    fi
    
    # Fix all spaces
    fix_all_spaces
    
    # Apply tiling rules
    apply_tiling_rules
    
    # Verify the fix
    verify_fix
    
    echo ""
    echo "🚀 Next steps:"
    echo "   1. Test window tiling on both displays"
    echo "   2. Open multiple apps to see automatic tiling"
    echo "   3. Use hotkeys: Cmd+Shift+H/J/K/L to navigate"
    echo "   4. Use hotkeys: Ctrl+Cmd+1-5 to switch spaces"
    echo ""
    echo "🔧 If you need to restart: ./restart_nexus.sh"
}

# Run main function
main "$@"
