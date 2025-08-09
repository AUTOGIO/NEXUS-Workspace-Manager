#!/bin/zsh

# AI Research Profile - AI Development & Model Management
# Optimized for AI research, model development, and ML workflows
# 2-Display Setup: Center (34" curved main) + Right (iMac 24")

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"

echo "🤖 Loading AI Research Profile for 2-Display Setup..."

# AI Development Tools
open -na "/Applications/Cursor.app"

# Model Management Tools
open -na "/Applications/Ollama.app"
open -na "/Applications/LM Studio.app"
open -na "/Applications/MLX.app"

# AI Research Tools (Always on screen)
open -na "/Applications/ChatGPT.app"
open -na "/Applications/Grok.app"
open -na "/Applications/Perplexity- Ask Anything.app"

# Documentation & Notes
open -na "/Applications/Obsidian.app"

# Wait for apps to launch
sleep 3

# Apply AI research-specific YABAI rules for 2-display setup
echo "📐 Applying AI research layout for Center (main) + Right displays..."

# Center Display (34" curved - Display 1 - AI Development & Models)
yabai -m rule --add app="Cursor" display=1 space=1
yabai -m rule --add app="Ollama" display=1 space=2
yabai -m rule --add app="LM Studio" display=1 space=3
yabai -m rule --add app="MLX" display=1 space=4
yabai -m rule --add app="Perplexity- Ask Anything" display=1 space=5

# Right Display (iMac 24" - Display 2 - Documentation & Notes)
yabai -m rule --add app="Obsidian" display=2 space=1

# AI Tools - Always visible (sticky across spaces)
yabai -m rule --add app="ChatGPT" sticky=on manage=off
yabai -m rule --add app="Grok" sticky=on manage=off

# Floating Windows (as per user preference)
yabai -m rule --add app="Finder" manage=off
yabai -m rule --add app="iTerm2" manage=off
yabai -m rule --add app="Terminal" manage=off
yabai -m rule --add app="System Settings" manage=off

echo "✅ AI Research profile loaded successfully for 2-display setup!"
echo "📱 Center Display: AI Development & Model Management"
echo "🖥️ Right Display: Documentation & Research Notes"
echo "🤖 AI Tools: Always visible across all spaces"

# Check for external model storage
if [ -d "/Volumes/MICRO/models" ]; then
    echo "📁 External model storage detected at /Volumes/MICRO/models"
    echo "🔗 Ready to integrate with your model collection"
else
    echo "⚠️  External model storage not found at /Volumes/MICRO/models"
fi 