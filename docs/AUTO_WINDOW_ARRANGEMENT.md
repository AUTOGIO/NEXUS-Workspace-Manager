# 🎯 Auto Window Arrangement for YABAI

This document explains how to use the automatic window arrangement system that automatically arranges windows when 3 or more are on the same display, while keeping Terminal, Finder, and iTerm floating.

## 🚀 Quick Start

### 1. Launch the Auto Arranger

```bash
# From the YABAI project directory
./scripts/launch_auto_arranger.sh
```

### 2. Test the System

```bash
# Run the test suite to verify everything is working
./scripts/test_auto_arrangement.sh
```

## 📋 What This System Does

### ✨ Automatic Features

- **Auto-balance**: Windows automatically arrange when created, moved, or resized
- **Smart counting**: Only counts managed windows (floating apps don't count toward the 3+ threshold)
- **BSP layout**: Uses binary space partitioning for optimal window arrangement
- **Multi-display support**: Works across all connected displays

### 🪟 Floating Windows

The following applications are set to always float (unmanaged):

- **Terminal** - macOS Terminal app
- **Finder** - File manager
- **iTerm2** - Terminal emulator
- **System Settings** - System preferences
- **Activity Monitor** - System monitoring
- **Calculator** - Built-in calculator
- **Calendar** - Calendar app
- **Contacts** - Address book
- **Preview** - Document viewer
- **Quick Look** - File preview

## 🔧 Configuration Files

### Main YABAI Config (`~/.yabairc`)

The main configuration file has been updated with:

- `auto_balance = on` - Enables automatic balancing
- Floating window rules for Terminal, Finder, and iTerm
- Auto-arrangement signals for window events

### Auto Arranger Script (`scripts/auto_window_arranger.sh`)

Advanced script that provides:

- Configurable floating app list
- Window counting logic
- Display-specific arrangement
- Event handling functions

### Launcher Script (`scripts/launch_auto_arranger.sh`)

Easy-to-use launcher that:

- Checks prerequisites (YABAI, jq)
- Sets up floating windows
- Configures auto-arrangement signals
- Runs initial arrangement
- Shows system status

## 📱 Usage Commands

### Basic Commands

```bash
# Start the auto arranger
./scripts/launch_auto_arranger.sh

# Check system status
./scripts/launch_auto_arranger.sh status

# Run manual arrangement
./scripts/launch_auto_arranger.sh arrange

# Setup floating windows only
./scripts/launch_auto_arranger.sh setup
```

### Manual YABAI Commands

```bash
# Balance current space
yabai -m space --balance

# View active rules
yabai -m rule --list

# View active signals
yabai -m signal --list

# View configuration
yabai -m config

# View displays
yabai -m query --displays

# View windows on current display
yabai -m query --windows --display
```

## 🧪 Testing

### Run the Test Suite

```bash
./scripts/test_auto_arrangement.sh
```

The test suite checks:

1. **Floating Rules**: Verifies Terminal, Finder, and iTerm are floating
2. **Auto Balance**: Confirms auto_balance is enabled
3. **Signals**: Checks auto-arrangement signals are active
4. **Window Counting**: Tests display and window detection
5. **Manual Arrangement**: Verifies manual balance works

### Manual Testing

1. **Open multiple apps** (e.g., Safari, Cursor, Vivaldi)
2. **Watch automatic arrangement** when the 3rd window opens
3. **Move windows** between displays to trigger re-arrangement
4. **Verify Terminal/Finder/iTerm** remain floating

## ⚙️ Customization

### Add More Floating Apps

Edit `scripts/launch_auto_arranger.sh` and add to the `floating_apps` array:

```bash
local floating_apps=(
    "Terminal"
    "Finder"
    "iTerm2"
    "iTerm"
    "Your App Here"  # Add your app
)
```

### Change Arrangement Threshold

Edit `scripts/auto_window_arranger.sh` and modify:

```bash
MIN_WINDOWS_FOR_ARRANGEMENT=4  # Change from 3 to 4
```

### Modify Layout Behavior

Edit `~/.yabairc` and change:

```bash
yabai -m config layout float  # Change from bsp to float
```

## 🔍 Troubleshooting

### Common Issues

#### YABAI Not Running
```bash
# Start YABAI service
brew services start yabai

# Check status
brew services list | grep yabai
```

#### jq Not Installed
```bash
# Install jq
brew install jq
```

#### Rules Not Applied
```bash
# Restart YABAI
yabai --restart-service

# Reload scripting addition
sudo yabai --load-sa
```

#### Windows Not Arranging
```bash
# Check auto_balance setting
yabai -m config | grep auto_balance

# Check active signals
yabai -m signal --list

# Run manual arrangement
yabai -m space --balance
```

### Debug Mode

```bash
# Enable YABAI debug logging
yabai -m config debug_output on

# Check logs
tail -f /tmp/yabai_$(whoami).out
```

## 📚 Advanced Features

### Event-Driven Arrangement

The system uses YABAI signals to automatically trigger arrangement:

- `window_created` → Arrange after 0.5s delay
- `window_moved` → Arrange after 0.3s delay  
- `window_resized` → Arrange after 0.3s delay

### Smart Window Counting

Only managed windows count toward the arrangement threshold:

```bash
# Example: 5 total windows, 2 floating = 3 managed
# This triggers automatic arrangement
```

### Multi-Display Support

Each display is managed independently:

- Display 1: 2 windows → No arrangement
- Display 2: 4 windows → Automatic arrangement
- Display 3: 1 window → No arrangement

## 🔄 Integration with Existing Setup

### Compatible With

- Your existing `yabairc_additions.sh` rules
- Multi-display configurations
- SKHD shortcuts
- BetterTouchTool presets
- Keyboard Maestro macros

### How It Works

1. **Main yabairc** sets basic config and floating rules
2. **Auto arranger** provides advanced logic and signals
3. **Existing rules** continue to work as before
4. **New system** adds automatic arrangement on top

## 📈 Performance Considerations

### Lightweight Operation

- Signals only trigger when needed
- Window counting is efficient
- No continuous polling
- Minimal CPU impact

### Memory Usage

- Scripts load once and stay in memory
- No persistent background processes
- Clean signal-based architecture

## 🎉 Benefits

### For Users

- **Automatic**: No manual window management needed
- **Smart**: Only arranges when beneficial (3+ windows)
- **Flexible**: Floating apps remain where you want them
- **Fast**: Instant arrangement when needed

### For Developers

- **Configurable**: Easy to modify and extend
- **Testable**: Comprehensive test suite included
- **Maintainable**: Clean, documented code
- **Integratable**: Works with existing YABAI setups

## 🔗 Related Documentation

- [YABAI Installation Guide](installation/INSTALLATION.md)
- [SKHD Configuration](configs/skhd/skhdrc)
- [Integration Guide](configuration/INTEGRATIONS_GUIDE.md)
- [Quick Start Guide](QUICK_START_GUIDE.md)

## 📞 Support

If you encounter issues:

1. **Run the test suite**: `./scripts/test_auto_arrangement.sh`
2. **Check YABAI status**: `yabai -m config`
3. **Review logs**: Check `/tmp/yabai_$(whoami).out`
4. **Restart services**: `yabai --restart-service`

---

**Happy window managing! 🪟✨**
