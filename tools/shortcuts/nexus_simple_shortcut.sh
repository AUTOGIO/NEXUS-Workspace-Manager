#!/bin/zsh

# NEXUS Simple Profile Launcher
# Simple and robust profile selection

set -e

PROFILES_DIR="/Users/eduardof.giovannini/Library/Mobile Documents/com~apple~CloudDocs/Obsidian/Projects/FINALIZADO/YABAI/configs/profiles"
LAUNCHER_SCRIPT="/Users/eduardof.giovannini/Library/Mobile Documents/com~apple~CloudDocs/Obsidian/Projects/FINALIZADO/YABAI/launcher.sh"

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

# Main execution
if [[ $# -eq 0 ]]; then
    # No arguments provided, show available profiles
    echo "🎯 Available NEXUS Workspace Profiles:"
    echo "====================================="
    echo ""
    
    # List all profiles
    find "$PROFILES_DIR" -name "*.sh" -type f | while read -r profile; do
        basename "$profile" .sh
    done
    
    echo ""
    echo "Usage: $0 <profile_name>"
    echo "Example: $0 ai_business_profile"
    exit 0
else
    # Direct profile launch
    launch_profile "$1"
fi
