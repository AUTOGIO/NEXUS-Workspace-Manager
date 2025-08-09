# 🔄 Dynamic Layout Manager for YABAI + N8N Workflows v2

A sophisticated tool swapping system that allows you to change one tool/display for another based on your configuration, integrating seamlessly with your YABAI setup and N8N Workflows v2 platform.

## 🎯 Overview

The Dynamic Layout Manager provides intelligent tool swapping across your 3-display setup:
- **Left Display** (HZ30GAMER 30"): Browsers & Web Tools
- **Center Display** (LG ULTRAWIDE 34"): AI & Development Tools  
- **Right Display** (iMac 24"): Productivity & Communication

## 🚀 Quick Start

### 1. Install Dependencies
```bash
./launch_dynamic_layout.sh install
```

### 2. Launch Dashboard
```bash
./launch_dynamic_layout.sh dashboard
```

### 3. Quick Tool Swap
```bash
./launch_dynamic_layout.sh swap left web_browser
./launch_dynamic_layout.sh swap center code_editor
./launch_dynamic_layout.sh swap right productivity
```

### 4. Switch Profiles
```bash
./launch_dynamic_layout.sh profile work
./launch_dynamic_layout.sh profile personal
./launch_dynamic_layout.sh profile ai_research
```

## 🛠️ Available Tools

### **Development Tools**
- **Code Editor**: VS Code, Xcode, PyCharm, IntelliJ IDEA
- **Terminal**: Terminal, iTerm2, Alacritty

### **AI Tools**
- **AI Chat**: ChatGPT, Grok, Claude, Perplexity
- **AI Development**: Ollama, LM Studio, MLX, Jupyter Notebook

### **Productivity Tools**
- **Productivity**: Notion, Obsidian, Calendar, Reminders
- **Communication**: WhatsApp, Slack, Teams, X, Telegram

### **Web Tools**
- **Web Browser**: Safari, Chrome, Firefox, Vivaldi

### **N8N Workflows v2 Tools**
- **N8N Dashboard**: Streamlit dashboard, N8N interface
- **N8N Monitoring**: Performance monitor, Agent status

### **Entertainment Tools**
- **Entertainment**: Spotify, Netflix, YouTube, Twitch

## 📊 Display Preferences

Each tool has preferred displays where it works best:

| Tool | Preferred Displays | Layout | Profile |
|------|-------------------|--------|---------|
| Code Editor | Center, Left | BSP | Work |
| Terminal | Center, Right | BSP | Work |
| AI Chat | Center, Left | Stack | AI Research |
| AI Development | Center, Right | BSP | AI Research |
| Productivity | Right, Left | Stack | Personal |
| Communication | Right, Left | Stack | Personal |
| Web Browser | Left, Center | BSP | Work |
| N8N Dashboard | Center, Right | BSP | Work |
| N8N Monitoring | Right, Center | Stack | Work |
| Entertainment | Left, Right | Float | Personal |

## 🎛️ Usage Methods

### **1. Streamlit Dashboard (Recommended)**
```bash
./launch_dynamic_layout.sh dashboard
```
- Visual interface with real-time status
- Drag-and-drop tool swapping
- Profile switching with one click
- Layout history and system monitoring

### **2. Command Line Interface**
```bash
./launch_dynamic_layout.sh cli
```
- Interactive menu system
- Quick tool suggestions
- Profile management
- Layout history viewing

### **3. Direct Commands**
```bash
# Quick tool swaps
./launch_dynamic_layout.sh swap left web_browser
./launch_dynamic_layout.sh swap center code_editor
./launch_dynamic_layout.sh swap right productivity

# Profile switching
./launch_dynamic_layout.sh profile work
./launch_dynamic_layout.sh profile personal
./launch_dynamic_layout.sh profile ai_research

# Status checking
./launch_dynamic_layout.sh status
```

### **4. Keyboard Shortcuts (BetterTouchTool)**
```bash
./launch_dynamic_layout.sh shortcuts
```
- **Cmd+Shift+1**: Swap left display
- **Cmd+Shift+2**: Swap center display  
- **Cmd+Shift+3**: Swap right display
- **Cmd+Shift+W**: Switch to work profile
- **Cmd+Shift+P**: Switch to personal profile
- **Cmd+Shift+A**: Switch to AI research profile

## 🔧 Configuration

### **Main Configuration File**
Edit `configs/dynamic_layout_config.yaml` to customize:

```yaml
# Add new tools
tools:
  my_custom_tool:
    name: "My Custom Tool"
    category: "custom"
    apps: ["MyApp", "AnotherApp"]
    description: "My custom tool description"
    workspace_profile: "work"
    display_preference: [2, 1]  # Center, Left
    layout: "bsp"
    launch_commands:
      - "open -a 'MyApp'"

# Modify display preferences
displays:
  left:
    preferred_tools: ["web_browser", "entertainment", "my_custom_tool"]
```

### **Profile Configuration**
```yaml
profiles:
  work:
    display_mapping:
      left: "web_browser"
      center: "code_editor"
      right: "n8n_monitoring"
```

## 🤖 N8N Workflows v2 Integration

The system integrates seamlessly with your N8N Workflows v2 platform:

### **Auto-Launch N8N Tools**
- **Work Profile**: Automatically launches N8N dashboard and monitoring
- **AI Research Profile**: Launches AI development tools and N8N dashboard
- **Personal Profile**: Launches productivity and communication tools

### **Performance Monitoring**
- Real-time Neural Engine utilization tracking
- Memory usage monitoring
- Thermal status monitoring
- Performance metrics logging

### **Cross-Platform Communication**
- Agent status monitoring
- Workflow execution tracking
- Model loading status
- Error reporting and logging

## ⏰ Time-Based Automation

The system includes intelligent time-based profile switching:

### **Automatic Schedule**
- **Work Hours** (Mon-Fri, 9 AM - 5 PM): Work profile
- **Evening Hours** (6 PM - 8 AM): Personal profile  
- **Research Hours** (Mon-Fri, 5 PM - 6 PM): AI Research profile

### **Enable Background Monitoring**
```bash
# Start automatic monitoring
./launch_dynamic_layout.sh monitor

# Stop monitoring
./launch_dynamic_layout.sh stop-monitor
```

## 📈 Performance Features

### **Layout Optimization**
- **BSP Layout**: For development and AI tools (efficient space usage)
- **Stack Layout**: For productivity and communication (easy switching)
- **Float Layout**: For entertainment (flexible positioning)

### **Memory Management**
- Intelligent app launching and closing
- Automatic window management
- YABAI workspace optimization
- Background process monitoring

### **State Persistence**
- Automatic layout state saving
- Profile restoration on startup
- Layout history tracking
- Error recovery mechanisms

## 🔒 Security & Privacy

### **Local Processing**
- All layout management happens locally
- No cloud dependencies
- Secure configuration storage
- Encrypted state files

### **Access Control**
- Profile-based tool access
- Display-specific permissions
- Time-based restrictions
- Audit logging

## 🧪 Testing & Debugging

### **Status Checking**
```bash
# Check current layout status
./launch_dynamic_layout.sh status

# View layout history
python3 dynamic_layout_manager.py
# Then select option 5 (Show layout history)
```

### **Debug Mode**
```bash
# Enable debug logging
export DYNAMIC_LAYOUT_DEBUG=1
./launch_dynamic_layout.sh dashboard
```

### **Manual Testing**
```bash
# Test individual tool swaps
./launch_dynamic_layout.sh swap left web_browser
./launch_dynamic_layout.sh swap center code_editor
./launch_dynamic_layout.sh swap right productivity

# Test profile switching
./launch_dynamic_layout.sh profile work
./launch_dynamic_layout.sh profile personal
./launch_dynamic_layout.sh profile ai_research
```

## 📚 Advanced Usage

### **Custom Tool Creation**
1. Edit `configs/dynamic_layout_config.yaml`
2. Add your tool definition under `tools:`
3. Configure display preferences and launch commands
4. Restart the system

### **Profile Customization**
1. Modify profile definitions in the config file
2. Add custom display mappings
3. Configure time-based switching rules
4. Test with the dashboard

### **Integration with External Tools**
- **BetterTouchTool**: Keyboard shortcuts and gestures
- **Raycast**: Quick actions and commands
- **Alfred**: Workflow integration
- **Keyboard Maestro**: Advanced automation

## 🚨 Troubleshooting

### **Common Issues**

#### **YABAI Not Running**
```bash
# Start YABAI
brew services start yabai

# Check YABAI status
yabai -m query --spaces
```

#### **Tool Swap Fails**
```bash
# Check if app is installed
ls /Applications/ | grep "App Name"

# Check YABAI permissions
yabai -m query --windows
```

#### **Dashboard Won't Launch**
```bash
# Install Streamlit
pip3 install streamlit

# Check port availability
lsof -i :8503
```

#### **Configuration Errors**
```bash
# Validate configuration
python3 -c "import yaml; yaml.safe_load(open('configs/dynamic_layout_config.yaml'))"
```

### **Performance Issues**
- Check memory usage: `top -l 1 | grep Python`
- Monitor YABAI performance: `yabai -m query --spaces`
- Review logs: `tail -f logs/dynamic_layout.log`

## 🔮 Future Enhancements

### **Planned Features**
- **Voice Control**: Speech-to-text tool swapping
- **Gesture Recognition**: Trackpad/mouse gesture support
- **AI-Powered Suggestions**: Machine learning for tool recommendations
- **Mobile Integration**: Remote layout control via mobile app

### **Advanced Integrations**
- **HomeKit**: Smart home automation triggers
- **Calendar Integration**: Automatic profile switching based on events
- **Biometric Authentication**: Face ID/Touch ID for profile switching
- **Cloud Sync**: Multi-device layout synchronization

## 📞 Support

### **Documentation**
- [YABAI Configuration](configs/yabai_config.yaml)
- [Dynamic Layout Configuration](configs/dynamic_layout_config.yaml)
- [N8N Workflows v2 Integration](../N8N_Workflows_v2/README.md)

### **Logs**
- Main log: `logs/dynamic_layout.log`
- YABAI log: `configs/yabai.log`
- Performance metrics: `logs/performance.log`

### **Community**
- GitHub Issues: Report bugs and request features
- Discussions: Share ideas and get help
- Wiki: Community-contributed documentation

---

## 🎉 Success Metrics

The Dynamic Layout Manager provides:

- **⚡ Instant Tool Swapping**: Change tools in seconds
- **🎯 Intelligent Suggestions**: Context-aware tool recommendations  
- **🔄 Seamless Integration**: Works with YABAI and N8N Workflows v2
- **📊 Real-time Monitoring**: Live status and performance tracking
- **🛡️ Reliable Operation**: Error handling and state persistence
- **🎛️ Multiple Interfaces**: Dashboard, CLI, and keyboard shortcuts

**Transform your multi-display workflow with intelligent tool management! 🚀** 