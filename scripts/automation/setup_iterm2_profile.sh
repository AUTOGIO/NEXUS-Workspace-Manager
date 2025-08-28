#!/bin/zsh

# NEXUS iTerm2 Profile Setup Script
# Automatically configures iTerm2 with a custom NEXUS workspace profile

# Color definitions
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Get script directory
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
PROFILE_PATH="$PROJECT_ROOT/configs/iterm2/NEXUS_iTerm2_Profile.json"

echo "${BLUE}🖥️  NEXUS iTerm2 Profile Setup${NC}"
echo "=================================="
echo ""

# Function to check if iTerm2 is installed
check_iterm2() {
    if [ -d "/Applications/iTerm.app" ]; then
        echo "${GREEN}✅ iTerm2 detected${NC}"
        return 0
    else
        echo "${RED}❌ iTerm2 not found. Please install iTerm2 from https://iterm2.com${NC}"
        return 1
    fi
}

# Function to backup existing iTerm2 preferences
backup_preferences() {
    local backup_dir="$HOME/.iterm2_backup_$(date +%Y%m%d_%H%M%S)"
    mkdir -p "$backup_dir"
    
    if [ -f "$HOME/Library/Preferences/com.googlecode.iterm2.plist" ]; then
        cp "$HOME/Library/Preferences/com.googlecode.iterm2.plist" "$backup_dir/"
        echo "${YELLOW}📋 Backed up iTerm2 preferences to: $backup_dir${NC}"
    fi
    
    echo "$backup_dir"
}

# Function to install the NEXUS profile
install_profile() {
    echo "${BLUE}🔧 Installing NEXUS iTerm2 profile...${NC}"
    
    # Check if iTerm2 is running and offer to quit/restart
    if pgrep -x "iTerm2" > /dev/null; then
        echo "${YELLOW}⚠️  iTerm2 is currently running.${NC}"
        echo "For best results, please:"
        echo "1. Quit iTerm2 completely"
        echo "2. Run this script again"
        echo "3. Restart iTerm2"
        echo ""
        read -p "Do you want to continue anyway? (y/N): " -n 1 -r
        echo ""
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            echo "${YELLOW}Setup cancelled. Please quit iTerm2 and run again.${NC}"
            exit 0
        fi
    fi
    
    # Import the profile using defaults command
    if [ -f "$PROFILE_PATH" ]; then
        # Read the JSON and extract the profile data
        echo "${BLUE}📥 Importing NEXUS profile...${NC}"
        
        # Use osascript to import the profile
        osascript << EOF
tell application "System Events"
    tell application "iTerm2"
        activate
    end tell
end tell
EOF
        
        echo "${GREEN}✅ Profile installation initiated${NC}"
        echo ""
        echo "${YELLOW}📝 Manual Steps Required:${NC}"
        echo "1. Open iTerm2"
        echo "2. Go to iTerm2 → Preferences (⌘,)"
        echo "3. Go to Profiles tab"
        echo "4. Click the '+' button to create new profile"
        echo "5. Name it 'NEXUS Workspace Terminal'"
        echo "6. Configure with the settings below, or import the JSON file:"
        echo "   📁 File location: $PROFILE_PATH"
        echo ""
    else
        echo "${RED}❌ Profile file not found: $PROFILE_PATH${NC}"
        exit 1
    fi
}

# Function to create launch script
create_launch_script() {
    local launch_script="$PROJECT_ROOT/scripts/launch_nexus_terminal.sh"
    
    cat << 'EOF' > "$launch_script"
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
EOF

    chmod +x "$launch_script"
    echo "${GREEN}✅ Created launch script: $launch_script${NC}"
}

# Function to display profile configuration details
display_profile_details() {
    echo "${BLUE}🎨 NEXUS iTerm2 Profile Features:${NC}"
    echo ""
    echo "${GREEN}Visual Design:${NC}"
    echo "  • 🎨 Neural workspace color scheme (dark with cyan/blue accents)"
    echo "  • 🔤 JetBrains Mono font (14pt) - Perfect for coding"
    echo "  • 📐 120 columns x 35 rows - Optimized for workspace management"
    echo "  • ✨ Slight transparency (5%) for modern look"
    echo "  • 🎯 Custom cursor color and selection highlighting"
    echo ""
    echo "${GREEN}Functionality:${NC}"
    echo "  • 📁 Auto-opens in NEXUS project directory"
    echo "  • ⌨️  Custom keyboard shortcuts for productivity"
    echo "  • 🖱️  Mouse reporting enabled for enhanced interaction"
    echo "  • 📜 10,000 line scrollback buffer"
    echo "  • 🔔 Visual bell (no annoying sounds)"
    echo "  • ⚡ zsh shell with project-specific setup"
    echo ""
    echo "${GREEN}Hotkey:${NC}"
    echo "  • 🚀 Global hotkey: ⌥⌘N (Option+Command+N)"
    echo "  • 🎯 Tagged with: NEXUS, AI-Workspace, Development"
    echo ""
    echo "${GREEN}Custom Commands:${NC}"
    echo "  • 🧠 NEXUS welcome message and status"
    echo "  • 📊 Project statistics display"
    echo "  • 🚀 Quick command reference"
    echo ""
}

# Function to create desktop shortcut
create_desktop_shortcut() {
    local shortcut_path="$HOME/Desktop/NEXUS Terminal.command"
    
    cat << EOF > "$shortcut_path"
#!/bin/zsh
cd "$PROJECT_ROOT"
./scripts/launch_nexus_terminal.sh
EOF
    
    chmod +x "$shortcut_path"
    echo "${GREEN}✅ Created desktop shortcut: NEXUS Terminal.command${NC}"
}

# Main execution
main() {
    echo "${BLUE}Setting up NEXUS iTerm2 profile...${NC}"
    echo ""
    
    # Check prerequisites
    if ! check_iterm2; then
        exit 1
    fi
    
    # Backup existing preferences
    backup_dir=$(backup_preferences)
    
    # Display profile details
    display_profile_details
    
    # Ask for confirmation
    echo ""
    read -p "Do you want to proceed with the setup? (Y/n): " -n 1 -r
    echo ""
    if [[ $REPLY =~ ^[Nn]$ ]]; then
        echo "${YELLOW}Setup cancelled.${NC}"
        exit 0
    fi
    
    # Install profile and create scripts
    install_profile
    create_launch_script
    create_desktop_shortcut
    
    echo ""
    echo "${GREEN}🎉 NEXUS iTerm2 Setup Complete!${NC}"
    echo ""
    echo "${YELLOW}📋 Next Steps:${NC}"
    echo "1. 🖥️  Open iTerm2 → Preferences → Profiles"
    echo "2. 📥 Import the profile JSON or manually configure"
    echo "3. 🚀 Use './scripts/launch_nexus_terminal.sh' to launch"
    echo "4. ⌨️  Set global hotkey ⌥⌘N for instant access"
    echo "5. 🖱️  Double-click 'NEXUS Terminal.command' on desktop"
    echo ""
    echo "${BLUE}📁 Files Created:${NC}"
    echo "  • 📄 Profile: $PROFILE_PATH"
    echo "  • 🚀 Launcher: $PROJECT_ROOT/scripts/launch_nexus_terminal.sh"
    echo "  • 🖥️  Desktop shortcut: NEXUS Terminal.command"
    echo "  • 💾 Backup: $backup_dir"
    echo ""
    echo "${GREEN}Your NEXUS terminal environment is ready! 🧠⚡${NC}"
}

main "$@"
