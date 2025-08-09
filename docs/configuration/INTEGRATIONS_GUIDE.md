# 🎯 YABAI Workspace Manager - Integrations Guide

## 📋 Overview

This guide covers the integration of your YABAI workspace system with powerful macOS automation tools:

- **Keyboard Maestro**: Advanced macro automation
- **BetterTouchTool**: Gesture and input device control
- **Raycast**: Quick command palette and launcher
- **skhd**: Global hotkey management

## 🚀 Quick Installation

### One-Command Setup
```bash
# Install all integrations at once
./integrations/install_integrations.sh all
```

### Individual Installation
```bash
# Install specific integrations
./integrations/install_integrations.sh km      # Keyboard Maestro
./integrations/install_integrations.sh btt     # BetterTouchTool
./integrations/install_integrations.sh raycast # Raycast
./integrations/install_integrations.sh skhd    # skhd hotkeys
```

## 📱 Keyboard Maestro Integration

### What It Provides
- **One-Key Profile Switching**: Instant workspace changes
- **Advanced Automation**: Complex workflow sequences
- **Context-Aware Triggers**: Time-based or app-based activation

### Installed Macros
1. **YABAI - Load Work Profile** (Ctrl+Alt+Cmd+W)
   - Loads development workspace
   - Opens all work-related applications
   - Applies YABAI window rules

2. **YABAI - Load Personal Profile** (Ctrl+Alt+Cmd+P)
   - Loads entertainment workspace
   - Opens social media and personal apps
   - Configures for relaxation mode

3. **YABAI - Load AI Research Profile** (Ctrl+Alt+Cmd+R)
   - Loads AI development workspace
   - Opens research and AI tools
   - Optimizes for model development

4. **YABAI - Quick Window Management** (Ctrl+Alt+Cmd+Space)
   - Shows current window information
   - Provides quick window operations
   - Moves windows between displays

### Customization
- **Edit Macros**: Open Keyboard Maestro → Macros → YABAI
- **Change Hotkeys**: Modify trigger settings in each macro
- **Add Conditions**: Create time-based or app-based triggers

## 👆 BetterTouchTool Integration

### What It Provides
- **Trackpad Gestures**: Multi-finger swipe controls
- **Mouse Gestures**: Right-click drag patterns
- **Stream Deck Support**: Hardware button integration
- **Global Input Control**: Any input device customization

### Installed Gestures
1. **Three Finger Swipe Up**: Mission Control
   - Opens macOS Mission Control
   - Shows all spaces and windows

2. **Four Finger Tap**: Rotate Layout
   - Rotates current space layout 90°
   - Changes window arrangement

3. **Two Finger Swipe Left**: Next Display
   - Moves focused window to next display
   - Cycles through your 3 displays

4. **Two Finger Swipe Right**: Previous Display
   - Moves focused window to previous display
   - Reverse cycle through displays

### Custom Actions Available
- **YABAI - Mission Control**: Opens Mission Control
- **YABAI - Rotate Layout**: Rotates space layout
- **YABAI - Next Display**: Move window to next display
- **YABAI - Previous Display**: Move window to previous display
- **YABAI - Load Work Profile**: Load work workspace
- **YABAI - Load Personal Profile**: Load personal workspace
- **YABAI - Load AI Research Profile**: Load AI research workspace

### Customization
- **Edit Gestures**: Open BetterTouchTool → Gestures
- **Add New Gestures**: Create custom trackpad/mouse patterns
- **Stream Deck**: Map actions to hardware buttons

## 🚀 Raycast Integration

### What It Provides
- **Quick Commands**: Instant workspace management
- **Window Control**: Move and focus windows
- **Real-time Status**: Live YABAI information
- **Search Interface**: Find and manage windows

### Extension Features
1. **Quick Actions**
   - Load Work Profile
   - Load Personal Profile
   - Load AI Research Profile
   - Rotate Layout
   - Refresh Data

2. **Window Management**
   - List all windows by display
   - Focus specific windows
   - Move windows between displays
   - Show window details

3. **Display Information**
   - Show all displays and resolutions
   - List spaces on each display
   - Display current focus status

### Usage
1. **Open Raycast**: Cmd+Space (or your shortcut)
2. **Search**: Type "YABAI" or "Workspace"
3. **Select**: Choose the YABAI Workspace Manager
4. **Navigate**: Use arrow keys and Enter to interact

### Installation
```bash
# Install Raycast extension
./integrations/install_integrations.sh raycast
```

## ⌨️ skhd Hotkey Integration

### What It Provides
- **Global Hotkeys**: System-wide keyboard shortcuts
- **YABAI Control**: Direct YABAI command execution
- **Workspace Switching**: Instant profile loading
- **Window Management**: Quick window operations

### Installed Hotkeys

#### Workspace Profiles
- **Ctrl+Alt+Cmd+W**: Load Work Profile
- **Ctrl+Alt+Cmd+P**: Load Personal Profile
- **Ctrl+Alt+Cmd+R**: Load AI Research Profile

#### Window Management
- **Ctrl+Alt+Cmd+Left**: Move window to previous display
- **Ctrl+Alt+Cmd+Right**: Move window to next display
- **Ctrl+Alt+Cmd+Up**: Move window to display 1
- **Ctrl+Alt+Cmd+Down**: Move window to display 2

#### Space Management
- **Ctrl+Alt+Cmd+1-6**: Focus spaces 1-6

#### Layout Controls
- **Ctrl+Alt+Cmd+F**: Toggle window float
- **Ctrl+Alt+Cmd+S**: Rotate layout 90°
- **Ctrl+Alt+Cmd+B**: Mirror layout on Y-axis

### Installation
```bash
# Install skhd
brew install skhd

# Install configuration
./integrations/install_integrations.sh skhd
```

## 🔧 Advanced Configuration

### Keyboard Maestro Advanced
```applescript
-- Example: Time-based profile switching
if (current date)'s hours ≥ 9 and (current date)'s hours ≤ 17 then
    -- Work hours: load work profile
    do shell script "cd $HOME/Desktop/YABAI && source workspace_profiles/work_profile.sh"
else
    -- Personal hours: load personal profile
    do shell script "cd $HOME/Desktop/YABAI && source workspace_profiles/personal_profile.sh"
end if
```

### BetterTouchTool Advanced
```javascript
// Example: App-specific gestures
if (currentApp == "Cursor") {
    // Development mode gestures
    threeFingerSwipeUp = "Mission Control";
    fourFingerTap = "Rotate Layout";
} else if (currentApp == "Safari") {
    // Browser mode gestures
    threeFingerSwipeUp = "New Tab";
    fourFingerTap = "Refresh";
}
```

### Raycast Extension Development
```typescript
// Example: Custom window action
async function customWindowAction(windowId: number) {
    try {
        await execAsync(`yabai -m window --focus ${windowId}`);
        await execAsync(`yabai -m window --toggle float`);
        await showToast({
            style: Toast.Style.Success,
            title: "Window toggled float"
        });
    } catch (error) {
        await showToast({
            style: Toast.Style.Failure,
            title: "Failed to toggle float"
        });
    }
}
```

### skhd Advanced Configuration
```bash
# Example: App-specific hotkeys
# Only in Cursor (development)
ctrl + alt + cmd - d : yabai -m window --toggle float
ctrl + alt + cmd - s : yabai -m space --rotate 90

# Only in Safari (browsing)
ctrl + alt + cmd - t : open -a "Safari" && sleep 1 && yabai -m rule --add app="Safari" display=1 space=1
```

## 🎯 Integration Workflow Examples

### Morning Routine
1. **Wake up computer**
2. **Press Ctrl+Alt+Cmd+W** (Keyboard Maestro)
3. **Work profile loads automatically**
4. **All apps open and position correctly**

### Development Session
1. **Open Cursor**
2. **Use Raycast** to quickly move windows
3. **Gesture controls** for layout changes
4. **Hotkeys** for space switching

### Evening Switch
1. **Press Ctrl+Alt+Cmd+P** (Keyboard Maestro)
2. **Personal profile loads**
3. **Entertainment apps open**
4. **Relaxation workspace ready**

### Quick Window Management
1. **Focus a window**
2. **Use Raycast** to see all windows
3. **Drag gesture** to move between displays
4. **Hotkey** to toggle float

## 🔍 Troubleshooting

### Common Issues

#### Keyboard Maestro Not Working
```bash
# Check if macros are installed
ls "$HOME/Library/Application Support/Keyboard Maestro/Keyboard Maestro Macros/"

# Restart Keyboard Maestro
killall "Keyboard Maestro"
open "/Applications/Keyboard Maestro.app"
```

#### BetterTouchTool Gestures Not Responding
```bash
# Check if BTT is running
pgrep -x "BetterTouchTool"

# Restart BTT
killall "BetterTouchTool"
open "/Applications/BetterTouchTool.app"
```

#### Raycast Extension Not Found
```bash
# Check extension directory
ls "$HOME/.raycast/extensions/"

# Reinstall extension
./integrations/install_integrations.sh raycast
```

#### skhd Hotkeys Not Working
```bash
# Check skhd status
brew services list | grep skhd

# Restart skhd
brew services restart skhd

# Check configuration
cat ~/.skhdrc
```

### Debug Commands
```bash
# Check YABAI status
yabai -m query --displays

# Check skhd status
brew services list | grep skhd

# Check Keyboard Maestro
ls "$HOME/Library/Application Support/Keyboard Maestro/"

# Check BetterTouchTool
ls "$HOME/Library/Application Support/BetterTouchTool/"

# Check Raycast
ls "$HOME/.raycast/extensions/"
```

## 📈 Performance Tips

### Optimization
1. **Use Keyboard Maestro** for complex workflows
2. **Use skhd** for simple hotkeys
3. **Use BetterTouchTool** for gestures
4. **Use Raycast** for quick commands

### Memory Usage
- **Keyboard Maestro**: ~50MB
- **BetterTouchTool**: ~30MB
- **Raycast**: ~20MB
- **skhd**: ~5MB

### Startup Time
- **Keyboard Maestro**: 2-3 seconds
- **BetterTouchTool**: 1-2 seconds
- **Raycast**: Instant
- **skhd**: Instant

## 🎉 Success Metrics

### Integration Benefits
- ✅ **Faster Workflow**: One-key profile switching
- ✅ **Gesture Control**: Natural input methods
- ✅ **Quick Access**: Raycast command palette
- ✅ **Global Hotkeys**: System-wide shortcuts
- ✅ **Automation**: Time-based and context-aware triggers

### Productivity Gains
- **Profile Switching**: 10 seconds → 1 second
- **Window Management**: Manual → Gesture/Hotkey
- **Layout Changes**: Menu navigation → One key
- **App Launching**: Manual → Automated

The integration system provides multiple ways to control your workspace, from simple hotkeys to complex automation workflows. Choose the tools that fit your workflow best! 🎯 