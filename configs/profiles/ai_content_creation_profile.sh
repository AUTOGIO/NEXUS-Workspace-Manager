#!/bin/zsh

# AI Content Creation Profile - AI-Assisted Content Creation & Creative Workflows
# Optimized for AI-powered writing, content creation, and creative projects
# 2-Display Setup: Center (34" curved main) + Right (iMac 24")

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"

echo "🎨 Loading AI Content Creation Profile for 2-Display Setup..."

# AI Writing & Content Tools
echo "✍️ Setting up AI writing environment..."
open -na "/Applications/Cursor.app"                    # AI-powered code/writing editor
open -na "/Applications/Notion.app"                    # AI-powered workspace
open -na "/Applications/Roam Research.app"             # AI-enhanced note-taking
open -na "/Applications/Logseq.app"                    # AI-powered knowledge graph

# Creative AI Tools
echo "🎭 Setting up creative AI tools..."
open -na "/Applications/Midjourney.app"                 # AI image generation
open -na "/Applications/DALL-E.app"                     # Alternative AI art
open -na "/Applications/Stable Diffusion.app"           # Local AI art generation
open -na "/Applications/RunwayML.app"                   # AI video editing

# Content Creation Apps
echo "📝 Setting up content creation apps..."
open -na "/Applications/Pages.app"                      # Document creation
open -na "/Applications/Keynote.app"                    # Presentation design
open -na "/Applications/Canva.app"                      # Graphic design
open -na "/Applications/Figma.app"                      # Design collaboration

# AI Research & Inspiration
echo "🔍 Setting up AI research tools..."
open -na "/Applications/ChatGPT.app"                    # AI writing assistant
open -na "/Applications/Grok.app"                       # Alternative AI assistant
open -na "/Applications/Perplexity- Ask Anything.app"   # Research assistant
open -na "/Applications/Claude.app"                     # Anthropic AI assistant

# Content Management
echo "📚 Setting up content management..."
open -na "/Applications/Obsidian.app"                   # Knowledge management
open -na "/Applications/Notion.app"                     # Project management
open -na "/Applications/Trello.app"                     # Task organization
open -na "/Applications/Asana.app"                      # Team collaboration

# Wait for apps to launch
sleep 4

# Apply AI content creation-specific YABAI rules for 2-display setup
echo "📐 Applying AI content creation layout for Center (main) + Right displays..."

# Center Display (34" curved - Display 1 - Main Creation)
yabai -m rule --add app="Cursor" display=1 space=1
yabai -m rule --add app="Pages" display=1 space=2
yabai -m rule --add app="Keynote" display=1 space=3
yabai -m rule --add app="Canva" display=1 space=4

# Right Display (iMac 24" - Display 2 - AI Tools & Research)
yabai -m rule --add app="ChatGPT" display=2 space=1
yabai -m rule --add app="Grok" display=2 space=2
yabai -m rule --add app="Perplexity- Ask Anything" display=2 space=3
yabai -m rule --add app="Obsidian" display=2 space=4

# AI Tools - Always visible (sticky across spaces)
yabai -m rule --add app="ChatGPT" sticky=on manage=off
yabai -m rule --add app="Grok" sticky=on manage=off
yabai -m rule --add app="Perplexity- Ask Anything" sticky=on manage=off
yabai -m rule --add app="Claude" sticky=on manage=off

# Creative tools - floating for quick access
yabai -m rule --add app="Midjourney" manage=off
yabai -m rule --add app="DALL-E" manage=off
yabai -m rule --add app="Stable Diffusion" manage=off
yabai -m rule --add app="RunwayML" manage=off

# Floating Windows (as per user preference)
yabai -m rule --add app="Finder" manage=off
yabai -m rule --add app="System Settings" manage=off
yabai -m rule --add app="Activity Monitor" manage=off

echo "✅ AI Content Creation profile loaded successfully for 2-display setup!"
echo "🎨 Center Display: Content Creation & Design Tools"
echo "🤖 Right Display: AI Assistants & Research"
echo "🎭 Creative AI tools float for quick access"
echo "✍️ AI writing assistants always visible across spaces"

# Check for AI content creation tools
if [ -d "/Applications/Midjourney.app" ]; then
    echo "🎨 Midjourney available for AI art generation"
fi

if [ -d "/Applications/Stable Diffusion.app" ]; then
    echo "🖼️ Stable Diffusion available for local AI art"
fi

if [ -d "/Applications/RunwayML.app" ]; then
    echo "🎬 RunwayML available for AI video editing"
fi

echo "💡 Tip: Use AI assistants for brainstorming, writing assistance, and creative inspiration!"

