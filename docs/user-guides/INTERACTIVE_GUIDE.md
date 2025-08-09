# 🎮 NEXUS Interactive User Guide

> **Step-by-Step Tutorials for AI-Powered Workspace Management**

## 🚀 Getting Started

### Welcome to NEXUS! 🎯

NEXUS is your AI-powered workspace intelligence system. This interactive guide will walk you through every feature and help you master your multi-display workflow.

**What you'll learn:**
- 🎛️ **Main Interface**: Navigate the launcher and dashboards
- 🧠 **AI Integration**: Use your model collection for workspace optimization
- 🖥️ **Display Management**: Master your 3-display setup
- ⏰ **Smart Scheduling**: Automate workspace switching
- 📊 **Analytics**: Track productivity and usage patterns

---

## 📋 Table of Contents

1. [🎛️ Main Interface](#️-main-interface)
2. [🧠 AI Integration](#-ai-integration)
3. [🖥️ Display Management](#️-display-management)
4. [⏰ Smart Scheduling](#-smart-scheduling)
5. [📊 Analytics & Monitoring](#-analytics--monitoring)
6. [🎯 Advanced Features](#-advanced-features)
7. [🔧 Troubleshooting](#-troubleshooting)

---

## 🎛️ Main Interface

### Step 1: Launch NEXUS

```bash
# Navigate to NEXUS directory
cd ~/Desktop/NEXUS

# Start the main interface
./launcher.sh
```

**Expected Output:**
```
🎯 NEXUS Workspace Manager
================================
📋 Workspace Profiles
  1) Work Profile (Development & Productivity)
  2) Personal Profile (Entertainment & Social)
  3) AI Research Profile (AI & ML Development)
  4) Daily Routine (Default Setup)

🛠️ Management Tools
  5) Interactive Workspace Manager
  6) Display Configuration Detector
  7) Enhanced AI Integration & Optimization
  8) AI Model Manager (Python)
  9) Screen Time Data Collection
  10) Activity Watch Integration

📊 Dashboard & Monitoring
  11) Streamlit Dashboard
  12) System Status Check

⚙️ Configuration
  13) Install YABAI Rules
  14) View Current Configuration

❓ Help & Information
  15) Show Help
  16) About

🚪 Exit
  0) Exit

Select an option (0-16):
```

### Step 2: Explore Workspace Profiles

**Try each profile to see the difference:**

```bash
# Load Work Profile (Development)
./workspace_profiles/work_profile.sh

# Load Personal Profile (Entertainment)
./workspace_profiles/personal_profile.sh

# Load AI Research Profile (AI/ML)
./workspace_profiles/ai_research_profile.sh
```

**What happens:**
- Applications automatically open and position
- Windows arrange according to profile
- AI models load for context-specific assistance
- Display layouts optimize for the task

### Step 3: Launch Dashboard

```bash
# Start Streamlit dashboard
cd dashboard && streamlit run workspace_dashboard.py
```

**Dashboard Features:**
- **Real-time Status**: See YABAI service, displays, active windows
- **Profile Management**: Load profiles with GUI buttons
- **System Controls**: Start/stop services, restart YABAI
- **Display Layout**: Visual representation of your 3-display setup

---

## 🧠 AI Integration

### Step 1: Check Your Model Collection

```bash
# Run enhanced AI integration
./scripts/enhanced_ai_integration.sh
```

**Expected Output:**
```
🤖 Enhanced AI Integration for YABAI Workspace
==================================================
📁 Model Collection Analysis
=============================
✅ Model collection found at /Volumes/MICRO/models
📊 Model Statistics:
  - Total Models: 92
  - MLX Models: 45
  - GGUF Models: 47
🎯 Model Categories:
  ✅ Reasoning Models: Available
  ✅ Vision Models: Available
  ✅ Coding Models: Available
```

### Step 2: Analyze Workspace Context

The AI system automatically analyzes your current workspace:

```bash
# Get workspace analysis
./scripts/enhanced_ai_integration.sh --analyze
```

**What it analyzes:**
- **Time of Day**: Work hours vs personal hours
- **Active Applications**: Development vs entertainment apps
- **System Resources**: Available memory and CPU
- **Display Usage**: How you're using each display

### Step 3: Get AI Recommendations

```bash
# Get workspace suggestions
./scripts/enhanced_ai_integration.sh --suggest
```

**Example Recommendations:**
```
🧠 AI-Powered Workspace Suggestions
=====================================
💼 Work Profile Optimizations:
  - Load coding assistant models for development
  - Optimize display layout for development tools
  - Enable code completion and documentation assistance
  - Suggest relevant development tools based on current project

📋 Recommended Models:
  - Coding: DeepSeek-R1-0528-Qwen3-8B-MLX-4bit
  - Reasoning: Phi-4-mini-reasoning-MLX-4bit
```

### Step 4: Use Python Model Manager

```bash
# Run advanced model analysis
python3 scripts/ai_model_manager.py
```

**Features:**
- **Model Statistics**: Complete analysis of your collection
- **Performance Scoring**: Which models work best for your system
- **Memory Optimization**: Smart model selection based on available RAM
- **Context Analysis**: Real-time workspace understanding

---

## 🖥️ Display Management

### Step 1: Check Your Display Setup

```bash
# Run display detector
./scripts/display_detector.sh
```

**Expected Output:**
```
🔍 Display Configuration Detector
================================
✅ Display 1: HZ30GAMER 30" (3440x1440)
✅ Display 2: LG ULTRAWIDE 34" (1920x1080)
✅ Display 3: iMac 24" (2560x1080)
📊 Total Resolution: 7920x1440 pixels
🎯 Optimal Layout: Ultrawide left, iMac center, curved right
```

### Step 2: Dynamic Layout Management

```bash
# Launch dynamic layout system
./launch_dynamic_layout.sh dashboard
```

**Interactive Features:**
- **Tool Swapping**: Change tools across displays instantly
- **Profile Switching**: Context-aware workspace changes
- **Visual Interface**: Drag-and-drop workspace management
- **Layout History**: Track workspace changes over time

### Step 3: Quick Tool Swaps

```bash
# Swap tools on different displays
./launch_dynamic_layout.sh swap left web_browser
./launch_dynamic_layout.sh swap center code_editor
./launch_dynamic_layout.sh swap right productivity
```

**Available Tools:**
- **Development**: VS Code, Xcode, Terminal, PyCharm
- **AI Tools**: ChatGPT, Grok, Claude, Perplexity
- **Productivity**: Notion, Obsidian, Calendar, Reminders
- **Web Tools**: Safari, Chrome, Firefox, Vivaldi
- **Entertainment**: Spotify, Netflix, YouTube, Twitch

### Step 4: Profile Switching

```bash
# Switch profiles with AI optimization
./launch_dynamic_layout.sh profile work
./launch_dynamic_layout.sh profile personal
./launch_dynamic_layout.sh profile ai_research
```

---

## ⏰ Smart Scheduling

### Step 1: Enable Auto-Scheduling

```bash
# Start auto scheduler
./scripts/auto_scheduler.sh start
```

**Schedule Configuration:**
- **Work Hours** (Mon-Fri, 9 AM - 5 PM): Work Profile
- **Research Hours** (Mon-Fri, 5 PM - 6 PM): AI Research Profile
- **Evening Hours** (Daily, 6 PM - 8 AM): Personal Profile

### Step 2: Check Schedule Status

```bash
# Check current schedule
./scripts/auto_scheduler.sh status
```

**Expected Output:**
```
⏰ Auto Scheduler Status
=======================
✅ Auto scheduler is running
🕐 Current Time: 14:30 (Wednesday)
📅 Current Profile: work
⏭️ Next Switch: 17:00 → ai_research
📊 Schedule:
  - Work: Mon-Fri 09:00-17:00
  - Research: Mon-Fri 17:00-18:00
  - Personal: Daily 18:00-08:00
```

### Step 3: Manual Profile Switching

```bash
# Manual profile switch
./scripts/auto_scheduler.sh manual

# Force specific profile
./scripts/auto_scheduler.sh force work
./scripts/auto_scheduler.sh force personal
./scripts/auto_scheduler.sh force ai_research
```

### Step 4: Customize Schedule

Edit `configs/yabai_config.yaml`:

```yaml
time_based_switching:
  enabled: true
  schedules:
    work_hours:
      days: [1, 2, 3, 4, 5]  # Monday to Friday
      start_time: "09:00"
      end_time: "17:00"
      profile: "work"
    
    research_hours:
      days: [1, 2, 3, 4, 5]  # Monday to Friday
      start_time: "17:00"
      end_time: "18:00"
      profile: "ai_research"
    
    evening_hours:
      days: [1, 2, 3, 4, 5, 6, 7]  # All days
      start_time: "18:00"
      end_time: "08:00"
      profile: "personal"
```

---

## 📊 Analytics & Monitoring

### Step 1: Screen Time Collection

```bash
# Start screen time monitoring
./scripts/screen_time_collector.sh monitor
```

**What it tracks:**
- **Application Usage**: Which apps you use most
- **Display Usage**: How you use each display
- **Productivity Patterns**: Work vs personal time
- **Performance Metrics**: System resource usage

### Step 2: Activity Watch Integration

```bash
# Start activity monitoring
./scripts/activity_watch_integration.sh monitor
```

**Analytics Features:**
- **Productivity Analysis**: Focus time and distractions
- **Workspace Patterns**: How you organize your space
- **Performance Insights**: System optimization suggestions
- **Trend Analysis**: Long-term usage patterns

### Step 3: Generate Reports

```bash
# Generate daily report
./scripts/screen_time_collector.sh report

# Generate productivity report
./scripts/activity_watch_integration.sh report
```

**Report Contents:**
- **Daily Summary**: Apps used, time spent, productivity score
- **Display Analysis**: How you used each display
- **AI Insights**: Suggestions for workspace optimization
- **Performance Metrics**: System health and resource usage

### Step 4: View Real-Time Analytics

```bash
# Launch analytics dashboard
cd dashboard && streamlit run workspace_dashboard.py
```

**Dashboard Features:**
- **Real-time Metrics**: Live system and workspace data
- **Historical Trends**: Usage patterns over time
- **AI Recommendations**: Intelligent workspace suggestions
- **Performance Monitoring**: CPU, memory, and system health

---

## 🎯 Advanced Features

### Step 1: Custom Workspace Profiles

Create your own profile in `workspace_profiles/`:

```bash
# Create custom profile
cp workspace_profiles/work_profile.sh workspace_profiles/custom_profile.sh

# Edit the profile
nano workspace_profiles/custom_profile.sh
```

**Example Custom Profile:**
```bash
#!/bin/zsh

# Custom Profile - Gaming & Development
echo "🎮 Loading Custom Profile..."

# Gaming Applications
open -na "/Applications/Steam.app"
open -na "/Applications/Discord.app"
open -na "/Applications/Spotify.app"

# Development Tools
open -na "/Applications/VS Code.app"
open -na "/Applications/Terminal.app"

# Apply custom YABAI rules
yabai -m rule --add app="Steam" display=1 space=1
yabai -m rule --add app="Discord" display=3 space=1
yabai -m rule --add app="VS Code" display=2 space=1
```

### Step 2: AI Model Customization

Edit `configs/yabai_config.yaml` to customize AI models:

```yaml
ai_integration:
  model_recommendations:
    custom_profile:
      primary: "Qwen3-8B-MLX-4bit"
      gaming: "Meta-Llama-3.1-8B-Instruct-Q6_K"
      development: "DeepSeek-R1-0528-Qwen3-8B-MLX-4bit"
      quick: "TinyLlama-1.1B-Chat-v1.0-mlx"
```

### Step 3: Advanced YABAI Rules

Add custom rules to `configs/yabai_config.yaml`:

```yaml
yabai_rules:
  # Custom application rules
  - app: "Custom App"
    display: 2
    space: 1
    float: true
  
  # Display-specific rules
  - app: "Browser"
    display: 1
    space: 1
    layout: "bsp"
  
  # Time-based rules
  - app: "Entertainment"
    display: 3
    space: 1
    time: "18:00-08:00"
```

### Step 4: Integration with External Tools

```bash
# Install Keyboard Maestro integration
./integrations/install_integrations.sh km

# Install BetterTouchTool integration
./integrations/install_integrations.sh btt

# Install Raycast integration
./integrations/install_integrations.sh raycast
```

**Integration Features:**
- **Keyboard Maestro**: One-key profile switching
- **BetterTouchTool**: Gesture-based workspace control
- **Raycast**: Quick commands and launcher integration

---

## 🔧 Troubleshooting

### Common Issues & Solutions

#### **Issue 1: YABAI Not Starting**
```bash
# Check SIP status
csrutil status

# If enabled, temporarily disable SIP
# Reboot into Recovery Mode
# csrutil disable
# Reboot

# Restart YABAI
yabai --restart-service

# Check YABAI status
yabai -m query --displays
```

#### **Issue 2: Display Detection Problems**
```bash
# Check display configuration
./scripts/display_detector.sh

# Reconfigure displays
./scripts/display_detector.sh --reconfigure

# Manual display setup
yabai -m query --displays
```

#### **Issue 3: AI Integration Issues**
```bash
# Check model collection
ls -la /Volumes/MICRO/models/

# Test model loading
python3 scripts/ai_model_manager.py --debug

# Check Python dependencies
pip3 list | grep -E "(streamlit|psutil|pyyaml)"
```

#### **Issue 4: Performance Problems**
```bash
# Check memory usage
./scripts/enhanced_ai_integration.sh --memory

# Optimize model loading
python3 scripts/ai_model_manager.py --optimize

# Use lighter models
./scripts/enhanced_ai_integration.sh --lightweight
```

### Debug Mode

```bash
# Enable debug mode
export NEXUS_DEBUG=1

# Run with verbose output
./launcher.sh --verbose

# Generate debug report
./scripts/debug_report.sh
```

### Getting Help

- **Documentation**: Check the [User Guide](USER_GUIDE.md)
- **Installation**: Review the [Installation Guide](INSTALLATION.md)
- **Issues**: Report problems on GitHub
- **Community**: Join our Discord server

---

## 🎉 Congratulations!

You've completed the NEXUS Interactive User Guide! 

**What you've learned:**
- ✅ **Main Interface**: Navigate launcher and dashboards
- ✅ **AI Integration**: Use your model collection effectively
- ✅ **Display Management**: Master your 3-display setup
- ✅ **Smart Scheduling**: Automate workspace switching
- ✅ **Analytics**: Track productivity and usage patterns
- ✅ **Advanced Features**: Customize and extend NEXUS

**Next Steps:**
1. **Explore**: Try different features and combinations
2. **Customize**: Create your own profiles and rules
3. **Optimize**: Fine-tune for your specific workflow
4. **Share**: Contribute to the NEXUS community

---

**🚀 NEXUS - Your AI-Powered Workspace Intelligence System**

*Transform your multi-display workflow with intelligent automation!* 🎯
