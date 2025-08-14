#!/bin/zsh

# NEXUS Profiles Shortcut - Apple Shortcuts Optimized
# Provides a clean interface for selecting and launching workspace profiles

set -e

# Configuration
PROFILES_DIR="/Users/eduardof.giovannini/Library/Mobile Documents/com~apple~CloudDocs/Obsidian/Projects/FINALIZADO/YABAI/configs/profiles"
LAUNCHER_SCRIPT="/Users/eduardof.giovannini/Library/Mobile Documents/com~apple~CloudDocs/Obsidian/Projects/FINALIZADO/YABAI/launcher.sh"

# Function to get profile names (without .sh extension)
get_profile_names() {
    find "$PROFILES_DIR" -name "*.sh" -type f | while read -r profile; do
        basename "$profile" .sh
    done
}

# Function to launch profile
launch_profile() {
    local profile_name="$1"
    local profile_script="$PROFILES_DIR/${profile_name}.sh"
    
    if [[ -f "$profile_script" ]]; then
        echo "🚀 Launching: $profile_name"
        cd "$(dirname "$LAUNCHER_SCRIPT")"
        ./launcher.sh "$profile_name"
        echo "✅ Profile activated successfully!"
    else
        echo "❌ Profile not found: $profile_name"
        exit 1
    fi
}

# Function to show profile menu
show_profile_menu() {
    echo "🎯 NEXUS Workspace Profiles"
    echo "=========================="
    echo ""
    
    # Get all profile names
    local profiles=($(get_profile_names))
    local count=1
    
    # Display profiles with categories
    echo "🤖 AI-Enhanced Profiles:"
    for profile in "${profiles[@]}"; do
        if [[ "$profile" == ai_* ]]; then
            echo "  $count. $profile"
            ((count++))
        fi
    done
    
    echo ""
    echo "💼 Standard Profiles:"
    for profile in "${profiles[@]}"; do
        if [[ "$profile" != ai_* ]] && [[ "$profile" != "yabai_config" ]]; then
            echo "  $count. $profile"
            ((count++))
        fi
    done
    
    echo ""
    echo "Enter profile number or name: "
}

# Main execution
if [[ $# -eq 0 ]]; then
    # No arguments provided, show interactive menu
    show_profile_menu
    read -r selection
    
    # Handle numeric selection
    if [[ "$selection" =~ ^[0-9]+$ ]]; then
        local profiles=($(get_profile_names))
        if [[ "$selection" -ge 1 ]] && [[ "$selection" -le ${#profiles[@]} ]]; then
            selected_profile="${profiles[$((selection-1))]}"
        else
            echo "❌ Invalid selection number: $selection"
            exit 1
        fi
    else
        selected_profile="$selection"
    fi
    
    # Validate and launch
    if [[ -f "$PROFILES_DIR/${selected_profile}.sh" ]]; then
        launch_profile "$selected_profile"
    else
        echo "❌ Invalid selection: $selected_profile"
        exit 1
    fi
else
    # Direct profile launch
    launch_profile "$1"
fi
