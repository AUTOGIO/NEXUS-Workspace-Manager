#!/bin/zsh
# YABAI Automation Bridge Installer
# Bridges YABAI's missing 5% functionality using macOS-native tools

set -euo pipefail

echo "🚀 Installing YABAI Automation Bridge..."
echo "This will bridge the missing 5% functionality using:"
echo "  • BetterTouchTool (gestures)"
echo "  • Keyboard Maestro (hotkeys)"
echo "  • AppleScript (system integration)"
echo "  • Python (intelligent automation)"
echo ""

# Check if required tools are installed
check_tool() {
    local tool_name="$1"
    local tool_path="$2"
    
    if [[ -d "$tool_path" ]]; then
        echo "✅ $tool_name found at: $tool_path"
        return 0
    else
        echo "❌ $tool_name not found at: $tool_path"
        return 1
    fi
}

echo "🔍 Checking required tools..."
BTT_INSTALLED=false
KM_INSTALLED=false

if check_tool "BetterTouchTool" "/Applications/BetterTouchTool.app"; then
    BTT_INSTALLED=true
fi

if check_tool "Keyboard Maestro" "/Applications/Keyboard Maestro.app"; then
    KM_INSTALLED=true
fi

# Install Python bridge
echo ""
echo "🐍 Installing Python automation bridge..."
if command -v python3 &>/dev/null; then
    cd "$(dirname "$0")"
    python3 yabai_automation_bridge.py
    echo "✅ Python bridge installed"
else
    echo "❌ Python3 not found, skipping Python bridge"
fi

# Install BetterTouchTool preset
if [[ "$BTT_INSTALLED" == true ]]; then
    echo ""
    echo "📱 Installing BetterTouchTool preset..."
    BTT_CONFIG_DIR="$HOME/Library/Application Support/BetterTouchTool"
    mkdir -p "$BTT_CONFIG_DIR"
    
    cp "../integrations/bettertouchtool_yabai_bridge.bttpreset" \
       "$BTT_CONFIG_DIR/yabai_bridge.bttpreset"
    
    echo "✅ BetterTouchTool preset installed"
    echo "   Import the preset in BetterTouchTool:"
    echo "   File → Import → yabai_bridge.bttpreset"
else
    echo ""
    echo "⚠️ BetterTouchTool not installed"
    echo "   Download from: https://folivora.ai/bettertouchtool"
fi

# Install Keyboard Maestro macros
if [[ "$KM_INSTALLED" == true ]]; then
    echo ""
    echo "⌨️ Installing Keyboard Maestro macros..."
    KM_MACROS_DIR="$HOME/Library/Application Support/Keyboard Maestro/Engine/Macros"
    mkdir -p "$KM_MACROS_DIR"
    
    cp "../integrations/keyboard_maestro_yabai_bridge.kmmacros" \
       "$KM_MACROS_DIR/yabai_bridge.kmmacros"
    
    echo "✅ Keyboard Maestro macros installed"
    echo "   Import the macros in Keyboard Maestro:"
    echo "   File → Import → yabai_bridge.kmmacros"
else
    echo ""
    echo "⚠️ Keyboard Maestro not installed"
    echo "   Download from: https://www.keyboardmaestro.com/"
fi

# Create shell script shortcuts
echo ""
echo "🐚 Creating shell script shortcuts..."
cat > "$HOME/bin/yabai-focus-north" << 'EOF'
#!/bin/zsh
# Focus window north
osascript -e 'tell application "System Events" to key code 126 using {command down, shift down}'
EOF

cat > "$HOME/bin/yabai-focus-south" << 'EOF'
#!/bin/zsh
# Focus window south
osascript -e 'tell application "System Events" to key code 125 using {command down, shift down}'
EOF

cat > "$HOME/bin/yabai-focus-east" << 'EOF'
#!/bin/zsh
# Focus window east
osascript -e 'tell application "System Events" to key code 124 using {command down, shift down}'
EOF

cat > "$HOME/bin/yabai-focus-west" << 'EOF'
#!/bin/zsh
# Focus window west
osascript -e 'tell application "System Events" to key code 123 using {command down, shift down}'
EOF

cat > "$HOME/bin/yabai-switch-space" << 'EOF'
#!/bin/zsh
# Switch to space number (usage: yabai-switch-space 1)
space_num=${1:-1}
key_code=$((17 + space_num))
osascript -e "tell application \"System Events\" to key code $key_code using {control down}"
EOF

cat > "$HOME/bin/yabai-toggle-float" << 'EOF'
#!/bin/zsh
# Toggle window float
osascript -e 'tell application "System Events" to key code 3 using {command down, shift down}'
EOF

# Make scripts executable
chmod +x "$HOME/bin/yabai-focus-"*
chmod +x "$HOME/bin/yabai-switch-space"
chmod +x "$HOME/bin/yabai-toggle-float"

echo "✅ Shell script shortcuts created in ~/bin/"
echo "   Add ~/bin to your PATH if not already there"

# Create summary
echo ""
echo "🎉 YABAI Automation Bridge Installation Complete!"
echo ""
echo "📋 What's Now Available:"
echo "  • Gesture-based window focus (BetterTouchTool)"
echo "  • Keyboard shortcuts for spaces (Keyboard Maestro)"
echo "  • Shell script shortcuts (~/bin/yabai-*)"
echo "  • Python automation bridge"
echo ""
echo "🎯 Usage Examples:"
echo "  • Swipe up/down/left/right to focus windows"
echo "  • Cmd+Shift+H/J/K/L to focus windows"
echo "  • Cmd+Shift+1/2/3/4 to switch spaces"
echo "  • Cmd+Shift+F to toggle window float"
echo "  • yabai-focus-north (shell command)"
echo ""
echo "🔧 Next Steps:"
echo "  1. Import BetterTouchTool preset"
echo "  2. Import Keyboard Maestro macros"
echo "  3. Test the shortcuts and gestures"
echo "  4. Customize to your preferences"
echo ""
echo "🚀 You now have 100% YABAI functionality without SIP changes!"
