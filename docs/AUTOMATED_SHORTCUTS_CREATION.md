# 🚀 Automated YABAI Shortcuts Creation

## Overview

This system provides **fully automated creation** of Apple Shortcuts for all YABAI AI-enhanced profiles with **minimal human intervention**. The scripts use AppleScript to programmatically create shortcuts in the native macOS Shortcuts app.

## 🎯 What This System Does

- **Automatically creates** Apple Shortcuts for all 6 YABAI profiles
- **Uses AppleScript** to interact with the Shortcuts app
- **Requires minimal user input** - just run one script
- **Handles existing shortcuts** - overwrites/updates automatically
- **Provides visual feedback** with colored output and progress indicators
- **Error handling** with cleanup and recovery

## 📁 Script Files

### 1. **`one_click_shortcuts.sh`** ⭐ **RECOMMENDED**
- **Purpose**: Fully automated execution with zero prompts
- **Usage**: Just run it and it handles everything
- **Best for**: Set-and-forget automation

### 2. **`launch_shortcuts_creator.sh`**
- **Purpose**: Simple launcher for the main automation script
- **Usage**: Basic launcher with minimal output
- **Best for**: Simple execution

### 3. **`scripts/create_all_yabai_shortcuts_automated.sh`**
- **Purpose**: Main automation engine with full features
- **Usage**: Called by launcher scripts
- **Best for**: Advanced users who want full control

## 🚀 Quick Start (Recommended)

### **One-Command Execution**
```bash
# Navigate to your YABAI project
cd /Users/eduardof.giovannini/Library/Mobile\ Documents/com~apple~CloudDocs/Obsidian/Projects/FINALIZADO/YABAI

# Run the one-click script
./one_click_shortcuts.sh
```

**That's it!** The script will:
1. ✅ Check all prerequisites
2. 🔄 Create shortcuts for all 6 profiles
3. 🎨 Set custom icons and colors
4. 🎯 Open Shortcuts app to show results

## 📋 Prerequisites

Before running the scripts, ensure you have:

- ✅ **macOS** (required for AppleScript)
- ✅ **Shortcuts app** installed (`/System/Applications/Shortcuts.app`)
- ✅ **YABAI project** with profile scripts
- ✅ **`.command` files** in `~/Desktop/YABAI_Shortcuts/`

## 🔧 How It Works

### **1. Prerequisite Checking**
```bash
# Checks for:
- Shortcuts app existence
- YABAI profile scripts
- Required system tools (osascript)
```

### **2. Shortcut Creation Process**
```bash
# For each profile:
1. Check if shortcut exists
2. Delete existing (if any)
3. Create new shortcut with AppleScript
4. Configure shell script action
5. Set custom icon and color
6. Save shortcut
```

### **3. AppleScript Integration**
```applescript
tell application "Shortcuts"
    -- Create new shortcut
    set newShortcut to make new shortcut with properties {name:"Profile Name"}
    
    -- Add Run Shell Script action
    set shellAction to make new action in newShortcut
    set action type of shellAction to "Run Shell Script"
    
    -- Configure and save
    set script content of shellAction to "/path/to/profile.sh"
    save newShortcut
end tell
```

## 🎨 Profile Customization

Each profile gets unique styling:

| Profile | Icon | Color | Description |
|---------|------|-------|-------------|
| `ai_business_profile` | 💼 | Blue | Business Workflow Optimization |
| `ai_content_creation_profile` | ✍️ | Green | Content Creation Setup |
| `ai_development_profile` | 💻 | Purple | Development Environment |
| `ai_gaming_profile` | 🎮 | Orange | Gaming Workspace |
| `ai_learning_profile` | 📚 | Yellow | Learning Environment |
| `ai_research_profile` | 🔬 | Red | Research Workspace |

## 📊 Output and Feedback

### **Progress Indicators**
- 🔄 **Processing** - Currently working on a profile
- ✅ **Success** - Shortcut created successfully
- ⚠️ **Warning** - Existing shortcut found and deleted
- ❌ **Error** - Something went wrong

### **Final Summary**
```
╔══════════════════════════════════════════════════════════════╗
║                    CREATION SUMMARY                          ║
╚══════════════════════════════════════════════════════════════╝
✅ Successfully created: 6/6 shortcuts

🎉 All shortcuts created successfully!
   You can find them in the 'All Shortcuts' section.
```

## 🛠️ Troubleshooting

### **Common Issues**

#### **1. "Shortcuts app not found"**
```bash
# Check if Shortcuts is installed
ls -la /System/Applications/ | grep -i shortcut

# If not found, install from App Store
open -a "App Store"
# Search for "Shortcuts" and install
```

#### **2. "Profile script not found"**
```bash
# Ensure you've run the simple shortcuts creator first
./scripts/create_yabai_shortcuts_simple.sh

# Check if .command files exist
ls -la ~/Desktop/YABAI_Shortcuts/
```

#### **3. "Permission denied"**
```bash
# Make scripts executable
chmod +x *.sh
chmod +x scripts/*.sh
```

#### **4. AppleScript errors**
```bash
# Check if osascript is available
which osascript

# Verify Shortcuts app path
ls -la /System/Applications/Shortcuts.app
```

### **Debug Mode**
```bash
# Run with verbose output
bash -x ./one_click_shortcuts.sh

# Check script logs
tail -f /tmp/yabai_shortcuts_auto.sh
```

## 🔄 Updating Existing Shortcuts

The system automatically handles updates:

1. **Detects existing shortcuts** by name
2. **Deletes old versions** completely
3. **Creates fresh shortcuts** with latest configuration
4. **Maintains consistency** across all profiles

## 📱 Using Your New Shortcuts

After creation, your shortcuts will be available in:

- **Shortcuts app** → "All Shortcuts" section
- **Spotlight** → Search by profile name
- **Siri** → "Hey Siri, run [profile name]"
- **Menu Bar** → Add to menu bar for quick access

### **Example Usage**
```bash
# Run a profile shortcut
# 1. Open Shortcuts app
# 2. Find your profile shortcut
# 3. Click the play button (▶️)
# 4. Watch it execute your YABAI profile!
```

## 🎯 Advanced Customization

### **Modifying Profile Configurations**
Edit `scripts/create_all_yabai_shortcuts_automated.sh`:

```bash
# Change icons
declare -A PROFILE_ICONS=(
    ["ai_business_profile"]="🏢"  # Custom icon
    # ... other profiles
)

# Change colors
declare -A PROFILE_COLORS=(
    ["ai_business_profile"]="indigo"  # Custom color
    # ... other profiles
)
```

### **Adding New Profiles**
```bash
# 1. Add to PROFILES array
["new_profile"]="New Profile Description"

# 2. Add to ICONS array
["new_profile"]="🆕"

# 3. Add to COLORS array
["new_profile"]="pink"

# 4. Create the actual profile script
# 5. Run the automation script
```

## 🚀 Performance Tips

### **Optimization**
- **Batch processing** - Creates all shortcuts in sequence
- **Error recovery** - Continues even if one fails
- **Resource management** - Small delays prevent overwhelming Shortcuts app
- **Cleanup** - Removes temporary files automatically

### **Expected Execution Time**
- **Total time**: 10-15 seconds
- **Per shortcut**: 1-2 seconds
- **System overhead**: Minimal (AppleScript is fast)

## 🔒 Security Considerations

### **What the Scripts Do**
- ✅ **Read** your YABAI project files
- ✅ **Create** shortcuts in Shortcuts app
- ✅ **Execute** your profile scripts
- ❌ **Never** access sensitive system files
- ❌ **Never** require admin privileges

### **File Permissions**
```bash
# Scripts are executable by owner only
-rwxr--r--  *.sh
-rwxr--r--  scripts/*.sh
```

## 📚 Related Documentation

- [YABAI Profile System](../profiles/README.md)
- [Auto Window Arrangement](./AUTO_WINDOW_ARRANGEMENT.md)
- [Installation Guide](../installation/INSTALLATION.md)
- [Quick Start Guide](../QUICK_START_GUIDE.md)

## 🤝 Support and Contributing

### **Getting Help**
1. Check this documentation first
2. Review the troubleshooting section
3. Check script output for error messages
4. Verify all prerequisites are met

### **Contributing Improvements**
1. Test your changes thoroughly
2. Update this documentation
3. Follow the project's coding standards
4. Submit pull requests with clear descriptions

---

**🎉 Congratulations!** You now have a fully automated system for creating YABAI profile shortcuts with minimal human intervention.

**Next Steps:**
1. Run `./one_click_shortcuts.sh`
2. Check your Shortcuts app for new shortcuts
3. Test each shortcut to ensure they work
4. Customize further if needed

**Happy automating! 🚀**
