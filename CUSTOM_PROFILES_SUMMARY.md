# 🚀 **NEXUS Custom Workspace Profiles**

**Created:** August 9, 2025  
**Based on:** Your actual installed applications  
**Total Profiles:** 8 (3 original + 5 new)

---

## 📋 **Original Profiles (Updated)**

### **1. 💼 Work Profile** 
- **Apps:** Cursor, iTerm, Shortcuts, Obsidian, Notes, Vivaldi, Perplexity, Safari, ChatGPT, Grok
- **Focus:** Development & productivity

### **2. 🏠 Personal Profile**
- **Apps:** WhatsApp, X, Telegram, YouTube, Obsidian, Safari, Vivaldi, ChatGPT, Grok  
- **Focus:** Social & entertainment

### **3. 🤖 AI Research Profile**
- **Apps:** Cursor, Ollama, LM Studio, MLX, ChatGPT, Grok, Perplexity, Obsidian
- **Focus:** AI development & models

---

## 🎯 **New Custom Profiles**

### **4. 🎨 Content Creation Profile**
**Purpose:** Video editing, design, writing
**Your Apps Used:**
- ✅ **Wondershare Filmora Mac** (Video editing)
- ✅ **PhotoScapeX** (Photo editing)
- ✅ **Pages** (Writing & documents)
- ✅ **Numbers** (Planning spreadsheets)
- ✅ **Obsidian** (Creative notes)
- ✅ **Notes** (Quick ideas)
- ✅ **YouTube** (Tutorial videos)
- ✅ **ChatGPT + Grok** (AI creative assistance)
- ✅ **Perplexity** (Research)

**Layout:**
- **Center Display:** Filmora, PhotoScapeX, Pages, Numbers
- **Right Display:** Obsidian, Notes, YouTube, Safari

---

### **5. 🎮 Gaming & Entertainment Profile**
**Purpose:** Gaming, performance monitoring, entertainment
**Your Apps Used:**
- ✅ **Chrome/Safari** (Web-based gaming platforms)
- ✅ **iStatistica Pro** (System monitoring)
- ✅ **iStatistica Sensors** (Thermal monitoring)
- ✅ **CleanMyMac 5** (Performance optimization)
- ✅ **ActivityWatch** (Usage tracking)
- ✅ **YouTube** (Gaming videos)
- ✅ **Music** (Gaming audio)
- ✅ **Boom 3D** (Audio enhancement)
- ✅ **Vivaldi** (Gaming research)

**Layout:**
- **Center Display:** Gaming platforms, system monitors
- **Right Display:** YouTube, communication, guides

---

### **6. 📚 Learning & Education Profile**
**Purpose:** Online courses, skill development, research
**Your Apps Used:**
- ✅ **Safari/Chrome** (Learning platforms: Coursera, Udemy, Khan Academy)
- ✅ **YouTube** (Educational videos)
- ✅ **Obsidian** (Knowledge management)
- ✅ **Notes** (Quick learning notes)
- ✅ **Cursor** (Code practice)
- ✅ **iTerm** (Terminal learning)
- ✅ **ChatGPT** (Learning assistant)
- ✅ **Perplexity** (Research help)

**Layout:**
- **Center Display:** Learning platforms, practice environments
- **Right Display:** Notes, research, AI assistance

---

### **7. 💼 Business & Meetings Profile**
**Purpose:** Business work, meetings, administration
**Your Apps Used:**
- ✅ **Microsoft Excel** (Spreadsheets)
- ✅ **Pages** (Documents)
- ✅ **Numbers** (Apple spreadsheets)
- ✅ **Mail** (Email management)
- ✅ **WhatsApp** (Business messaging)
- ✅ **FaceTime** (Video calls)
- ✅ **Safari/Chrome** (Web apps: Teams, Zoom via browser)
- ✅ **ChatGPT** (Business writing assistance)

**Layout:**
- **Center Display:** Documents, spreadsheets, presentations
- **Right Display:** Email, calendar, communication

---

### **8. 🎯 Focus & Deep Work Profile**
**Purpose:** Distraction-free environment, deep concentration
**Your Apps Used:**
- ✅ **Obsidian** (Deep thinking & writing)
- ✅ **Pages** (Long-form writing)
- ✅ **Cursor** (Focused coding)
- ✅ **One Thing** (Single task focus) - Perfect for this!
- ✅ **ActivityWatch** (Focus time tracking)
- ✅ **Caffeine** (Keep system awake)
- ✅ **Music** (Focus audio)
- ✅ **Boom 3D** (Audio enhancement)
- ✅ **ChatGPT** (Minimal AI assistance)

**Special Features:**
- 🚫 **Blocks distracting apps** (social media, entertainment)
- 🔕 **Enables Do Not Disturb mode**
- ⏰ **Minimal interface** for maximum concentration
- 🎵 **Ambient audio** for focus enhancement

**Layout:**
- **Center Display:** Main focus work (Obsidian, Pages, Cursor)
- **Right Display:** Minimal support tools

---

## 🎛️ **How to Use Your New Profiles**

### **Launch from NEXUS Menu:**
```bash
./launcher.sh
```
Then select:
- **18)** 🎨 Content Creation
- **19)** 🎮 Gaming & Entertainment  
- **20)** 📚 Learning & Education
- **21)** 💼 Business & Meetings
- **22)** 🎯 Focus & Deep Work

### **Direct Launch:**
```bash
# Content Creation
source configs/profiles/content_creation_profile.sh

# Gaming
source configs/profiles/gaming_profile.sh

# Learning  
source configs/profiles/learning_profile.sh

# Business
source configs/profiles/business_profile.sh

# Focus
source configs/profiles/focus_profile.sh
```

---

## 🔧 **Profile Customization**

### **Adding Apps:**
1. Edit the profile script: `configs/profiles/[profile_name].sh`
2. Add: `open -na "/Applications/YourApp.app"`
3. Update YABAI rules for display/space assignment

### **Modifying Layout:**
Update the YABAI rules section:
```bash
# Center Display (Display 1)
yabai -m rule --add app="YourApp" display=1 space=1

# Right Display (Display 2)  
yabai -m rule --add app="YourApp" display=2 space=1
```

### **App-Specific Rules:**
- **Floating:** `manage=off`
- **Sticky:** `sticky=on manage=off`
- **Specific space:** `display=1 space=2`

---

## 💡 **Profile Suggestions Based on Your Apps**

### **Potential Additional Profiles:**

**🛡️ Security & Privacy Profile:**
- Tor Browser, NordVPN, CleanMyMac, Secure Private Browser

**📊 Data & Analytics Profile:** 
- Numbers, Excel, ActivityWatch, iStatistica Pro

**🎵 Media & Audio Profile:**
- Music, Boom 3D, Wondershare Filmora, PhotoScapeX

**🔧 Development Tools Profile:**
- Cursor, Visual Studio Code, iTerm, GitHub Copilot, Xcode-beta

---

## 🎉 **Your NEXUS System is Now Complete!**

You now have **8 specialized workspace profiles** perfectly tailored to your actual installed applications and workflow needs. Each profile:

- ✅ **Uses only apps you actually have**
- ✅ **Optimized for your 2-display setup**
- ✅ **Includes AI assistance (ChatGPT, Grok, Perplexity)**
- ✅ **Smart YABAI window management**
- ✅ **Context-appropriate app selection**

**Ready for real-world productivity!** 🚀
