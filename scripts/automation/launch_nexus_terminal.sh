#!/bin/zsh

# NEXUS Terminal Launcher
# Opens iTerm2 with the NEXUS profile and navigates to project directory

PROJECT_DIR="/Users/eduardof.giovannini/Desktop/Projects/YABAI"
PROFILE_NAME="NEXUS Workspace Terminal"

# Check if iTerm2 is installed
if [ ! -d "/Applications/iTerm.app" ]; then
    echo "❌ iTerm2 not found. Please install iTerm2 first."
    exit 1
fi

# Launch iTerm2 with NEXUS profile
osascript << APPLESCRIPT
tell application "iTerm2"
    activate
    
    try
        set nexusProfile to profile "$PROFILE_NAME"
        create window with profile nexusProfile
    on error
        -- If profile doesn't exist, create a new window with default profile
        create window with default profile
        tell current session of current window
            write text "echo '⚠️  NEXUS profile not found. Using default profile.'"
            write text "echo '💡 Run ./scripts/setup_iterm2_profile.sh to set up the NEXUS profile'"
        end tell
    end try
    
    tell current session of current window
        write text "cd \"$PROJECT_DIR\""
        write text "clear"
        write text "echo '🧠 NEXUS Workspace Terminal'"
        write text "echo '========================'"
        write text "echo ''"
        write text "echo '🚀 Quick Commands:'"
        write text "echo '  ./launcher.sh           - Main NEXUS launcher'"
        write text "echo '  ./scripts/system_performance_monitor.sh - Performance check'"
        write text "echo '  ./scripts/quick_app_launcher.sh         - Quick app launcher'"
        write text "echo '  ./scripts/nexus_floating_dashboard.sh   - Floating dashboard'"
        write text "echo ''"
        write text "echo '📊 Project Status:'"
        write text "git status --porcelain | wc -l | awk '{print \"  Modified files: \" \$1}'"
        write text "find . -name '*.py' | wc -l | awk '{print \"  Python files: \" \$1}'"
        write text "find . -name '*.sh' | wc -l | awk '{print \"  Shell scripts: \" \$1}'"
        write text "echo ''"
        write text "echo '🎯 Ready for AI-powered workspace management!'"
        write text "echo ''"
    end tell
end tell
APPLESCRIPT

echo "🧠 NEXUS Terminal launched!"
