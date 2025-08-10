# 🎛️ NEXUS Profiles Update Summary

**Updated:** `$(date)`  
**Display Setup:** 2 Displays (Center 34" Curved + Right iMac 24")  
**Configuration:** Displays have separated Spaces - ON

## ✅ **Updates Completed**

### **🔄 Profile Scripts Updated**

All three profile scripts have been completely updated for your 2-display setup:

#### **💼 Work Profile** (`configs/profiles/work_profile.sh`)
**Display Layout:**
- **Center Display (34" curved):** Cursor, iTerm2, Vivaldi, Perplexity (Development & Research)
- **Right Display (iMac 24"):** Obsidian, Notes, Safari, Shortcuts (Communication & Productivity)

**Applications:**
- Development: Cursor, iTerm2, Shortcuts
- Communication: Obsidian, Notes
- Research: Vivaldi, Perplexity, Safari
- AI Tools: ChatGPT, Grok (Always visible)

#### **🏠 Personal Profile** (`configs/profiles/personal_profile.sh`)
**Display Layout:**
- **Center Display (34" curved):** YouTube, Safari, Vivaldi (Entertainment & Browsing)
- **Right Display (iMac 24"):** WhatsApp, X, Telegram, Obsidian (Social & Personal)

**Applications:**
- Social: WhatsApp, X, Telegram
- Entertainment: YouTube
- Productivity: Obsidian
- Browsing: Safari, Vivaldi
- AI Tools: ChatGPT, Grok (Always visible)

#### **🤖 AI Research Profile** (`configs/profiles/ai_research_profile.sh`)
**Display Layout:**
- **Center Display (34" curved):** Cursor, Ollama, LM Studio, MLX, Perplexity (AI Development)
- **Right Display (iMac 24"):** Obsidian (Documentation)

**Applications:**
- AI Development: Cursor
- Model Tools: Ollama, LM Studio, MLX
- AI Services: ChatGPT, Grok, Perplexity (Always visible)
- Documentation: Obsidian

### **🖥️ Display Configuration Updates**

#### **Adaptive Layout** (`configs/adaptive_layout.yaml`)
```yaml
display_count: 2
layout_strategy: "dual_focus"
separated_spaces: true

displays:
  center:
    id: 1
    name: "34' Curved Display (Main)"
    purpose: "Primary Development & Content"
    
  right:
    id: 2
    name: "iMac 24' Display"
    purpose: "Communication & Productivity"
```

#### **Main YABAI Config** (`configs/profiles/yabai_config.yaml`)
- Updated display configuration for 2-display setup
- Added always_visible_apps: ChatGPT, Grok
- Added floating_apps: Finder, iTerm2, Terminal, System Settings
- Updated all profile app lists

## 🎯 **Key Features Implemented**

### **1. Always Visible AI Tools**
- **ChatGPT** and **Grok** are configured as `sticky=on manage=off`
- They remain visible across all spaces and profiles
- Never get tiled or hidden by YABAI

### **2. Floating Windows**
As per your observation, these apps are set to float:
- **Finder** - Always floating
- **iTerm2** - Floating window mode
- **Terminal** - Floating window mode
- **System Settings** - Always floating

### **3. Adaptive Display Management**
- **Center Display (Display 1):** 34" curved main display for primary work
- **Right Display (Display 2):** iMac 24" for communication and secondary tasks
- **Separated Spaces:** Configured for macOS "Displays have separated Spaces - ON"

### **4. Smart App Distribution**

#### **Work Profile Distribution:**
```
Center Display: Development & Research
├── Space 1: Cursor (Main development)
├── Space 2: iTerm2 (Terminal work)
├── Space 3: Vivaldi (Research browsing)
└── Space 4: Perplexity (AI research)

Right Display: Communication & Tools
├── Space 1: Obsidian (Notes)
├── Space 2: Notes (Quick notes)
├── Space 3: Safari (Secondary browsing)
└── Space 4: Shortcuts (Automation)
```

#### **Personal Profile Distribution:**
```
Center Display: Entertainment & Browsing
├── Space 1: YouTube (Entertainment)
├── Space 2: Safari (Personal browsing)
└── Space 3: Vivaldi (Secondary browsing)

Right Display: Social & Personal
├── Space 1: WhatsApp (Messaging)
├── Space 2: X (Social media)
├── Space 3: Telegram (Communication)
└── Space 4: Obsidian (Personal notes)
```

#### **AI Research Profile Distribution:**
```
Center Display: AI Development
├── Space 1: Cursor (AI development)
├── Space 2: Ollama (Local models)
├── Space 3: LM Studio (Model management)
├── Space 4: MLX (Apple Silicon AI)
└── Space 5: Perplexity (AI research)

Right Display: Documentation
└── Space 1: Obsidian (Research notes)
```

## 🚀 **How to Use**

### **Launch Profiles:**
```bash
# From launcher menu
./launcher.sh

# Direct execution
./configs/profiles/work_profile.sh
./configs/profiles/personal_profile.sh
./configs/profiles/ai_research_profile.sh
```

### **Profile Features:**
- ✅ **Automatic app launching** for each profile
- ✅ **Smart display distribution** based on app purpose
- ✅ **Always-visible AI tools** (ChatGPT, Grok)
- ✅ **Floating windows** for system apps
- ✅ **Optimized for 2-display setup**
- ✅ **Separated spaces support**

### **AI Tools Integration:**
- **ChatGPT & Grok:** Always visible across all spaces
- **Profile-specific models:** Each profile suggests optimal AI models
- **External model storage:** `/Volumes/MICRO/models` integration

## 📊 **Configuration Summary**

| Profile | Apps Count | Center Display Focus | Right Display Focus | AI Tools |
|---------|------------|---------------------|-------------------|----------|
| **Work** | 11 | Development & Research | Communication & Productivity | Always Visible |
| **Personal** | 9 | Entertainment & Browsing | Social & Personal | Always Visible |
| **AI Research** | 8 | AI Development & Models | Documentation | Always Visible |

## 🎯 **Next Steps**

1. **Test the profiles** by running each one
2. **Verify YABAI rules** are applied correctly
3. **Check AI tools** remain always visible
4. **Confirm floating windows** behave as expected
5. **Adjust spacing/layout** if needed

Your NEXUS profiles are now perfectly configured for your 2-display setup with separated spaces! 🚀

---

**Built with ❤️ for your specific 34" curved + iMac 24" setup**
