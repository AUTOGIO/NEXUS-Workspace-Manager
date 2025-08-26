#!/bin/zsh
# 🎯 Finalize Tiling Fix for Both Displays
# Completes the tiling configuration for all spaces

set -euo pipefail

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo "🎯 Finalizing Tiling Fix for Both Displays..."
echo "=============================================="
echo ""

# Function to force BSP layout on a space
force_bsp_layout() {
    local space_index="$1"
    local display_id="$2"
    
    echo "🔧 Converting Space $space_index (Display $display_id) to BSP..."
    
    # Try multiple approaches to set BSP layout
    local success=false
    
    # Method 1: Direct layout change
    if yabai -m space "$space_index" --layout bsp 2>/dev/null; then
        success=true
    fi
    
    # Method 2: If that fails, try to move windows and reset
    if [[ "$success" == "false" ]]; then
        echo "   Trying alternative method..."
        
        # Get windows in this space
        local windows=$(yabai -m query --windows | jq -r ".[] | select(.space == $space_index) | .id")
        
        if [[ -n "$windows" ]]; then
            echo "   Moving windows to temporary space..."
            
            # Move windows to space 1 temporarily
            for window_id in $windows; do
                yabai -m window "$window_id" --space 1 2>/dev/null || true
            done
            
            # Wait a moment
            sleep 1
            
            # Try to set layout again
            if yabai -m space "$space_index" --layout bsp 2>/dev/null; then
                success=true
                echo "   ✅ Layout set successfully"
                
                # Move windows back
                for window_id in $windows; do
                    yabai -m window "$window_id" --space "$space_index" 2>/dev/null || true
                done
            else
                echo "   ❌ Still cannot set layout"
            fi
        fi
    fi
    
    if [[ "$success" == "true" ]]; then
        echo -e "${GREEN}✅ BSP layout set for Space $space_index${NC}"
        
        # Set padding and gap
        yabai -m space "$space_index" --padding abs:10:10:10:10 2>/dev/null && \
        yabai -m space "$space_index" --gap abs:5 2>/dev/null && \
        echo -e "${GREEN}✅ Padding and gap configured${NC}"
        
        return 0
    else
        echo -e "${RED}❌ Failed to set BSP layout for Space $space_index${NC}"
        return 1
    fi
}

# Main execution
main() {
    echo "🔍 Current space status:"
    yabai -m query --spaces | jq '.[] | {index, type, display, is_native_fullscreen}' | head -20
    echo ""
    
    # Spaces that need fixing
    local spaces_to_fix=(2 4 5)
    local fixed_count=0
    
    for space_index in "${spaces_to_fix[@]}"; do
        # Get display ID for this space
        local display_id=$(yabai -m query --spaces | jq -r ".[] | select(.index == $space_index) | .display")
        
        if [[ -n "$display_id" ]]; then
            if force_bsp_layout "$space_index" "$display_id"; then
                ((fixed_count++))
            fi
        fi
        
        echo ""
    done
    
    echo "🎉 Tiling fix completed!"
    echo "   Spaces converted to BSP: $fixed_count/${#spaces_to_fix[@]}"
    echo ""
    
    # Final verification
    echo "🔍 Final space status:"
    yabai -m query --spaces | jq '.[] | {index, type, display}' | head -20
    echo ""
    
    if [[ $fixed_count -eq ${#spaces_to_fix[@]} ]]; then
        echo -e "${GREEN}🎉 SUCCESS: All spaces now use BSP layout!${NC}"
        echo "   Both displays will tile windows automatically."
    else
        echo -e "${YELLOW}⚠️ PARTIAL: Some spaces may still need attention${NC}"
        echo "   Fullscreen or system-protected spaces cannot be changed."
    fi
    
    echo ""
    echo "🚀 Test your setup:"
    echo "   1. Open multiple apps on each display"
    echo "   2. Windows should tile automatically"
    echo "   3. Use hotkeys: Cmd+Shift+H/J/K/L to navigate"
    echo "   4. Use hotkeys: Ctrl+Cmd+1-5 to switch spaces"
}

# Run main function
main "$@"
