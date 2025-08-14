#!/bin/zsh

# NEXUS Apple Shortcuts Setup Script
# Creates and configures Apple Shortcuts integration

set -e

echo "🎯 Setting up NEXUS Apple Shortcuts Integration..."
echo "=================================================="

# Configuration
SHORTCUTS_DIR="$HOME/Library/Shortcuts"
PROJECT_DIR="/Users/eduardof.giovannini/Library/Mobile Documents/com~apple~CloudDocs/Obsidian/Projects/FINALIZADO/YABAI"
SCRIPTS_DIR="$PROJECT_DIR/scripts/shortcuts"

# Create shortcuts directory if it doesn't exist
mkdir -p "$SHORTCUTS_DIR"

echo "📁 Creating shortcut launcher script..."

# Create the main launcher script
cat > "$SHORTCUTS_DIR/nexus_workspace_launcher.sh" << 'EOF'
#!/bin/zsh

# NEXUS Workspace Launcher for Apple Shortcuts
# Launches workspace profiles directly

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
    echo "❌ No profile specified"
    echo "Usage: $0 <profile_name>"
    exit 1
else
    launch_profile "$1"
fi
EOF

# Make it executable
chmod +x "$SHORTCUTS_DIR/nexus_workspace_launcher.sh"

echo "📱 Creating Apple Shortcuts workflow..."

# Create the Apple Shortcuts workflow
cat > "$SHORTCUTS_DIR/NEXUS_Workspace_Launcher.shortcut" << 'EOF'
{
  "WFWorkflow": {
    "WFWorkflowClientRelease": "1230",
    "WFWorkflowClientVersion": "1230",
    "WFWorkflowIcon": {
      "WFWorkflowIconStartColor": 4282601983,
      "WFWorkflowIconImageData": {
        "WFSerializationType": "WFBase64EncodedString",
        "Value": "iVBORw0KGgoAAAANSUhEUgAAAIAAAACACAYAAADDPmHLAAAACXBIWXMAAAsTAAALEwEAmpwYAAAF0WlUWHRYTUw6Y29tLmFkb2JlLnhtcAAAAAAAPD94cGFja2V0IGJlZ2luPSLvu78i iglkPSJXNU0wTXBDZWhpSHpyZVN6TlRjemtjOWQiPz4gPHg6eG1wbWV0YSB4bWxuczp4PSJhZG9iZTpuczptZXRhLyIgeDp4bXB0az0iQWRvYmUgWE1QIENvcmUgNy4yLWMwMDAgNzkuMWI2NWE3OWI0LCAyMDIyLzA2LzEzLTIyOjAxOjAxICAgICAgICAiPiA8cmRmOlJERiB4bWxuczpypmY9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkvMDIvMjItcmRmLXN5bnRheC1ucyMiPiA8cmRmOkRlc2NyaXB0aW9uIHJkZjphYm91dD0iIiB4bWxuczp4bXA9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC8iIHhtbG5zOnhtcE1NPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvbW0vIiB4bWxuczpzdEV2dD0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL3NUeXBlL1Jlc291cmNlRXZlbnQjIiB4bWxuczpkYz0iaHR0cDovL3B1cmwub3JnL2RjL2VsZW1lbnRzLzEuMS8iIHhtbG5zOnBob3Rvc2hvcD0iaHR0cDovL25zLmFkb2JlLmNvbS9waG90b3Nob3AvMS4wLyIgeG1wOkNyZWF0b3JUb29sPSJBZG9iZSBQaG90b3Nob3AgMjQuMCAoTWFjaW50b3NoKSIgeG1wOkNyZWF0ZURhdGU9IjIwMjUtMDgtMTJUMTA6MDA6MDArMDQ6MDAiIHhtcDpNZXRhZGF0YURhdGU9IjIwMjUtMDgtMTJUMTA6MDA6MDArMDQ6MDAiIHhtcDpNb2RpZnlEYXRlPSIyMDI1LTA4LTEyVDEwOjAwOjAwKzA0OjAwIiB4bXBNTTpJbnN0YW5jZUlEPSJ4bXAuaWlkOjY5ZDM4YmM1LTM4ZTAtNDI0Ny1hMzBkLTNmOWNiMzM3NzM0YyIgeG1wTU06RG9jdW1lbnRJRD0iYWRvYmU6ZG9jaWQ6cGhvdG9zaG9wOjY5ZDM4YmM1LTM4ZTAtNDI0Ny1hMzBkLTNmOWNiMzM3NzM0YyIgeG1wTU06T3JpZ2luYWxEb2N1bWVudElEPSJ4bXAuZGlkOjY5ZDM4YmM1LTM4ZTAtNDI0Ny1hMzBkLTNmOWNiMzM3NzM0YyIgZGM6Zm9ybWF0PSJpbWFnZS9wbmciIHBob3Rvc2hvcDpDb2xvck1vZGU9IjMiPiA8eG1wTU06SGlzdG9yeT4gPHJkZjpTZXE+IDxyZGY6bGkgc3RFdnQ6YWN0aW9uPSJjcmVhdGVkIiBzdEV2dDppbnN0YW5jZUlEPSJ4bXAuaWlkOjY5ZDM4YmM1LTM4ZTAtNDI0Ny1hMzBkLTNmOWNiMzM3NzM0YyIgc3RFdnQ6d2hlbj0iMjAyNS0wOC0xMlQxMDowMDowMCswNDowMCIgc3RFdnQ6c29mdHdhcmVBZ2VudD0iQWRvYmUgUGhvdG9zaG9wIDI0LjAgKE1hY2ludG9zaCkiLz4gPC9yZGY6U2VxPiA8L3htcE1NOkhpc3Rvcnk+IDwvcmRmOkRlc2NyaXB0aW9uPiA8L3JkZjpSREY+IDwveDp4bXBtZXRhPiA8P3hwYWNrZXQgZW5kPSJyIj8+"
      }
    },
    "WFWorkflowImportQuestions": [],
    "WFWorkflowInput": {
      "WFWorkflowInputRequired": false,
      "WFWorkflowInputTypes": []
    },
    "WFWorkflowItems": [
      {
        "WFItemSpecifier": "ShortcutInput",
        "WFWorkflowItemIdentifier": "A1B2C3D4-E5F6-7890-ABCD-EF1234567890"
      },
      {
        "WFWorkflowItemIdentifier": "B2C3D4E5-F6G7-8901-BCDE-F23456789012",
        "WFWorkflowItemName": "Choose from Menu",
        "WFWorkflowItemParameters": {
          "WFMenuPrompt": "🎯 Select NEXUS Workspace Profile",
          "WFMenuItems": [
            "🤖 AI Business Profile",
            "🎨 AI Content Creation",
            "💻 AI Development",
            "🎮 AI Gaming",
            "📚 AI Learning",
            "🔬 AI Research",
            "💼 Business Profile",
            "✍️ Content Creation",
            "🎯 Focus Profile",
            "🎮 Gaming Profile",
            "📖 Learning Profile",
            "👤 Personal Profile",
            "💼 Work Profile"
          ]
        },
        "WFWorkflowItemType": "WFChooseFromMenuAction"
      },
      {
        "WFWorkflowItemIdentifier": "C3D4E5F6-G7H8-9012-CDEF-345678901234",
        "WFWorkflowItemName": "Run Shell Script",
        "WFWorkflowItemParameters": {
          "WFShellScriptCommand": "/Users/eduardof.giovannini/Library/Shortcuts/nexus_workspace_launcher.sh",
          "WFShellScriptPassInput": "as arguments",
          "WFShellScriptWorkingDirectory": "/Users/eduardof.giovannini/Library/Mobile Documents/com~apple~CloudDocs/Obsidian/Projects/FINALIZADO/YABAI"
        },
        "WFWorkflowItemType": "WFShellScriptAction"
      }
    ],
    "WFWorkflowName": "NEXUS Workspace Launcher",
    "WFWorkflowOutput": {
      "WFWorkflowOutputItems": []
    },
    "WFWorkflowTypes": [
      "WatchKit",
      "NCWidgetExtension"
    ]
  }
}
EOF

echo "📋 Creating installation instructions..."

# Create installation instructions
cat > "$SHORTCUTS_DIR/INSTALL_NEXUS_SHORTCUT.md" << 'EOF'
# 🎯 NEXUS Workspace Launcher - Apple Shortcuts Setup

## 📱 Installation Steps

### 1. Import the Shortcut
1. Open the **Shortcuts** app on your Mac
2. Click **File** → **Import** or press `Cmd+I`
3. Navigate to: `~/Library/Shortcuts/NEXUS_Workspace_Launcher.shortcut`
4. Click **Import**

### 2. Grant Permissions
The shortcut will request permissions for:
- **Accessibility**: To control system settings
- **Full Disk Access**: To run scripts and access files
- **Automation**: To control other applications

### 3. Test the Shortcut
1. Double-click the shortcut in Shortcuts app
2. Select a workspace profile from the menu
3. The profile should activate automatically

## 🚀 Usage

### From Shortcuts App
- Double-click the shortcut
- Choose your workspace profile
- Profile activates automatically

### From Spotlight
- Press `Cmd+Space`
- Type "NEXUS Workspace Launcher"
- Press Enter and select profile

### From Menu Bar
- Add to menu bar for quick access
- Click the shortcut icon anytime

## 🔧 Customization

### Add to Menu Bar
1. Right-click the shortcut in Shortcuts app
2. Select **Add to Menu Bar**

### Keyboard Shortcut
1. Open **System Preferences** → **Keyboard** → **Shortcuts**
2. Add custom shortcut for the workflow

### Quick Actions
1. Right-click files/folders
2. Select **Quick Actions** → **NEXUS Workspace Launcher**

## 📁 Available Profiles

### 🤖 AI-Enhanced Profiles
- **AI Business Profile**: AI-powered business workflows
- **AI Content Creation**: AI-assisted content creation
- **AI Development**: AI-enhanced development environment
- **AI Gaming**: AI-optimized gaming setup
- **AI Learning**: AI-powered learning environment
- **AI Research**: AI research and development

### 💼 Standard Profiles
- **Business Profile**: Professional business setup
- **Content Creation**: Video, design, and writing
- **Focus Profile**: Distraction-free deep work
- **Gaming Profile**: Gaming and entertainment
- **Learning Profile**: Educational and study setup
- **Personal Profile**: Personal and social use
- **Work Profile**: Development and productivity

## 🆘 Troubleshooting

### Permission Issues
- Check **System Preferences** → **Security & Privacy**
- Ensure all required permissions are granted

### Script Not Found
- Verify the launcher script exists at: `~/Library/Shortcuts/nexus_workspace_launcher.sh`
- Check file permissions (should be executable)

### Profile Not Loading
- Ensure YABAI is running: `yabai --start`
- Check profile script exists in configs/profiles/

## 🔗 Integration

This shortcut integrates with:
- **YABAI**: Window management
- **SKHD**: Hotkey daemon
- **NEXUS**: AI-powered workspace optimization
- **ActivityWatch**: Time tracking
- **N8N**: Workflow automation

## 📞 Support

For issues or questions:
- Check the NEXUS documentation
- Review system logs for errors
- Ensure all dependencies are installed
EOF

echo "✅ Setup complete!"
echo ""
echo "📱 Files created in: $SHORTCUTS_DIR"
echo "   - nexus_workspace_launcher.sh (executable launcher)"
echo "   - NEXUS_Workspace_Launcher.shortcut (Apple Shortcuts workflow)"
echo "   - INSTALL_NEXUS_SHORTCUT.md (installation instructions)"
echo ""
echo "🎯 Next steps:"
echo "   1. Open Shortcuts app"
echo "   2. Import NEXUS_Workspace_Launcher.shortcut"
echo "   3. Grant necessary permissions"
echo "   4. Test with a workspace profile"
echo ""
echo "🚀 Your NEXUS workspace profiles are now accessible via Apple Shortcuts!"
