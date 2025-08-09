#!/bin/zsh

# Content Creation Profile - Video, Writing, Design
# Optimized for content creation, video editing, design work
# 2-Display Setup: Center (34" curved main) + Right (iMac 24")

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"

echo "🎨 Loading Content Creation Profile for 2-Display Setup..."

# Content Creation Apps
echo "📹 Launching content creation tools..."
open -na "/Applications/Wondershare Filmora Mac.app"  # Video editing
open -na "/Applications/PhotoScapeX.app"              # Photo editing
open -na "/Applications/Pages.app"                    # Writing & documents
open -na "/Applications/Numbers.app"                  # Spreadsheets for planning

# Writing & Planning
echo "✍️ Setting up writing environment..."
open -na "/Applications/Obsidian.app"           # Note-taking
open -na "/Applications/Notes.app"              # Quick notes

# Reference & Research
echo "🔍 Opening reference materials..."
open -na "/Applications/Safari.app"             # Web research
open -na "/Applications/Google Chrome.app"      # Alternative browser
open -na "/Users/eduardof.giovannini/Applications/YouTube.app" # Tutorial videos

# AI Creative Tools
echo "🤖 Loading AI creative assistants..."
open -na "/Applications/ChatGPT.app"
open -na "/Users/eduardof.giovannini/Applications/Grok.app"
open -na "/Applications/Perplexity.app"         # AI research

# Wait for apps to launch
sleep 5

# Apply content creation YABAI rules for 2-display setup
echo "📐 Applying content creation layout for Center (main) + Right displays..."

# Center Display (34" curved - Display 1 - Main Creation Tools)
yabai -m rule --add app="Final Cut Pro" display=1 space=1
yabai -m rule --add app="DaVinci Resolve" display=1 space=1
yabai -m rule --add app="Photoshop" display=1 space=2
yabai -m rule --add app="After Effects" display=1 space=2
yabai -m rule --add app="Logic Pro" display=1 space=3
yabai -m rule --add app="Illustrator" display=1 space=3
yabai -m rule --add app="Sketch" display=1 space=4
yabai -m rule --add app="Figma" display=1 space=4

# Right Display (iMac 24" - Display 2 - Planning & Reference)
yabai -m rule --add app="Obsidian" display=2 space=1
yabai -m rule --add app="Notion" display=2 space=1
yabai -m rule --add app="Ulysses" display=2 space=2
yabai -m rule --add app="MindNode" display=2 space=2
yabai -m rule --add app="Safari" display=2 space=3
yabai -m rule --add app="Pinterest" display=2 space=3
yabai -m rule --add app="YouTube" display=2 space=4

# AI Tools - Always visible (sticky across spaces)
yabai -m rule --add app="ChatGPT" sticky=on manage=off
yabai -m rule --add app="Grok" sticky=on manage=off
yabai -m rule --add app="Midjourney" sticky=on manage=off

# Floating Windows for quick access
yabai -m rule --add app="Finder" manage=off
yabai -m rule --add app="Color UI" manage=off           # Color picker
yabai -m rule --add app="Digital Color Meter" manage=off
yabai -m rule --add app="Screenshot Path" manage=off

echo "✅ Content Creation profile loaded successfully for 2-display setup!"
echo "🎨 Center Display: Creative Tools & Production"
echo "📝 Right Display: Planning, Research & Reference"
echo "💡 AI assistants are floating for inspiration on demand"
