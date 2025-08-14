#!/bin/zsh

# AI Learning Profile - AI/ML Education & Learning Workflows
# Optimized for studying AI concepts, online courses, and educational projects
# 2-Display Setup: Center (34" curved main) + Right (iMac 24")

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"

echo "📚 Loading AI Learning Profile for 2-Display Setup..."

# Learning Platforms & Courses
echo "🎓 Setting up learning platforms..."
open -na "/Applications/Safari.app"                     # Web-based learning
open -na "/Applications/Google Chrome.app"              # Alternative browser
open -na "/Applications/Coursera.app"                   # Online courses
open -na "/Applications/Udemy.app"                      # Skill development
open -na "/Applications/edX.app"                        # University courses
open -na "/Applications/Khan Academy.app"               # Free education

# AI Learning Tools
echo "🤖 Setting up AI learning tools..."
open -na "/Applications/ChatGPT.app"                    # AI tutor & explanations
open -na "/Applications/Grok.app"                       # Alternative AI tutor
open -na "/Applications/Perplexity- Ask Anything.app"   # Research & learning
open -na "/Applications/Claude.app"                     # Anthropic AI tutor
open -na "/Applications/Pi.app"                         # Personal AI tutor

# Interactive Learning
echo "🔄 Setting up interactive learning..."
open -na "/Applications/Jupyter.app"                    # Python notebooks
open -na "/Applications/Google Colab.app"               # Cloud notebooks
open -na "/Applications/Replit.app"                     # Online coding
open -na "/Applications/Codecademy.app"                 # Interactive coding

# Note-Taking & Knowledge Management
echo "📝 Setting up knowledge management..."
open -na "/Applications/Obsidian.app"                   # Knowledge graph
open -na "/Applications/Notion.app"                     # Learning notes
open -na "/Applications/OneNote.app"                    # Microsoft notes
open -na "/Applications/Evernote.app"                   # Alternative notes

# Study & Focus Tools
echo "🎯 Setting up study tools..."
open -na "/Applications/Forest.app"                     # Focus timer
open -na "/Applications/Pomodoro Timer.app"             # Time management
open -na "/Applications/RescueTime.app"                 # Productivity tracking
open -na "/Applications/One Thing.app"                  # Single focus task

# Wait for apps to launch
sleep 4

# Apply AI learning-specific YABAI rules for 2-display setup
echo "📐 Applying AI learning layout for Center (main) + Right displays..."

# Center Display (34" curved - Display 1 - Main Learning)
yabai -m rule --add app="Safari" display=1 space=1
yabai -m rule --add app="Google Chrome" display=1 space=2
yabai -m rule --add app="Jupyter" display=1 space=3
yabai -m rule --add app="Google Colab" display=1 space=4

# Right Display (iMac 24" - Display 2 - AI Tools & Notes)
yabai -m rule --add app="ChatGPT" display=2 space=1
yabai -m rule --add app="Grok" display=2 space=2
yabai -m rule --add app="Obsidian" display=2 space=3
yabai -m rule --add app="Notion" display=2 space=4

# AI Tools - Always visible (sticky across spaces)
yabai -m rule --add app="ChatGPT" sticky=on manage=off
yabai -m rule --add app="Grok" sticky=on manage=off
yabai -m rule --add app="Perplexity- Ask Anything" sticky=on manage=off
yabai -m rule --add app="Claude" sticky=on manage=off

# Learning tools - floating for quick access
yabai -m rule --add app="Forest" manage=off
yabai -m rule --add app="Pomodoro Timer" manage=off
yabai -m rule --add app="One Thing" manage=off
yabai -m rule --add app="RescueTime" manage=off

# Floating Windows (as per user preference)
yabai -m rule --add app="Finder" manage=off
yabai -m rule --add app="System Settings" manage=off
yabai -m rule --add app="Activity Monitor" manage=off

echo "✅ AI Learning profile loaded successfully for 2-display setup!"
echo "📚 Center Display: Learning Platforms & Interactive Tools"
echo "🤖 Right Display: AI Tutors & Knowledge Management"
echo "🎯 Study tools float for quick access"
echo "🧠 AI tutors always visible across spaces"

# Check for learning resources
if [ -d "/Applications/Coursera.app" ]; then
    echo "🎓 Coursera available for structured learning"
fi

if [ -d "/Applications/Udemy.app" ]; then
    echo "💻 Udemy available for skill development"
fi

if [ -d "/Applications/Khan Academy.app" ]; then
    echo "📖 Khan Academy available for free education"
fi

echo "💡 Tip: Use AI tutors for explanations, practice problems, and concept clarification!"
echo "🎯 Recommended learning workflow:"
echo "   1. Start with structured courses (Coursera/Udemy)"
echo "   2. Use AI tutors for clarification and practice"
echo "   3. Build projects with Jupyter/Colab"
echo "   4. Document learning in Obsidian/Notion"

