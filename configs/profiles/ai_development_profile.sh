#!/bin/zsh

# AI Development Profile - AI Application Development & Model Training
# Optimized for coding AI applications, model training, and development workflows
# 2-Display Setup: Center (34" curved main) + Right (iMac 24")

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"

echo "🚀 Loading AI Development Profile for 2-Display Setup..."

# AI Development Tools
echo "🔧 Setting up AI development environment..."
open -na "/Applications/Cursor.app"                    # AI-powered code editor
open -na "/Applications/Visual Studio Code.app"        # Alternative code editor
open -na "/Applications/PyCharm.app"                   # Python IDE for ML
open -na "/Applications/Jupyter.app"                   # Jupyter notebooks

# Model Development & Training
echo "🤖 Setting up AI model development tools..."
open -na "/Applications/Ollama.app"                    # Local model management
open -na "/Applications/LM Studio.app"                 # Model fine-tuning
open -na "/Applications/MLX.app"                       # Apple ML framework
open -na "/Applications/Comet.app"                     # ML experiment tracking

# Development Utilities
echo "⚙️ Setting up development utilities..."
open -na "/Applications/iTerm.app"                     # Terminal for CLI tools
open -na "/Applications/Postman.app"                   # API testing
open -na "/Applications/Docker.app"                    # Containerization
open -na "/Applications/GitHub Desktop.app"            # Version control

# AI Research & Documentation
echo "📚 Setting up research tools..."
open -na "/Applications/Obsidian.app"                  # Knowledge management
open -na "/Applications/ChatGPT.app"                   # AI coding assistant
open -na "/Applications/Grok.app"                      # Alternative AI assistant
open -na "/Applications/Perplexity- Ask Anything.app"  # Research assistant

# Wait for apps to launch
sleep 4

# Apply AI development-specific YABAI rules for 2-display setup
echo "📐 Applying AI development layout for Center (main) + Right displays..."

# Center Display (34" curved - Display 1 - Main Development)
yabai -m rule --add app="Cursor" display=1 space=1
yabai -m rule --add app="Visual Studio Code" display=1 space=2
yabai -m rule --add app="PyCharm" display=1 space=3
yabai -m rule --add app="Jupyter" display=1 space=4

# Right Display (iMac 24" - Display 2 - AI Tools & Documentation)
yabai -m rule --add app="Ollama" display=2 space=1
yabai -m rule --add app="LM Studio" display=2 space=2
yabai -m rule --add app="MLX" display=2 space=3
yabai -m rule --add app="Obsidian" display=2 space=4

# AI Tools - Always visible (sticky across spaces)
yabai -m rule --add app="ChatGPT" sticky=on manage=off
yabai -m rule --add app="Grok" sticky=on manage=off
yabai -m rule --add app="Perplexity- Ask Anything" sticky=on manage=off

# Development utilities - floating for quick access
yabai -m rule --add app="iTerm2" manage=off
yabai -m rule --add app="Terminal" manage=off
yabai -m rule --add app="Docker" manage=off
yabai -m rule --add app="GitHub Desktop" manage=off

# Floating Windows (as per user preference)
yabai -m rule --add app="Finder" manage=off
yabai -m rule --add app="System Settings" manage=off
yabai -m rule --add app="Activity Monitor" manage=off

echo "✅ AI Development profile loaded successfully for 2-display setup!"
echo "🚀 Center Display: Code Development & IDEs"
echo "🤖 Right Display: AI Models & Documentation"
echo "🔧 Development tools float for quick access"
echo "📚 AI assistants always visible across spaces"

# Check for development environment
if [ -d "/Volumes/MICRO/models" ]; then
    echo "📁 External model storage detected at /Volumes/MICRO/models"
    echo "🔗 Ready for model training and development"
fi

if [ -d "$HOME/.conda" ] || [ -d "$HOME/anaconda3" ]; then
    echo "🐍 Conda environment detected - ready for ML development"
fi

if [ -d "$HOME/.local/share/ollama" ]; then
    echo "🦙 Ollama models available for local development"
fi

