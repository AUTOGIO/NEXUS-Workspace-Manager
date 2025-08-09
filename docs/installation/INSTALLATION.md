# 🛠️ NEXUS Installation Guide

> **Complete Setup Instructions for AI-Powered Workspace Intelligence**

## 📋 Prerequisites

### System Requirements
- **macOS**: 12.0 (Monterey) or later
- **Architecture**: Apple Silicon (M1/M2/M3) or Intel
- **Memory**: 8GB RAM minimum (16GB+ recommended)
- **Storage**: 2GB free space for NEXUS + model storage
- **Displays**: Multi-display setup recommended (3 displays optimal)

### Hardware Setup
- **Left Display**: HZ30GAMER 30" curved (3440x1440)
- **Center Display**: LG ULTRAWIDE 34" curved (1920x1080)
- **Right Display**: iMac 24" (2560x1080)

## 🚀 Quick Installation

### Step 1: Install Dependencies

```bash
# Install Homebrew (if not already installed)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install required tools
brew install yabai skhd jq python3

# Install optional integrations
brew install --cask keyboard-maestro bettertouchtool raycast

# Install Python dependencies
pip3 install streamlit psutil pyyaml
```

### Step 2: Download NEXUS

```bash
# Navigate to Desktop
cd ~/Desktop

# Clone NEXUS repository
git clone https://github.com/your-repo/nexus.git
cd nexus

# Make scripts executable
chmod +x *.sh scripts/*.sh workspace_profiles/*.sh
```

### Step 3: Configure YABAI

```bash
# Start YABAI service
yabai --start-service

# Install YABAI rules
./yabairc_additions.sh

# Verify YABAI is running
yabai -m query --displays
```

### Step 4: Install Integrations (Optional)

```bash
# Install all integrations
./integrations/install_integrations.sh all

# Or install specific integrations
./integrations/install_integrations.sh km      # Keyboard Maestro
./integrations/install_integrations.sh btt     # BetterTouchTool
./integrations/install_integrations.sh raycast # Raycast
```

### Step 5: Configure AI Models

```bash
# Set up model collection path
export MODEL_PATH="/Volumes/MICRO/models"

# Test AI integration
./scripts/enhanced_ai_integration.sh

# Run model manager
python3 scripts/ai_model_manager.py
```

## 🔧 Advanced Installation

### Custom Configuration Installation

```bash
# Install with custom configuration
./install.sh --config custom_config.yaml

# Install with specific integrations
./install.sh --integrations km,btt,raycast

# Install with AI model integration
./install.sh --ai-models /path/to/models
```

### Development Installation

```bash
# Clone with development dependencies
git clone --recursive https://github.com/your-repo/nexus.git
cd nexus

# Install development dependencies
pip3 install -r requirements-dev.txt

# Run tests
python3 -m pytest tests/

# Install in development mode
pip3 install -e .
```

### Docker Installation (Experimental)

```bash
# Build Docker image
docker build -t nexus .

# Run NEXUS in Docker
docker run -it --rm \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  -e DISPLAY=$DISPLAY \
  nexus
```

## ⚙️ Configuration

### Basic Configuration

Edit `configs/yabai_config.yaml`:

```yaml
# Display Configuration
displays:
  left:
    id: 1
    name: "HZ30GAMER 30\""
    purpose: "Browsers & Web Tools"
    apps: ["Safari", "Vivaldi", "Chrome", "Firefox"]
    
  center:
    id: 2
    name: "LG ULTRAWIDE 34\""
    purpose: "AI & Development Tools"
    apps: ["ChatGPT", "Grok", "VS Code", "Xcode", "Terminal"]
    
  right:
    id: 3
    name: "iMac 24\""
    purpose: "Productivity & Communication"
    apps: ["Obsidian", "WhatsApp", "X", "Slack", "Teams"]

# AI Integration Settings
ai_integration:
  model_storage_path: "/Volumes/MICRO/models"
  ollama_enabled: true
  mlx_enabled: true
  lm_studio_enabled: true
```

### Advanced Configuration

```yaml
# Performance Settings
performance:
  rule_cache_enabled: true
  display_detection_interval: 30
  status_update_interval: 10
  dashboard_refresh_rate: 5

# Time-based Workspace Switching
time_based_switching:
  enabled: true
  schedules:
    work_hours:
      days: [1, 2, 3, 4, 5]
      start_time: "09:00"
      end_time: "17:00"
      profile: "work"
    
    evening_hours:
      days: [1, 2, 3, 4, 5, 6, 7]
      start_time: "18:00"
      end_time: "08:00"
      profile: "personal"
```

## 🔍 Verification

### System Check

```bash
# Run system verification
./scripts/system_check.sh

# Expected output:
# ✅ YABAI service is running
# ✅ Display configuration detected
# ✅ AI model collection found
# ✅ Python dependencies installed
# ✅ Scripts are executable
```

### Integration Test

```bash
# Test workspace profiles
./workspace_profiles/work_profile.sh
./workspace_profiles/personal_profile.sh
./workspace_profiles/ai_research_profile.sh

# Test AI integration
./scripts/enhanced_ai_integration.sh

# Test dashboard
cd dashboard && streamlit run workspace_dashboard.py
```

### Performance Test

```bash
# Test model loading
python3 scripts/ai_model_manager.py --test

# Test memory usage
./scripts/enhanced_ai_integration.sh --memory

# Test display detection
./scripts/display_detector.sh
```

## 🚀 First Launch

### 1. Start NEXUS

```bash
# Launch main interface
./launcher.sh
```

### 2. Load Initial Profile

```bash
# Load work profile for development
./workspace_profiles/work_profile.sh

# Or load personal profile for entertainment
./workspace_profiles/personal_profile.sh
```

### 3. Launch Dashboard

```bash
# Start Streamlit dashboard
cd dashboard && streamlit run workspace_dashboard.py

# Open in browser: http://localhost:8501
```

### 4. Test AI Integration

```bash
# Run enhanced AI integration
./scripts/enhanced_ai_integration.sh

# Check model recommendations
python3 scripts/ai_model_manager.py
```

## 🔧 Troubleshooting

### Common Issues

#### **YABAI Not Starting**
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

#### **Display Detection Issues**
```bash
# Check display configuration
./scripts/display_detector.sh

# Reconfigure displays
./scripts/display_detector.sh --reconfigure

# Manual display setup
yabai -m query --displays
```

#### **AI Integration Problems**
```bash
# Check model collection
ls -la /Volumes/MICRO/models/

# Test model loading
python3 scripts/ai_model_manager.py --debug

# Check Python dependencies
pip3 list | grep -E "(streamlit|psutil|pyyaml)"
```

#### **Permission Issues**
```bash
# Fix script permissions
chmod +x *.sh scripts/*.sh workspace_profiles/*.sh

# Check file ownership
ls -la *.sh scripts/*.sh

# Fix ownership if needed
sudo chown $(whoami) *.sh scripts/*.sh
```

### Performance Issues

#### **High Memory Usage**
```bash
# Check memory usage
./scripts/enhanced_ai_integration.sh --memory

# Optimize model loading
python3 scripts/ai_model_manager.py --optimize

# Use lighter models
./scripts/enhanced_ai_integration.sh --lightweight
```

#### **Slow Response Times**
```bash
# Check system resources
top -l 1 | head -10

# Optimize YABAI rules
./scripts/optimize_rules.sh

# Clear caches
./scripts/clear_caches.sh
```

## 📊 Post-Installation

### Initial Setup

1. **Configure Workspace Profiles**
   - Customize applications for each profile
   - Set display assignments
   - Configure AI model preferences

2. **Set Up Integrations**
   - Configure Keyboard Maestro macros
   - Set up BetterTouchTool gestures
   - Install Raycast extensions

3. **Optimize Performance**
   - Adjust model loading preferences
   - Configure memory limits
   - Set up background monitoring

### Maintenance

```bash
# Update NEXUS
git pull origin main

# Update dependencies
brew upgrade yabai skhd
pip3 install --upgrade streamlit psutil pyyaml

# Clear old data
./scripts/cleanup.sh

# Backup configuration
./scripts/backup_config.sh
```

## 🎯 Next Steps

### 1. Explore Features
- Try different workspace profiles
- Test AI integration
- Explore dashboard features
- Experiment with dynamic layouts

### 2. Customize Setup
- Modify workspace profiles
- Add custom applications
- Configure AI model preferences
- Set up personal workflows

### 3. Advanced Usage
- Set up automated scheduling
- Configure data collection
- Integrate with external tools
- Develop custom extensions

## 📞 Support

### Getting Help
- **Documentation**: Check the [User Guide](USER_GUIDE.md)
- **Issues**: Report problems on GitHub
- **Community**: Join our Discord server
- **Email**: support@nexus-workspace.com

### Debugging
```bash
# Enable debug mode
export NEXUS_DEBUG=1

# Run with verbose output
./launcher.sh --verbose

# Generate debug report
./scripts/debug_report.sh
```

---

**🎯 NEXUS Installation Complete!**

Your AI-powered workspace intelligence system is now ready to transform your multi-display workflow! 🚀
