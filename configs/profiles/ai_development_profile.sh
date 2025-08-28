#!/bin/zsh

# AI Development Profile - Enhanced for LM Studio Integration
# Optimized for AI development, model testing, and workspace optimization
# 2-Display Setup: Center (34" curved main) + Right (iMac 24")
# LM Studio Models: /Volumes/MICRO/LM_STUDIO_MODELS

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_DIR="$(dirname "$(dirname "$SCRIPT_DIR")")"

echo "🤖 Loading Enhanced AI Development Profile for 2-Display Setup..."
echo "🧠 LM Studio Integration: /Volumes/MICRO/LM_STUDIO_MODELS"

# AI Development Tools
open -na "/Applications/Cursor.app"
open -na "/Applications/iTerm.app"

# AI Model Management
open -na "/Applications/LM Studio.app"
open -na "/Applications/Ollama.app"
open -na "/Applications/MLX.app"

# AI Research & Development Tools
open -na "/Applications/ChatGPT.app"
open -na "/Applications/Grok.app"
open -na "/Applications/Perplexity- Ask Anything.app"

# Documentation & Project Management
open -na "/Applications/Obsidian.app"
open -na "/Applications/Notes.app"

# Development & Version Control
open -na "/Applications/GitHub Desktop.app"
open -na "/Applications/Xcode.app"

# Wait for apps to launch
sleep 3

# Apply AI development-specific YABAI rules for 2-display setup
echo "📐 Applying AI development layout for Center (main) + Right displays..."

# Center Display (34" curved - Display 1 - AI Development & Models)
yabai -m rule --add app="Cursor" display=1 space=1
yabai -m rule --add app="iTerm2" display=1 space=2
yabai -m rule --add app="LM Studio" display=1 space=3
yabai -m rule --add app="Ollama" display=1 space=4
yabai -m rule --add app="MLX" display=1 space=5

# Right Display (iMac 24" - Display 2 - Documentation & Tools)
yabai -m rule --add app="Obsidian" display=2 space=1
yabai -m rule --add app="Notes" display=2 space=2
yabai -m rule --add app="GitHub Desktop" display=2 space=3
yabai -m rule --add app="Xcode" display=2 space=4

# AI Tools - Always visible (sticky across spaces)
yabai -m rule --add app="ChatGPT" sticky=on manage=off
yabai -m rule --add app="Grok" sticky=on manage=off
yabai -m rule --add app="Perplexity- Ask Anything" sticky=on manage=off

# Floating Windows (as per user preference)
yabai -m rule --add app="Finder" manage=off
yabai -m rule --add app="Terminal" manage=off
yabai -m rule --add app="System Settings" manage=off

# Check LM Studio model availability
echo "🔍 Checking LM Studio model availability..."

if [ -d "/Volumes/MICRO/LM_STUDIO_MODELS" ]; then
    echo "✅ LM Studio models found at /Volumes/MICRO/LM_STUDIO_MODELS"
    
    # Count available models
    MODEL_COUNT=$(find "/Volumes/MICRO/LM_STUDIO_MODELS" -name "*.gguf" -o -name "*.mlx" | wc -l | tr -d ' ')
    echo "📊 Available models: $MODEL_COUNT"
    
    # Check if LM Studio server is running
    if curl -s http://localhost:1234/v1/models > /dev/null 2>&1; then
        echo "🚀 LM Studio server is running on localhost:1234"
        echo "🤖 Ready for AI-powered workspace optimization"
    else
        echo "⚠️  LM Studio server not running - start LM Studio to enable AI features"
    fi
else
    echo "⚠️  LM Studio models not found at /Volumes/MICRO/LM_STUDIO_MODELS"
    echo "💡 Mount your external drive or check the path"
fi

# Set up NEXUS AI optimization
echo "🧠 Setting up NEXUS AI optimization..."

# Check if NEXUS is available
if command -v nexus-ai-optimize > /dev/null; then
    echo "✅ NEXUS AI optimization available"
    echo "💡 Run 'nexus-ai-optimize --profile ai_development' for workspace optimization"
else
    echo "⚠️  NEXUS not found in PATH - add bin/ directory to PATH"
fi

# Profile-specific environment variables
export NEXUS_CURRENT_PROFILE="ai_development"
export NEXUS_AI_ENABLED="true"
export NEXUS_LM_STUDIO_ENDPOINT="http://localhost:1234"

echo "✅ Enhanced AI Development profile loaded successfully!"
echo "📱 Center Display: AI Development & Model Management"
echo "🖥️ Right Display: Documentation & Development Tools"
echo "🤖 AI Tools: Always visible across all spaces"
echo "🧠 LM Studio: Integrated with $MODEL_COUNT models"
echo "🚀 NEXUS: AI optimization ready"

# Display quick commands
echo ""
echo "💡 Quick Commands:"
echo "  • nexus-ai-optimize --profile ai_development"
echo "  • nexus-profile-switcher --switch ai_development"
echo "  • nexus-quick-menu"
echo "  • nexus status"

