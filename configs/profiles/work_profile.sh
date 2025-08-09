#!/bin/zsh

# Work Profile - Development & Productivity Focus
# Optimized for coding, development, and professional work
# 2-Display Setup: Center (34" curved main) + Right (iMac 24")

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"

echo "💼 Loading Work Profile for 2-Display Setup..."

# Development Tools
open -na "/Applications/Cursor.app"
open -na "/Applications/iTerm.app"
open -na "/Applications/Shortcuts.app"

# Communication & Productivity
open -na "/Applications/Obsidian.app"
open -na "/Applications/Notes.app"

# Browsers & Research Tools
open -na "/Applications/Vivaldi.app"
open -na "/Applications/Perplexity- Ask Anything.app"
open -na "/Applications/Safari.app"

# AI Tools for Development (Always on screen)
open -na "/Applications/ChatGPT.app"
open -na "/Applications/Grok.app"
open -na "/Applications/GitHub Copilot.app"

# Wait for apps to launch
sleep 3

# Apply work-specific YABAI rules for 2-display setup
echo "📐 Applying work layout for Center (main) + Right displays..."

# Center Display (34" curved - Display 1 - Main Development)
yabai -m rule --add app="Cursor" display=1 space=1
yabai -m rule --add app="iTerm2" display=1 space=2
yabai -m rule --add app="Vivaldi" display=1 space=3
yabai -m rule --add app="Perplexity- Ask Anything" display=1 space=4

# Right Display (iMac 24" - Display 2 - Communication & Tools)
yabai -m rule --add app="Obsidian" display=2 space=1
yabai -m rule --add app="Notes" display=2 space=2
yabai -m rule --add app="Safari" display=2 space=3
yabai -m rule --add app="Shortcuts" display=2 space=4

# AI Tools - Always visible (sticky across spaces)
yabai -m rule --add app="ChatGPT" sticky=on manage=off
yabai -m rule --add app="Grok" sticky=on manage=off

# Floating Windows (as per user preference)
yabai -m rule --add app="Finder" manage=off
yabai -m rule --add app="iTerm2" manage=off
yabai -m rule --add app="Terminal" manage=off
yabai -m rule --add app="System Settings" manage=off

echo "✅ Work profile loaded successfully for 2-display setup!"
echo "📱 Center Display: Development & Research"
echo "🖥️ Right Display: Communication & Productivity"
echo "🤖 AI Tools: Always visible across all spaces" 