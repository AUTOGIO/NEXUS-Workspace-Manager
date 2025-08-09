#!/bin/zsh

# Personal Profile - Entertainment & Social Focus
# Optimized for social media, entertainment, and personal tasks
# 2-Display Setup: Center (34" curved main) + Right (iMac 24")

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"

echo "🏠 Loading Personal Profile for 2-Display Setup..."

# Social Media & Communication
open -na "/Applications/WhatsApp.app"
open -na "/Applications/X.app"
open -na "/Applications/Telegram.app"

# Entertainment
open -na "/Applications/YouTube.app"

# Personal Productivity
open -na "/Applications/Obsidian.app"

# Browsers for Personal Use
open -na "/Applications/Safari.app"
open -na "/Applications/Vivaldi.app"

# AI Tools (Always on screen)
open -na "/Applications/ChatGPT.app"
open -na "/Applications/Grok.app"

# Wait for apps to launch
sleep 3

# Apply personal-specific YABAI rules for 2-display setup
echo "📐 Applying personal layout for Center (main) + Right displays..."

# Center Display (34" curved - Display 1 - Main Entertainment & Browsing)
yabai -m rule --add app="YouTube" display=1 space=1
yabai -m rule --add app="Safari" display=1 space=2
yabai -m rule --add app="Vivaldi" display=1 space=3

# Right Display (iMac 24" - Display 2 - Social & Productivity)
yabai -m rule --add app="WhatsApp" display=2 space=1
yabai -m rule --add app="X" display=2 space=2
yabai -m rule --add app="Telegram" display=2 space=3
yabai -m rule --add app="Obsidian" display=2 space=4

# AI Tools - Always visible (sticky across spaces)
yabai -m rule --add app="ChatGPT" sticky=on manage=off
yabai -m rule --add app="Grok" sticky=on manage=off

# Floating Windows (as per user preference)
yabai -m rule --add app="Finder" manage=off
yabai -m rule --add app="iTerm2" manage=off
yabai -m rule --add app="Terminal" manage=off
yabai -m rule --add app="System Settings" manage=off

echo "✅ Personal profile loaded successfully for 2-display setup!"
echo "📱 Center Display: Entertainment & Browsing"
echo "🖥️ Right Display: Social & Personal Productivity"
echo "🤖 AI Tools: Always visible across all spaces" 