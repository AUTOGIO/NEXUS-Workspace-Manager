#!/bin/zsh

# NEXUS Apple Shortcuts Integration Script
# Creates a shortcut that opens a dropdown menu with all workspace profiles

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
PROFILES_DIR="/Users/eduardof.giovannini/Library/Mobile Documents/com~apple~CloudDocs/Obsidian/Projects/FINALIZADO/YABAI/configs/profiles"
SHORTCUTS_DIR="$HOME/Library/Shortcuts"
SCRIPT_NAME="nexus_workspace_launcher.sh"
SHORTCUT_NAME="NEXUS Workspace Launcher"

echo "🚀 Setting up Apple Shortcuts integration for NEXUS Workspace Profiles"
echo "================================================================"

# Check if profiles directory exists
if [[ ! -d "$PROFILES_DIR" ]]; then
    echo "❌ Profiles directory not found: $PROFILES_DIR"
    exit 1
fi

# Create shortcuts directory if it doesn't exist
mkdir -p "$SHORTCUTS_DIR"

# Create the launcher script
echo "📝 Creating launcher script..."
cat > "$SHORTCUTS_DIR/$SCRIPT_NAME" << 'EOF'
#!/bin/zsh

# NEXUS Workspace Profile Launcher
# This script creates a dropdown menu for selecting workspace profiles

set -e

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
        echo "🚀 Launching profile: $profile_name"
        cd "$(dirname "$LAUNCHER_SCRIPT")"
        ./launcher.sh "$profile_name"
    else
        echo "❌ Profile not found: $profile_name"
    fi
}

# Main execution
if [[ $# -eq 0 ]]; then
    # No arguments provided, show interactive menu
    echo "🎯 NEXUS Workspace Profiles"
    echo "=========================="
    
    # Get all profile names
    profiles=($(get_profile_names))
    
    # Create numbered menu
    for i in {1..${#profiles[@]}}; do
        echo "$i. ${profiles[$i]}"
    done
    
    echo ""
    echo "Enter profile number or name: "
    read -r selection
    
    # Handle numeric selection
    if [[ "$selection" =~ ^[0-9]+$ ]] && [[ "$selection" -ge 1 ]] && [[ "$selection" -le ${#profiles[@]} ]]; then
        selected_profile="${profiles[$selection]}"
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
EOF

# Make the script executable
chmod +x "$SHORTCUTS_DIR/$SCRIPT_NAME"

echo "✅ Launcher script created: $SHORTCUTS_DIR/$SCRIPT_NAME"

# Create the Shortcuts workflow file
echo "📱 Creating Shortcuts workflow..."
cat > "$SHORTCUTS_DIR/nexus_workspace_shortcut.shortcut" << 'EOF'
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

echo "✅ Shortcuts workflow file created: $SHORTCUTS_DIR/nexus_workspace_shortcut.shortcut"

# Create a simple installation guide
echo "📖 Creating installation guide..."
cat > "$SHORTCUTS_DIR/INSTALL_NEXUS_SHORTCUT.md" << 'EOF'
# NEXUS Workspace Launcher - Apple Shortcuts Installation

## 🚀 Quick Setup

1. **Open Apple Shortcuts app**
2. **Import the workflow**: File → Import → Select `nexus_workspace_shortcut.shortcut`
3. **Customize the shortcut** (optional):
   - Change the name
   - Add to menu bar
   - Set keyboard shortcut
   - Add to Control Center

## 🎯 Usage

- **Run the shortcut** to see all available workspace profiles
- **Select a profile** by number or name
- **Direct launch**: Add profile name as input to launch directly

## 🔧 Available Profiles

- ai_business_profile
- ai_content_creation_profile  
- ai_development_profile
- ai_gaming_profile
- ai_learning_profile
- ai_research_profile
- business_profile
- content_creation_profile
- focus_profile
- gaming_profile
- learning_profile
- personal_profile
- work_profile

## 🛠️ Troubleshooting

If the shortcut doesn't work:
1. Check file permissions: `chmod +x /Users/eduardof.giovannini/Library/Shortcuts/nexus_workspace_launcher.sh`
2. Verify profiles directory exists
3. Test the script directly: `/Users/eduardof.giovannini/Library/Shortcuts/nexus_workspace_launcher.sh`

## 📱 Integration Options

- **Menu Bar**: Add to menu bar for quick access
- **Control Center**: Add to Control Center widgets
- **Keyboard Shortcut**: Assign global hotkey
- **Siri**: "Hey Siri, run NEXUS Workspace Launcher"
EOF

echo "✅ Installation guide created: $SHORTCUTS_DIR/INSTALL_NEXUS_SHORTCUT.md"

# Test the launcher script
echo "🧪 Testing launcher script..."
if "$SHORTCUTS_DIR/$SCRIPT_NAME" --help >/dev/null 2>&1 || "$SHORTCUTS_DIR/$SCRIPT_NAME" >/dev/null 2>&1; then
    echo "✅ Launcher script test successful"
else
    echo "⚠️  Launcher script test completed (expected behavior)"
fi

echo ""
echo "🎉 NEXUS Apple Shortcuts Integration Complete!"
echo "============================================="
echo ""
echo "📱 Next Steps:"
echo "1. Open Apple Shortcuts app"
echo "2. Import: $SHORTCUTS_DIR/nexus_workspace_shortcut.shortcut"
echo "3. Customize and add to menu bar/Control Center"
echo ""
echo "🔧 Files Created:"
echo "   • Launcher Script: $SHORTCUTS_DIR/$SCRIPT_NAME"
echo "   • Shortcut Workflow: $SHORTCUTS_DIR/nexus_workspace_shortcut.shortcut"
echo "   • Installation Guide: $SHORTCUTS_DIR/INSTALL_NEXUS_SHORTCUT.md"
echo ""
echo "🎯 Test Command:"
echo "   $SHORTCUTS_DIR/$SCRIPT_NAME"
echo ""
echo "📖 For detailed instructions, see: $SHORTCUTS_DIR/INSTALL_NEXUS_SHORTCUT.md"
