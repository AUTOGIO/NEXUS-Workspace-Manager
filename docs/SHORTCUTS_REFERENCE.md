# 🎯 NEXUS Workspace Manager - Complete Shortcuts Reference

> **All Keyboard Shortcuts and Gesture Controls for YABAI Workspace Management**

## ⌨️ **Keyboard Shortcuts (skhd)**

### **Workspace Profile Management**
| Shortcut | Action | Description |
|-----------|---------|-------------|
| `Ctrl + Alt + Cmd + W` | Load Work Profile | Development & productivity workspace |
| `Ctrl + Alt + Cmd + P` | Load Personal Profile | Entertainment & social workspace |
| `Ctrl + Alt + Cmd + R` | Load AI Research Profile | AI & ML development workspace |
| `Ctrl + Alt + Cmd + F` | Load Focus Profile | Distraction-free work environment |
| `Ctrl + Alt + Cmd + B` | Load Business Profile | Professional & business tools |
| `Ctrl + Alt + Cmd + L` | Load Learning Profile | Educational & study environment |
| `Ctrl + Alt + Cmd + G` | Load Gaming Profile | Gaming & entertainment setup |
| `Ctrl + Alt + Cmd + C` | Load Content Creation Profile | Creative work & media tools |

### **Window Management**
| Shortcut | Action | Description |
|-----------|---------|-------------|
| `Ctrl + Alt + Cmd + ←` | Move Window Left | Move active window to left display |
| `Ctrl + Alt + Cmd + →` | Move Window Right | Move active window to right display |
| `Ctrl + Alt + Cmd + ↑` | Move Window Up | Move active window to top display |
| `Ctrl + Alt + Cmd + ↓` | Move Window Down | Move active window to bottom display |
| `Ctrl + Alt + Cmd + F` | Toggle Float | Toggle window floating mode |
| `Ctrl + Alt + Cmd + S` | Toggle Sticky | Toggle window sticky mode |
| `Ctrl + Alt + Cmd + T` | Toggle Topmost | Toggle window always on top |
| `Ctrl + Alt + Cmd + B` | Toggle Border | Toggle window border display |

### **Space Navigation**
| Shortcut | Action | Description |
|-----------|---------|-------------|
| `Ctrl + Alt + Cmd + 1` | Focus Space 1 | Switch to workspace 1 |
| `Ctrl + Alt + Cmd + 2` | Focus Space 2 | Switch to workspace 2 |
| `Ctrl + Alt + Cmd + 3` | Focus Space 3 | Switch to workspace 3 |
| `Ctrl + Alt + Cmd + 4` | Focus Space 4 | Switch to workspace 4 |
| `Ctrl + Alt + Cmd + 5` | Focus Space 5 | Switch to workspace 5 |
| `Ctrl + Alt + Cmd + 6` | Focus Space 6 | Switch to workspace 6 |
| `Ctrl + Alt + Cmd + 7` | Focus Space 7 | Switch to workspace 7 |
| `Ctrl + Alt + Cmd + 8` | Focus Space 8 | Switch to workspace 8 |
| `Ctrl + Alt + Cmd + 9` | Focus Space 9 | Switch to workspace 9 |
| `Ctrl + Alt + Cmd + 0` | Focus Space 10 | Switch to workspace 10 |
| `Ctrl + Alt + Cmd + ←` | Previous Space | Switch to previous workspace |
| `Ctrl + Alt + Cmd + →` | Next Space | Switch to next workspace |

### **Layout Management**
| Shortcut | Action | Description |
|-----------|---------|-------------|
| `Ctrl + Alt + Cmd + R` | Rotate Layout | Rotate current layout 90° |
| `Ctrl + Alt + Cmd + M` | Mirror Y-Axis | Mirror layout vertically |
| `Ctrl + Alt + Cmd + X` | Mirror X-Axis | Mirror layout horizontally |

### **Window Focus & Movement**
| Shortcut | Action | Description |
|-----------|---------|-------------|
| `Ctrl + Alt + Cmd + H` | Focus West | Focus window to the left |
| `Ctrl + Alt + Cmd + J` | Focus South | Focus window below |
| `Ctrl + Alt + Cmd + K` | Focus North | Focus window above |
| `Ctrl + Alt + Cmd + L` | Focus East | Focus window to the right |

### **Window Swapping**
| Shortcut | Action | Description |
|-----------|---------|-------------|
| `Ctrl + Alt + Shift + H` | Swap West | Swap with window to the left |
| `Ctrl + Alt + Shift + J` | Swap South | Swap with window below |
| `Ctrl + Alt + Shift + K` | Swap North | Swap with window above |
| `Ctrl + Alt + Shift + L` | Swap East | Swap with window to the right |

## 👆 **Gesture Controls (BetterTouchTool)**

### **Trackpad Gestures**
| Gesture | Action | Description |
|---------|---------|-------------|
| **Three Finger Swipe Up** | Mission Control | Show all spaces and windows |
| **Four Finger Tap** | Rotate Layout | Rotate current workspace layout |
| **Two Finger Swipe Left** | Next Display | Move focus to next display |
| **Two Finger Swipe Right** | Previous Display | Move focus to previous display |

### **Magic Mouse Gestures**
| Gesture | Action | Description |
|---------|---------|-------------|
| **Two Finger Swipe Left** | Next Display | Navigate to next display |
| **Two Finger Swipe Right** | Previous Display | Navigate to previous display |

## 🚀 **Quick Access Commands**

### **Terminal Commands**
```bash
# Check YABAI status
yabai --version

# Check skhd status
ps aux | grep skhd

# Restart skhd
skhd --start-service

# Check integration status
./configs/integrations/install_integrations.sh status
```

### **Profile Loading Commands**
```bash
# Load specific profiles manually
source configs/profiles/work_profile.sh
source configs/profiles/personal_profile.sh
source configs/profiles/ai_research_profile.sh
```

## 🔧 **Configuration Files**

### **skhd Configuration**
- **Location**: `~/.skhdrc`
- **Auto-reload**: Yes (watches for changes)
- **Hotkeys**: 88+ configured shortcuts

### **BetterTouchTool Configuration**
- **Location**: `~/Library/Application Support/BetterTouchTool/`
- **Preset**: `yabai-workspace-manager.bttpreset`
- **Auto-load**: Yes (on startup)

### **YABAI Configuration**
- **Location**: `~/.yabairc`
- **Additions**: `yabairc_additions.sh`
- **Auto-reload**: Yes (on configuration change)

## 📱 **Integration Status**

| Component | Status | Description |
|-----------|--------|-------------|
| **YABAI** | ✅ Running | Window management active |
| **skhd** | ✅ Running | Keyboard shortcuts active |
| **BetterTouchTool** | ✅ Installed | Gesture controls active |
| **Keyboard Maestro** | ✅ Installed | Macro automation ready |
| **Raycast** | ✅ Installed | Quick access available |

## 🎯 **Usage Tips**

### **Getting Started**
1. **Learn Basic Shortcuts**: Start with `Ctrl + Alt + Cmd + W/P/R` for profile switching
2. **Practice Gestures**: Use trackpad gestures for natural navigation
3. **Customize Layouts**: Experiment with different workspace arrangements

### **Advanced Usage**
1. **Profile Combinations**: Mix and match profiles for different workflows
2. **Display Management**: Use arrow keys to move windows between displays
3. **Layout Rotation**: Rotate layouts to match your physical workspace

### **Troubleshooting**
1. **Shortcuts Not Working**: Check if skhd is running (`ps aux | grep skhd`)
2. **Gestures Not Responding**: Verify BetterTouchTool is active
3. **Profiles Not Loading**: Check file paths in skhd configuration

## 🔄 **Updates & Maintenance**

### **Regular Maintenance**
- **Weekly**: Check integration status
- **Monthly**: Review and update shortcuts
- **Quarterly**: Backup configurations

### **Version Compatibility**
- **macOS**: 12.0 (Monterey) or later
- **YABAI**: Latest stable version
- **skhd**: 0.3.9 or later
- **BetterTouchTool**: 3.0 or later

---

*Last Updated: August 10, 2025*  
*NEXUS Workspace Manager v3.0*
