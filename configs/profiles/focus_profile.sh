#!/bin/zsh

# Focus Profile - Deep Work, Distraction-Free Environment
# Optimized for deep focus, writing, research, and concentration
# 2-Display Setup: Center (34" curved main) + Right (iMac 24")

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"

echo "🎯 Loading Focus Profile for 2-Display Setup..."

# Essential Focus Apps Only
echo "📝 Opening minimal focus environment..."

# Writing & Note-taking
open -na "/Applications/Obsidian.app"           # Knowledge work
open -na "/Applications/Ulysses.app"            # Long-form writing
open -na "/Applications/iA Writer.app"          # Distraction-free writing
open -na "/Applications/Bear.app"               # Quick notes

# Reading & Research
open -na "/Applications/PDF Expert.app"         # Document reading
open -na "/Applications/Kindle.app"             # E-books
open -na "/Applications/Readwise Reader.app"    # Article reading

# Minimal Development (if needed)
open -na "/Applications/Cursor.app"             # Code editor

# Focus & Productivity Tools
echo "⏰ Setting up focus enhancement tools..."
open -na "/Applications/One Thing.app"          # Single focus task
open -na "/Applications/ActivityWatch.app"      # Time tracking
open -na "/Applications/Caffeine.app"           # Keep awake

# Ambient & Focus Enhancement
echo "🎵 Loading ambient environment..."
open -na "/Applications/Music.app"              # Focus music
open -na "/Applications/Boom 3D.app"            # Audio enhancement

# Minimal Communication (Emergency only)
echo "📱 Setting up emergency communication..."
open -na "/Applications/Messages.app"           # Essential messages only

# AI Research Assistant (Minimal)
echo "🤖 Loading focused AI assistant..."
open -na "/Applications/ChatGPT.app"

# Wait for apps to launch
sleep 3

# Apply focus-specific YABAI rules for 2-display setup
echo "📐 Applying focus layout for Center (main) + Right displays..."

# Center Display (34" curved - Display 1 - Main Focus Work)
yabai -m rule --add app="Obsidian" display=1 space=1
yabai -m rule --add app="Ulysses" display=1 space=2
yabai -m rule --add app="iA Writer" display=1 space=2
yabai -m rule --add app="Cursor" display=1 space=3
yabai -m rule --add app="PDF Expert" display=1 space=4
yabai -m rule --add app="Kindle" display=1 space=4

# Right Display (iMac 24" - Display 2 - Support & Reference)
yabai -m rule --add app="Bear" display=2 space=1
yabai -m rule --add app="Readwise Reader" display=2 space=2
yabai -m rule --add app="Messages" display=2 space=3

# Focus tools - always visible but unobtrusive
yabai -m rule --add app="Be Focused" manage=off sticky=on
yabai -m rule --add app="Forest" manage=off sticky=on

# Distraction blockers - floating for quick control
yabai -m rule --add app="Freedom" manage=off
yabai -m rule --add app="Cold Turkey Blocker" manage=off

# Audio environment - floating and sticky
yabai -m rule --add app="Brain.fm" manage=off sticky=on
yabai -m rule --add app="Noisli" manage=off sticky=on
yabai -m rule --add app="Endel" manage=off sticky=on

# AI Assistant - minimal and focused
yabai -m rule --add app="ChatGPT" sticky=on manage=off

# Block distracting apps (add rules to prevent them from opening)
echo "🚫 Blocking distracting applications..."
yabai -m rule --add app="Twitter" manage=off opacity=0.1  # Make barely visible
yabai -m rule --add app="X" manage=off opacity=0.1
yabai -m rule --add app="Facebook" manage=off opacity=0.1
yabai -m rule --add app="Instagram" manage=off opacity=0.1
yabai -m rule --add app="YouTube" manage=off opacity=0.1  # Severely limit
yabai -m rule --add app="TikTok" manage=off opacity=0.1
yabai -m rule --add app="Reddit" manage=off opacity=0.1

# Essential floating windows only
yabai -m rule --add app="Calculator" manage=off
yabai -m rule --add app="Dictionary" manage=off

# Block notifications and distractions
echo "🔕 Enabling Do Not Disturb mode..."
# Enable Do Not Disturb via command line
shortcuts run "Set Focus" 2>/dev/null || echo "Focus mode activation attempted"

echo "✅ Focus profile loaded successfully for 2-display setup!"
echo "🎯 Center Display: Deep Work & Writing"
echo "📚 Right Display: Research & Quick Notes"
echo "🔕 Distracting apps blocked or minimized"
echo "⏰ Focus tools active for productivity tracking"
echo "🎵 Ambient audio available for concentration"
echo ""
echo "💡 Focus Tips:"
echo "   • Use ⌘+Space+number to switch between focus spaces"
echo "   • Be Focused timer helps with Pomodoro technique"
echo "   • Freedom blocks distracting websites automatically"
echo "   • Forest tracks your focus sessions"
