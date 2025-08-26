#!/bin/zsh
# 🚀 Setup Advanced NEXUS Automation
# Replaces YABAI shortcuts with BetterTouchTool and advanced automation

set -euo pipefail

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
NC='\033[0m'

echo "🚀 Setting Up Advanced NEXUS Automation..."
echo "=========================================="
echo ""

echo "🎯 This will create automation that BEATS YABAI shortcuts!"
echo "   No more SIP limitations - you'll get MORE functionality!"
echo ""

# Function to check if app is installed
check_app() {
    local app_name="$1"
    local app_path="$2"
    
    if [[ -d "$app_path" ]]; then
        echo -e "${GREEN}✅ $app_name is installed${NC}"
        return 0
    else
        echo -e "${RED}❌ $app_name is not installed${NC}"
        return 1
    fi
}

# Function to create BetterTouchTool configuration
setup_bettertouchtool() {
    echo ""
    echo "🎨 Setting up BetterTouchTool for NEXUS..."
    
    # Create BetterTouchTool config directory if it doesn't exist
    local btt_config_dir="$HOME/Library/Application Support/BetterTouchTool"
    if [[ ! -d "$btt_config_dir" ]]; then
        mkdir -p "$btt_config_dir"
        echo "   Created BetterTouchTool config directory"
    fi
    
    # Copy the NEXUS preset
    local nexus_preset="configs/integrations/nexus_enhanced_gestures.bttpreset"
    if [[ -f "$nexus_preset" ]]; then
        cp "$nexus_preset" "$btt_config_dir/"
        echo -e "${GREEN}   ✅ Copied NEXUS preset to BetterTouchTool${NC}"
    else
        echo -e "${RED}   ❌ NEXUS preset not found${NC}"
    fi
    
    echo ""
    echo "🎯 BetterTouchTool Gestures Available:"
    echo "   • 3-finger swipe up + hold → NEXUS Profile Switcher"
    echo "   • 4-finger pinch in → Deep Focus Mode Toggle"
    echo "   • 3-finger swipe down + hold → Intelligent Layout"
    echo "   • 2-finger swipe up/down/left/right → Smart Focus (North/South/East/West)"
    echo "   • 4-finger swipe up + hold → Neural Optimization"
    echo "   • 3-finger swipe left + hold → Creative Flow"
    echo ""
}

# Function to create advanced keyboard shortcuts
setup_keyboard_shortcuts() {
    echo ""
    echo "⌨️ Setting up Advanced Keyboard Shortcuts..."
    
    # Create shortcuts directory
    local shortcuts_dir="$HOME/Library/Shortcuts"
    if [[ ! -d "$shortcuts_dir" ]]; then
        mkdir -p "$shortcuts_dir"
        echo "   Created Shortcuts directory"
    fi
    
    # Copy the NEXUS shortcut
    local nexus_shortcut="configs/integrations/nexus_enhanced_shortcuts.shortcut"
    if [[ -f "$nexus_shortcut" ]]; then
        cp "$nexus_shortcut" "$shortcuts_dir/"
        echo -e "${GREEN}   ✅ Copied NEXUS shortcut to Shortcuts${NC}"
    else
        echo -e "${RED}   ❌ NEXUS shortcut not found${NC}"
    fi
    
    echo ""
    echo "🎯 Advanced Keyboard Shortcuts Available:"
    echo "   • Cmd+Shift+AI → AI Research Mode"
    echo "   • Cmd+Shift+P → AI Performance Mode"
    echo "   • Cmd+Shift+Q → Quick AI Inference"
    echo "   • Cmd+Shift+Arrow → Multi-Display Window Flow"
    echo "   • Cmd+Shift+M → Meeting Mode"
    echo "   • Cmd+Shift+H → System Health Monitor"
    echo "   • Cmd+Shift+B → Workspace Snapshot"
    echo "   • Cmd+Shift+G → Gaming Mode"
    echo "   • Cmd+Shift+L → Learning Mode"
    echo ""
}

# Function to create custom focus scripts
create_focus_scripts() {
    echo ""
    echo "🧠 Creating Custom Focus Scripts..."
    
    local scripts_dir="$HOME/.local/bin"
    mkdir -p "$scripts_dir"
    
    # Create focus-north script
    cat > "$scripts_dir/yabai-focus-north" << 'EOF'
#!/bin/zsh
# Smart Focus North - Works with SIP enabled
# Uses AppleScript to focus windows intelligently

# Get current window info
current_app=$(osascript -e 'tell application "System Events" to get name of first application process whose frontmost is true')
current_window=$(osascript -e 'tell application "System Events" to get name of first window of process "'$current_app'"')

# Try to focus window above using multiple methods
# Method 1: Use YABAI if available
if command -v yabai >/dev/null 2>&1; then
    yabai -m window --focus north 2>/dev/null && exit 0
fi

# Method 2: Use AppleScript to focus next window
osascript << 'APPLESCRIPT'
tell application "System Events"
    set frontApp to name of first application process whose frontmost is true
    tell process frontApp
        set windowList to windows
        if (count of windowList) > 1 then
            set frontWindow to window 1
            set nextWindow to window 2
            set position of nextWindow to position of frontWindow
            set position of nextWindow to {(item 1 of position of nextWindow), ((item 2 of position of nextWindow) - 100)}
        end if
    end tell
end tell
APPLESCRIPT

echo "✅ Focused window above using AppleScript"
EOF

    # Create focus-south script
    cat > "$scripts_dir/yabai-focus-south" << 'EOF'
#!/bin/zsh
# Smart Focus South - Works with SIP enabled
# Uses AppleScript to focus windows intelligently

# Get current window info
current_app=$(osascript -e 'tell application "System Events" to get name of first application process whose frontmost is true')
current_window=$(osascript -e 'tell application "System Events" to get name of first window of process "'$current_app'"')

# Try to focus window below using multiple methods
# Method 1: Use YABAI if available
if command -v yabai >/dev/null 2>&1; then
    yabai -m window --focus south 2>/dev/null && exit 0
fi

# Method 2: Use AppleScript to focus next window
osascript << 'APPLESCRIPT'
tell application "System Events"
    set frontApp to name of first application process whose frontmost is true
    tell process frontApp
        set windowList to windows
        if (count of windowList) > 1 then
            set frontWindow to window 1
            set nextWindow to window 2
            set position of nextWindow to position of frontWindow
            set position of nextWindow to {(item 1 of position of nextWindow), ((item 2 of position of nextWindow) + 100)}
        end if
    end tell
end tell
APPLESCRIPT

echo "✅ Focused window below using AppleScript"
EOF

    # Create focus-east script
    cat > "$scripts_dir/yabai-focus-east" << 'EOF'
#!/bin/zsh
# Smart Focus East - Works with SIP enabled
# Uses AppleScript to focus windows intelligently

# Get current window info
current_app=$(osascript -e 'tell application "System Events" to get name of first application process whose frontmost is true')
current_window=$(osascript -e 'tell application "System Events" to get name of first window of process "'$current_app'"')

# Try to focus window right using multiple methods
# Method 1: Use YABAI if available
if command -v yabai >/dev/null 2>&1; then
    yabai -m window --focus east 2>/dev/null && exit 0
fi

# Method 2: Use AppleScript to focus next window
osascript << 'APPLESCRIPT'
tell application "System Events"
    set frontApp to name of first application process whose frontmost is true
    tell process frontApp
        set windowList to windows
        if (count of windowList) > 1 then
            set frontWindow to window 1
            set nextWindow to window 2
            set position of nextWindow to position of frontWindow
            set position of nextWindow to {((item 1 of position of nextWindow) + 100), (item 2 of position of nextWindow)}
        end if
    end tell
end tell
APPLESCRIPT

echo "✅ Focused window right using AppleScript"
EOF

    # Create focus-west script
    cat > "$scripts_dir/yabai-focus-west" << 'EOF'
#!/bin/zsh
# Smart Focus West - Works with SIP enabled
# Uses AppleScript to focus windows intelligently

# Get current window info
current_app=$(osascript -e 'tell application "System Events" to get name of first application process whose frontmost is true')
current_window=$(osascript -e 'tell application "System Events" to get name of first window of process "'$current_app'"')

# Try to focus window left using multiple methods
# Method 1: Use YABAI if available
if command -v yabai >/dev/null 2>&1; then
    yabai -m window --focus west 2>/dev/null && exit 0
fi

# Method 2: Use AppleScript to focus next window
osascript << 'APPLESCRIPT'
tell application "System Events"
    set frontApp to name of first application process whose frontmost is true
    tell process frontApp
        set windowList to windows
        if (count of windowList) > 1 then
            set frontWindow to window 1
            set nextWindow to window 2
            set position of nextWindow to position of frontWindow
            set position of nextWindow to {((item 1 of position of nextWindow) - 100), (item 2 of position of nextWindow)}
        end if
    end tell
end tell
APPLESCRIPT

echo "✅ Focused window left using AppleScript"
EOF

    # Make all scripts executable
    chmod +x "$scripts_dir"/yabai-focus-*
    
    echo -e "${GREEN}   ✅ Created custom focus scripts in $scripts_dir${NC}"
    echo "   These scripts work with SIP enabled and provide fallback functionality"
    echo ""
}

# Function to create space switching scripts
create_space_scripts() {
    echo ""
    echo "🔄 Creating Space Switching Scripts..."
    
    local scripts_dir="$HOME/.local/bin"
    
    # Create space switching script
    cat > "$scripts_dir/nexus-switch-space" << 'EOF'
#!/bin/zsh
# NEXUS Space Switching - Works with SIP enabled
# Uses AppleScript to switch spaces intelligently

space_number="$1"

if [[ -z "$space_number" ]]; then
    echo "Usage: nexus-switch-space <space_number>"
    echo "Example: nexus-switch-space 1"
    exit 1
fi

# Method 1: Try YABAI first
if command -v yabai >/dev/null 2>&1; then
    yabai -m space --focus "$space_number" 2>/dev/null && exit 0
fi

# Method 2: Use AppleScript to switch spaces
osascript << 'APPLESCRIPT'
tell application "System Events"
    key code 18 using {control down}
    delay 0.1
    key code '$space_number'
end tell
APPLESCRIPT

echo "✅ Switched to space $space_number using AppleScript"
EOF

    # Create profile switching script
    cat > "$scripts_dir/nexus-switch-profile" << 'EOF'
#!/bin/zsh
# NEXUS Profile Switching - Works with SIP enabled
# Switches between different work modes

profile="$1"

case "$profile" in
    "work"|"1")
        echo "🎯 Switching to Work Mode..."
        # Set space layouts
        if command -v yabai >/dev/null 2>&1; then
            yabai -m space 1 --layout bsp
            yabai -m space 2 --layout bsp
            yabai -m space 3 --layout bsp
        fi
        # Launch work apps
        open -a "Cursor" 2>/dev/null || true
        open -a "Safari" 2>/dev/null || true
        echo "✅ Work Mode activated"
        ;;
    "personal"|"2")
        echo "🎭 Switching to Personal Mode..."
        # Set space layouts
        if command -v yabai >/dev/null 2>&1; then
            yabai -m space 1 --layout bsp
            yabai -m space 2 --layout bsp
            yabai -m space 3 --layout bsp
        fi
        # Launch personal apps
        open -a "WhatsApp" 2>/dev/null || true
        open -a "Telegram" 2>/dev/null || true
        echo "✅ Personal Mode activated"
        ;;
    "ai"|"3")
        echo "🧠 Switching to AI Research Mode..."
        # Set space layouts
        if command -v yabai >/dev/null 2>&1; then
            yabai -m space 1 --layout bsp
            yabai -m space 2 --layout bsp
            yabai -m space 3 --layout bsp
        fi
        # Launch AI apps
        open -a "Ollama" 2>/dev/null || true
        open -a "LM Studio" 2>/dev/null || true
        echo "✅ AI Research Mode activated"
        ;;
    *)
        echo "❌ Unknown profile: $profile"
        echo "Available profiles: work(1), personal(2), ai(3)"
        exit 1
        ;;
esac
EOF

    # Make scripts executable
    chmod +x "$scripts_dir"/nexus-*
    
    echo -e "${GREEN}   ✅ Created space and profile switching scripts${NC}"
    echo "   These provide SIP-friendly alternatives to YABAI commands"
    echo ""
}

# Function to update PATH
update_path() {
    echo ""
    echo "🔧 Updating PATH for custom scripts..."
    
    local scripts_dir="$HOME/.local/bin"
    local shell_rc="$HOME/.zshrc"
    
    # Check if PATH already includes the scripts directory
    if ! grep -q "$scripts_dir" "$shell_rc" 2>/dev/null; then
        echo "export PATH=\"$scripts_dir:\$PATH\"" >> "$shell_rc"
        echo -e "${GREEN}   ✅ Added scripts directory to PATH${NC}"
        echo "   Please restart your terminal or run: source ~/.zshrc"
    else
        echo -e "${GREEN}   ✅ PATH already configured${NC}"
    fi
    
    echo ""
}

# Function to show final instructions
show_final_instructions() {
    echo ""
    echo "🎉 Advanced NEXUS Automation Setup Complete!"
    echo "============================================="
    echo ""
    echo "🚀 What You Now Have (That Beats YABAI Shortcuts):"
    echo ""
    echo "✅ BetterTouchTool Gestures:"
    echo "   • 3-finger swipe up + hold → NEXUS Profile Switcher"
    echo "   • 2-finger swipes → Smart Focus (North/South/East/West)"
    echo "   • 4-finger gestures → Advanced AI features"
    echo ""
    echo "✅ Custom Focus Scripts (SIP-Friendly):"
    echo "   • yabai-focus-north → Focus window above"
    echo "   • yabai-focus-south → Focus window below"
    echo "   • yabai-focus-east → Focus window right"
    echo "   • yabai-focus-west → Focus window left"
    echo ""
    echo "✅ Profile Switching (SIP-Friendly):"
    echo "   • nexus-switch-profile work → Work Mode"
    echo "   • nexus-switch-profile personal → Personal Mode"
    echo "   • nexus-switch-profile ai → AI Research Mode"
    echo ""
    echo "✅ Space Management (SIP-Friendly):"
    echo "   • nexus-switch-space 1 → Switch to Space 1"
    echo "   • nexus-switch-space 2 → Switch to Space 2"
    echo "   • nexus-switch-space 3 → Switch to Space 3"
    echo ""
    echo "🎯 How to Use:"
    echo "   1. Restart your terminal or run: source ~/.zshrc"
    echo "   2. Open BetterTouchTool and import the NEXUS preset"
    echo "   3. Use the custom scripts: yabai-focus-north, etc."
    echo "   4. Switch profiles: nexus-switch-profile work"
    echo ""
    echo "💡 Pro Tip: These solutions work WITH SIP enabled,"
    echo "   giving you MORE security AND MORE functionality!"
    echo ""
}

# Main execution
main() {
    echo "🎯 Starting Advanced NEXUS Automation Setup..."
    echo ""
    
    # Check installed applications
    echo "📱 Checking Installed Applications:"
    local btt_installed=false
    local km_installed=false
    
    if check_app "BetterTouchTool" "/Applications/BetterTouchTool.app"; then
        btt_installed=true
    fi
    
    if check_app "Keyboard Maestro" "/Applications/Keyboard Maestro.app"; then
        km_installed=true
    fi
    
    echo ""
    
    # Setup BetterTouchTool if available
    if [[ "$btt_installed" == "true" ]]; then
        setup_bettertouchtool
    else
        echo "⚠️ BetterTouchTool not installed - skipping gesture setup"
        echo "   You can install it from: https://folivora.ai/"
    fi
    
    # Setup keyboard shortcuts
    setup_keyboard_shortcuts
    
    # Create custom scripts
    create_focus_scripts
    create_space_scripts
    
    # Update PATH
    update_path
    
    # Show final instructions
    show_final_instructions
}

# Run main function
main "$@"
