# 🚀 NEXUS Quick Start Guide

> **Simple Step-by-Step Instructions to Get NEXUS Running**

## 📋 Prerequisites

Before starting, make sure you have:
- ✅ macOS 12.0 (Monterey) or later
- ✅ YABAI installed and running
- ✅ Python 3.7+ installed
- ✅ Your model collection at `/Volumes/MICRO/models`

## 🚀 Step-by-Step Launch Sequence

### **Step 1: Navigate to NEXUS Directory**
```bash
cd ~/Desktop/Projects/YABAI
```

### **Step 2: Make Scripts Executable**
```bash
chmod +x *.sh scripts/*.sh configs/profiles/*.sh
```

### **Step 3: Start YABAI Service**
```bash
yabai --start-service
```

### **Step 4: Launch NEXUS Main Interface**
```bash
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

## 🎯 Quick Commands

### **Load Workspace Profiles**
```bash
# Work Profile (Development)
./configs/profiles/work_profile.sh

# Personal Profile (Entertainment)
./configs/profiles/personal_profile.sh

# AI Research Profile (AI/ML)
./configs/profiles/ai_research_profile.sh
```

### **Start AI Integration**
```bash
# Enhanced AI Integration
./scripts/ai/enhanced_ai_integration.sh

# AI Model Manager
python3 scripts/ai/ai_model_manager.py
```

### **Launch Dashboards**
```bash
# Main Dashboard
cd dashboard && streamlit run workspace_dashboard.py

# Dynamic Layout Dashboard
./launch_dynamic_layout.sh dashboard
```

### **Start Analytics**
```bash
# Screen Time Collection
./scripts/analytics/screen_time_collector.sh monitor

# Activity Watch Integration
./scripts/analytics/activity_watch_integration.sh monitor
```

## 🔧 Troubleshooting

### **If YABAI Won't Start**
```bash
# Check SIP status
csrutil status

# Restart YABAI
yabai --restart-service

# Check YABAI status
yabai -m query --displays
```

### **If Scripts Aren't Working**
```bash
# Fix permissions
chmod +x *.sh scripts/*.sh configs/profiles/*.sh

# Check if files exist
ls -la *.sh scripts/*.sh configs/profiles/*.sh
```

### **If AI Integration Fails**
```bash
# Check model collection
ls -la /Volumes/MICRO/models/

# Test Python dependencies
python3 -c "import streamlit, psutil, yaml"
```

## 📊 What Each Component Does

### **Main Launcher** (`./launcher.sh`)
- **Purpose**: Primary interface for all NEXUS features
- **Use**: Start here for any workspace management task
- **Options**: 16 different functions available

### **Workspace Profiles** (`./configs/profiles/`)
- **Purpose**: Pre-configured workspace setups
- **Work Profile**: Development tools and productivity apps
- **Personal Profile**: Entertainment and social media apps
- **AI Research Profile**: AI tools and research applications

### **AI Integration** (`./scripts/ai/`)
- **Purpose**: Intelligent workspace optimization
- **Enhanced AI**: Smart model selection and workspace analysis
- **Model Manager**: Advanced model collection management

### **Dashboards** (`dashboard/` & `./launch_dynamic_layout.sh`)
- **Purpose**: Visual workspace management
- **Streamlit Dashboard**: Real-time monitoring and control
- **Dynamic Layout**: Visual tool swapping and management

### **Analytics** (`./scripts/analytics/`)
- **Purpose**: Data collection and productivity tracking
- **Screen Time**: Application usage monitoring
- **Activity Watch**: Productivity and focus analysis

## 🎯 Recommended First-Time Sequence

### **1. Basic Setup**
```bash
cd ~/Desktop/Projects/YABAI
chmod +x *.sh scripts/*.sh configs/profiles/*.sh
yabai --start-service
```

### **2. Test Basic Functionality**
```bash
./launcher.sh
# Select option 12) System Status Check
```

### **3. Load a Profile**
```bash
./configs/profiles/work_profile.sh
```

### **4. Test AI Integration**
```bash
./scripts/ai/enhanced_ai_integration.sh
```

### **5. Launch Dashboard**
```bash
cd dashboard && streamlit run workspace_dashboard.py
```

## 🔄 Daily Usage Sequence

### **Morning (Work)**
```bash
./configs/profiles/work_profile.sh
./scripts/ai/enhanced_ai_integration.sh
cd dashboard && streamlit run workspace_dashboard.py
```

### **Evening (Personal)**
```bash
./configs/profiles/personal_profile.sh
./scripts/analytics/screen_time_collector.sh monitor
```

### **Research Time**
```bash
./configs/profiles/ai_research_profile.sh
python3 scripts/ai/ai_model_manager.py
```

## 📈 Performance Tips

### **For Best Performance**
1. **Start with launcher.sh** - It's the main entry point
2. **Use profiles for different tasks** - Each is optimized for specific work
3. **Enable AI integration** - Provides intelligent suggestions
4. **Monitor with dashboards** - Track performance and usage
5. **Use analytics** - Understand your productivity patterns

### **Memory Optimization**
- **Low Memory**: Use lighter models automatically selected
- **High Memory**: Full AI integration with all models
- **Background**: Analytics run in background without impact

## 🆘 Getting Help

### **If Something Doesn't Work**
1. **Check YABAI**: `yabai -m query --displays`
2. **Check Permissions**: `ls -la *.sh`
3. **Check Dependencies**: `python3 -c "import streamlit"`
4. **Check Models**: `ls -la /Volumes/MICRO/models/`

### **Documentation**
- **User Guide**: `docs/user-guides/USER_GUIDE.md`
- **Installation**: `docs/installation/INSTALLATION.md`
- **Interactive Guide**: `docs/user-guides/INTERACTIVE_GUIDE.md`

---

## 🎉 You're Ready!

**NEXUS is now ready to transform your workspace!**

**Start with**: `./launcher.sh`
**Then explore**: Different profiles and AI integration
**Monitor with**: Dashboards and analytics

**🚀 NEXUS - Your AI-Powered Workspace Intelligence System**

*Transform your multi-display workflow with intelligent automation!* 🎯
