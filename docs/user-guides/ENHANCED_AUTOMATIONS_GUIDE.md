# 🚀 NEXUS Enhanced Automations Guide

> **AI-Powered Workspace Intelligence for Apple Silicon**

## 📋 Table of Contents

1. [Overview](#overview)
2. [Installation](#installation)
3. [BetterTouchTool Gestures](#bettertouchtool-gestures)
4. [Keyboard Maestro Macros](#keyboard-maestro-macros)
5. [Apple Shortcuts](#apple-shortcuts)
6. [Shell Script Shortcuts](#shell-script-shortcuts)
7. [AI-Powered Features](#ai-powered-features)
8. [Quick Access Menu](#quick-access-menu)
9. [Troubleshooting](#troubleshooting)
10. [Customization](#customization)

## 🎯 Overview

NEXUS Enhanced Automations transforms your workspace into an intelligent, gesture-controlled environment that responds to your needs in real-time. This system combines:

- **15 Enhanced BetterTouchTool Gestures** for intuitive control
- **18 Keyboard Maestro Macros** for keyboard-based automation
- **16 Apple Shortcuts** for native macOS integration
- **8 Shell Script Shortcuts** for command-line access
- **AI-Powered Workspace Optimization** for intelligent layout management
- **Context-Aware Profile Selection** for automatic workspace adaptation

## 🚀 Installation

### Prerequisites

- macOS 12.0+ (Sequoia/Tahoe recommended)
- Apple Silicon Mac (M1/M2/M3) for optimal performance
- YABAI and SKHD installed and running
- Python 3.11+ with required dependencies

### Quick Installation

```bash
# Navigate to your NEXUS project
cd ~/Library/Mobile\ Documents/com~apple~CloudDocs/Obsidian/Projects/FINALIZADO/YABAI

# Make the installer executable
chmod +x scripts/setup/install_enhanced_automations.sh

# Run the installer
./scripts/setup/install_enhanced_automations.sh
```

### Manual Installation

If you prefer to install components individually:

```bash
# Install Python dependencies
uv pip install psutil pyyaml

# Make the enhanced bridge executable
chmod +x tools/ai/nexus_enhanced_bridge.py

# Create shortcuts directory
mkdir -p ~/bin

# Add to PATH
echo 'export PATH="$HOME/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc
```

## 🎨 BetterTouchTool Gestures

### Gesture Categories

#### 🎯 Workspace Management
- **3-finger swipe up + hold**: NEXUS Profile Switcher
- **4-finger pinch in**: Deep Focus Mode Toggle
- **5-finger tap**: Sunrise Setup (morning hours)

#### 🧠 AI Integration
- **3-finger swipe down + hold**: Intelligent Layout
- **4-finger swipe up + hold**: Neural Optimization
- **3-finger swipe left + hold**: Creative Flow

#### 👁️ Window Management
- **2-finger swipe up**: Smart Focus North
- **2-finger swipe down**: Smart Focus South
- **2-finger swipe left**: Smart Focus West
- **2-finger swipe right**: Smart Focus East
- **3-finger pinch in**: Window Float Toggle

#### 📱 Space Management
- **3-finger swipe up (quick)**: Next Space
- **3-finger swipe down (quick)**: Previous Space

#### 🛠️ System Management
- **4-finger swipe down + hold**: NEXUS Doctor

### Setting Up BetterTouchTool

1. **Install BetterTouchTool** from [folivora.ai](https://folivora.ai/)
2. **Import the preset**:
   - Open BetterTouchTool
   - Go to Gestures > Import
   - Select: `configs/integrations/nexus_enhanced_gestures.bttpreset`
3. **Customize gestures** as needed
4. **Test gestures** to ensure they work properly

### Customizing Gestures

You can customize gestures in BetterTouchTool:

1. **Change triggers**: Modify gesture recognition
2. **Adjust sensitivity**: Fine-tune gesture detection
3. **Add visual feedback**: Customize appearance
4. **Set time restrictions**: Limit when gestures work

## ⌨️ Keyboard Maestro Macros

### Macro Categories

#### 🤖 AI Integration
- **Cmd+Shift+AI**: AI Research Mode
- **Cmd+Shift+P**: AI Performance Mode
- **Cmd+Shift+Q**: Quick AI Inference
- **Cmd+Shift+C**: Context-Aware Profile

#### 🖥️ Window Management
- **Cmd+Shift+Arrow**: Multi-Display Window Flow
- **Cmd+Shift+Tab**: Quick Profile Cycle

#### 🎯 Productivity
- **Cmd+Shift+M**: Meeting Mode
- **Cmd+Shift+G**: Gaming Mode
- **Cmd+Shift+L**: Learning Mode
- **Cmd+Shift+PER**: Personal Mode

#### 🔧 AI Development
- **Cmd+Shift+DEV**: AI Development Mode
- **Cmd+Shift+CRE**: AI Content Creation
- **Cmd+Shift+BUS**: AI Business Mode
- **Cmd+Shift+AGM**: AI Gaming Mode
- **Cmd+Shift+ALM**: AI Learning Mode

#### ⚙️ System Management
- **Cmd+Shift+H**: System Health Monitor
- **Cmd+Shift+B**: Workspace Snapshot
- **Cmd+Shift+Esc**: Emergency Reset

### Setting Up Keyboard Maestro

1. **Install Keyboard Maestro** from [keyboardmaestro.com](https://www.keyboardmaestro.com/)
2. **Import the macros**:
   - Open Keyboard Maestro
   - Go to File > Import
   - Select: `configs/integrations/nexus_enhanced_macros.kmmacros`
3. **Customize hotkeys** as needed
4. **Test macros** to ensure they work properly

### Customizing Macros

You can customize macros in Keyboard Maestro:

1. **Change hotkeys**: Modify keyboard shortcuts
2. **Adjust timing**: Set delays and timeouts
3. **Add conditions**: Set when macros trigger
4. **Modify actions**: Change what macros do

## 📱 Apple Shortcuts

### Shortcut Categories

#### 🎨 Workspace Management
- **NEXUS Master Control**: Master control center
- **Smart Profile Launcher**: AI-powered profile selection

#### 🧠 AI Integration
- **Neural Workspace Optimization**: AI-powered optimization
- **Context-Aware Assistant**: AI-powered context awareness
- **Auto-Scheduler**: Intelligent scheduling

#### 🖥️ Window Management
- **Multi-Display Manager**: Advanced display management
- **Performance Dashboard**: Real-time monitoring

#### 🎯 Productivity
- **Creative Mode**: Optimized for creative work
- **Development Mode**: Optimized for development
- **Learning Mode**: Optimized for learning
- **Gaming Mode**: Optimized for gaming
- **Personal Mode**: Optimized for personal use
- **Business Mode**: Optimized for business
- **Focus Mode**: Distraction-free workspace

#### 🛡️ System Management
- **Security & Privacy**: Security management
- **Emergency Actions**: Emergency recovery

### Setting Up Apple Shortcuts

1. **Open Apple Shortcuts** app
2. **Create new shortcuts** based on the descriptions
3. **Add "Run Shell Script" actions** with appropriate commands
4. **Test shortcuts** to ensure they work properly

### Example Shortcut Setup

For the "AI Research Mode" shortcut:

1. Create new shortcut
2. Add "Run Shell Script" action
3. Set script to: `cd ~/Library/Mobile\ Documents/com~apple~CloudDocs/Obsidian/Projects/FINALIZADO/YABAI && ./scripts/setup/launcher.sh ai_research_profile`
4. Save and test

## 🖥️ Shell Script Shortcuts

### Available Commands

```bash
# Workspace Management
nexus-profile-switcher          # Profile switcher
nexus-ai-optimize              # AI layout optimization
nexus-workspace-analyze        # Workspace analysis

# System Management
nexus-create-snapshot          # Create workspace snapshot
nexus-context-profile          # Context-aware profile
nexus-auto-schedule            # Auto-schedule workspace
nexus-smart-focus              # Smart profile selection
nexus-emergency-reset          # Emergency system reset
```

### Using Shell Shortcuts

```bash
# Quick profile switching
nexus-profile-switcher work_profile

# AI-powered optimization
nexus-ai-optimize

# Workspace analysis
nexus-workspace-analyze

# Create snapshot
nexus-create-snapshot

# Emergency reset
nexus-emergency-reset
```

## 🧠 AI-Powered Features

### Intelligent Layout Optimization

The AI system analyzes your current workspace and suggests optimizations:

```bash
# Run AI optimization
nexus-ai-optimize

# Or use the enhanced bridge directly
python tools/ai/nexus_enhanced_bridge.py --optimize-layout
```

**What it does:**
- Analyzes active applications
- Determines user activity type
- Suggests optimal workspace layout
- Automatically applies recommendations

### Context-Aware Profile Selection

AI automatically selects the best workspace profile:

```bash
# Get AI recommendation
nexus-context-profile

# Or use the enhanced bridge directly
python tools/ai/nexus_enhanced_bridge.py --context-aware-profile
```

**Context factors:**
- Time of day
- Active applications
- System load
- Memory usage
- User activity patterns

### Workspace Analysis

Get detailed insights about your workspace:

```bash
# Analyze workspace
nexus-workspace-analyze

# Or use the enhanced bridge directly
python tools/ai/nexus_enhanced_bridge.py --analyze-workspace
```

**Analysis includes:**
- Current workspace context
- AI recommendations
- System health metrics
- Optimization suggestions

### Auto-Scheduling

Automatically schedule workspace changes:

```bash
# Run auto-schedule
nexus-auto-schedule

# Or use the enhanced bridge directly
python tools/ai/nexus_enhanced_bridge.py --auto-schedule
```

**Schedule rules:**
- **Morning (6-9 AM)**: Work profile
- **Lunch (12-1 PM)**: Personal profile
- **Afternoon (1-5 PM)**: Work profile
- **Evening (6-10 PM)**: Gaming profile
- **Night (10 PM-6 AM)**: Focus profile

## 🎮 Quick Access Menu

### Launching the Menu

```bash
# Launch the quick access menu
nexus-quick-menu
```

### Menu Options

#### 🎯 Workspace Profiles (1-13)
- Quick access to all workspace profiles
- AI-powered profile selection
- Context-aware recommendations

#### 🤖 AI Integration (14)
- Smart profile selection
- AI-powered workspace optimization

#### 🖥️ YABAI Management (15-18)
- Layout optimization
- Workspace analysis
- Snapshot creation
- Context analysis

#### ⚙️ System Management (19-22)
- Performance dashboard
- Emergency reset
- Auto-scheduling
- System status

#### 📚 Utilities (23-25)
- Launch dashboard
- Show help
- Exit menu

## 🔧 Troubleshooting

### Common Issues

#### Gestures Not Working
1. **Check BetterTouchTool**: Ensure it's running and enabled
2. **Verify permissions**: Grant accessibility permissions
3. **Check gesture settings**: Ensure gestures are properly configured
4. **Restart BetterTouchTool**: Sometimes a restart helps

#### Macros Not Working
1. **Check Keyboard Maestro**: Ensure it's running and enabled
2. **Verify hotkeys**: Check for conflicts with other apps
3. **Check permissions**: Grant accessibility permissions
4. **Test in Keyboard Maestro**: Use the built-in testing

#### Shortcuts Not Working
1. **Check Apple Shortcuts**: Ensure shortcuts are properly created
2. **Verify shell script paths**: Check that paths are correct
3. **Test manually**: Run commands manually to verify
4. **Check permissions**: Ensure Terminal has necessary permissions

#### AI Features Not Working
1. **Check Python**: Ensure Python 3.11+ is installed
2. **Check dependencies**: Install required packages
3. **Check paths**: Verify file paths are correct
4. **Check logs**: Review log files for errors

### Debugging Commands

```bash
# Check system status
./scripts/setup/launcher.sh status

# Test enhanced bridge
python tools/ai/nexus_enhanced_bridge.py --help

# Check logs
tail -f logs/automation_install.log

# Test shortcuts
which nexus-quick-menu
```

### Getting Help

1. **Check logs**: Review log files in `logs/` directory
2. **Test components**: Test individual components separately
3. **Review documentation**: Check this guide and other docs
4. **Check system requirements**: Ensure all prerequisites are met

## 🎨 Customization

### Customizing Gestures

You can customize BetterTouchTool gestures:

1. **Modify triggers**: Change gesture recognition
2. **Adjust actions**: Modify what gestures do
3. **Add conditions**: Set when gestures work
4. **Customize appearance**: Modify visual feedback

### Customizing Macros

You can customize Keyboard Maestro macros:

1. **Change hotkeys**: Modify keyboard shortcuts
2. **Adjust timing**: Set delays and timeouts
3. **Add conditions**: Set when macros trigger
4. **Modify actions**: Change what macros do

### Customizing Shortcuts

You can customize Apple Shortcuts:

1. **Modify actions**: Change what shortcuts do
2. **Add conditions**: Set when shortcuts trigger
3. **Customize appearance**: Modify icons and names
4. **Add to widgets**: Create Control Center widgets

### Advanced Customization

For advanced users:

1. **Modify the enhanced bridge**: Edit `tools/ai/nexus_enhanced_bridge.py`
2. **Create custom profiles**: Add new workspace profiles
3. **Extend AI features**: Add new AI capabilities
4. **Create custom integrations**: Add new automation tools

## 🚀 Next Steps

### Immediate Actions

1. **Test the system**: Use `nexus-quick-menu` to explore features
2. **Import integrations**: Set up BetterTouchTool and Keyboard Maestro
3. **Create shortcuts**: Build Apple Shortcuts for your workflow
4. **Customize settings**: Adjust to your preferences

### Advanced Usage

1. **Create custom profiles**: Build specialized workspace profiles
2. **Extend AI features**: Add new AI capabilities
3. **Integrate with other tools**: Connect with your existing workflow
4. **Share configurations**: Share your setup with others

### Continuous Improvement

1. **Monitor performance**: Use the performance dashboard
2. **Analyze usage**: Review workspace analysis reports
3. **Optimize workflows**: Refine your automation setup
4. **Stay updated**: Keep up with NEXUS updates

---

## 📚 Additional Resources

- **User Guide**: `docs/user-guides/USER_GUIDE.md`
- **Interactive Guide**: `dashboard/interactive_guide.py`
- **Project Structure**: `docs/developer-guides/PROJECT_STRUCTURE.md`
- **Installation Guide**: `docs/installation/INSTALLATION.md`

## 🆘 Support

If you need help:

1. **Check the logs**: Review log files for errors
2. **Review documentation**: Check this guide and other docs
3. **Test components**: Test individual components separately
4. **Check system requirements**: Ensure all prerequisites are met

---

**🎉 Congratulations! You now have a fully enhanced NEXUS system with AI-powered automation!**

Your workspace is now intelligent, responsive, and ready to adapt to your needs in real-time. Enjoy the enhanced productivity and seamless workflow management! 🚀✨
