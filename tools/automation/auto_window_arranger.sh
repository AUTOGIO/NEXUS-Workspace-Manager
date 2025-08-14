#!/bin/bash
# 🎯 Auto Window Arranger for YABAI
# Automatically arranges windows when 3+ are on the same display
# Keeps Terminal, Finder, and iTerm floating

# =============================================================================
# 🚀 CONFIGURATION
# =============================================================================

# Apps that should always float (unmanaged)
FLOATING_APPS=(
    "Terminal"
    "Finder"
    "iTerm2"
    "iTerm"
    "System Settings"
    "System Preferences"
    "Activity Monitor"
    "Console"
    "Calculator"
    "Calendar"
    "Contacts"
    "Preview"
    "Quick Look"
)

# Threshold for automatic arrangement
MIN_WINDOWS_FOR_ARRANGEMENT=3

# =============================================================================
# 🔧 FUNCTIONS
# =============================================================================

# Check if an app should float
should_float() {
    local app_name="$1"
    for floating_app in "${FLOATING_APPS[@]}"; do
        if [[ "$app_name" == "$floating_app" ]]; then
            return 0  # true
        fi
    done
    return 1  # false
}

# Get managed windows count for a display
get_managed_windows_count() {
    local display_id="$1"
    yabai -m query --windows --display "$display_id" | jq -r '.[] | select(.app != null) | .app' | while read app_name; do
        if ! should_float "$app_name"; then
            echo "1"
        fi
    done | wc -l
}

# Arrange windows on a display if needed
arrange_display_if_needed() {
    local display_id="$1"
    local managed_count=$(get_managed_windows_count "$display_id")
    
    if [[ "$managed_count" -ge "$MIN_WINDOWS_FOR_ARRANGEMENT" ]]; then
        echo "🔄 Display $display_id has $managed_count managed windows - arranging..."
        yabai -m display --focus "$display_id"
        yabai -m space --balance
        echo "✅ Display $display_id arranged"
    fi
}

# Main arrangement function
arrange_all_displays() {
    echo "🔍 Checking displays for window arrangement..."
    
    # Get all displays
    local displays=$(yabai -m query --displays | jq -r '.[].index')
    
    for display_id in $displays; do
        arrange_display_if_needed "$display_id"
    done
}

# =============================================================================
# 🪟 FLOATING WINDOW SETUP
# =============================================================================

setup_floating_windows() {
    echo "🪟 Setting up floating window rules..."
    
    for app_name in "${FLOATING_APPS[@]}"; do
        yabai -m rule --add app="$app_name" manage=off
        echo "  ✅ $app_name set to float"
    done
}

# =============================================================================
# 🔄 EVENT HANDLERS
# =============================================================================

# Handle window creation
handle_window_created() {
    local window_id="$1"
    local display_id=$(yabai -m query --windows --window "$window_id" | jq -r '.display')
    
    if [[ "$display_id" != "null" ]]; then
        sleep 0.5  # Wait for window to fully appear
        arrange_display_if_needed "$display_id"
    fi
}

# Handle window moved between displays
handle_window_moved() {
    local window_id="$1"
    local display_id=$(yabai -m query --windows --window "$window_id" | jq -r '.display')
    
    if [[ "$display_id" != "null" ]]; then
        sleep 0.3  # Wait for move to complete
        arrange_display_if_needed "$display_id"
    fi
}

# =============================================================================
# 🚀 MAIN EXECUTION
# =============================================================================

main() {
    echo "🎯 YABAI Auto Window Arranger starting..."
    
    # Setup floating window rules
    setup_floating_windows
    
    # Initial arrangement
    arrange_all_displays
    
    echo "✅ Auto Window Arranger ready!"
    echo "📋 Floating apps: ${FLOATING_APPS[*]}"
    echo "🔢 Arrangement threshold: $MIN_WINDOWS_FOR_ARRANGEMENT windows"
    echo "🔄 Run 'arrange_all_displays' to manually arrange all displays"
}

# =============================================================================
# 📱 USAGE
# =============================================================================

case "${1:-}" in
    "arrange")
        arrange_all_displays
        ;;
    "setup")
        setup_floating_windows
        ;;
    "test")
        echo "Testing window counting..."
        displays=$(yabai -m query --displays | jq -r '.[].index')
        for display_id in $displays; do
            count=$(get_managed_windows_count "$display_id")
            echo "Display $display_id: $count managed windows"
        done
        ;;
    *)
        main
        ;;
esac
