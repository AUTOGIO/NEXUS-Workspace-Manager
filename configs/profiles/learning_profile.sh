#!/bin/zsh

# Learning Profile - Education, Courses, Skill Development
# Optimized for online learning, courses, and skill development
# 2-Display Setup: Center (34" curved main) + Right (iMac 24")

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"

echo "📚 Loading Learning Profile for 2-Display Setup..."

# Learning Platforms
echo "🎓 Launching learning platforms..."
open -na "/Applications/Safari.app" --args "https://coursera.org"
open -na "/Applications/Vivaldi.app" --args "https://udemy.com"
# YouTube for educational videos
open -na "/Applications/YouTube.app"
# Khan Academy, Brilliant, etc. (web-based)
open -na "/Applications/Chrome.app" --args "https://khanacademy.org"

# Development Learning
echo "💻 Setting up development learning environment..."
open -na "/Applications/Cursor.app"             # Code practice
open -na "/Applications/iTerm.app"              # Terminal practice
open -na "/Applications/GitHub Desktop.app"     # Version control learning
open -na "/Applications/Postman.app"            # API learning

# Note-taking & Organization
echo "📝 Opening note-taking tools..."
open -na "/Applications/Obsidian.app"           # Knowledge management
open -na "/Applications/Notion.app"             # Course organization
open -na "/Applications/Notes.app"              # Quick notes
open -na "/Applications/Anki.app"               # Spaced repetition
open -na "/Applications/GoodNotes 5.app"        # Digital handwriting

# Reading & Research
echo "📖 Setting up reading environment..."
open -na "/Applications/Kindle.app"             # E-books
open -na "/Applications/PDF Expert.app"         # PDF textbooks
open -na "/Applications/Zotero.app"             # Research management
open -na "/Applications/DEVONthink 3.app"       # Document management

# Language Learning (if applicable)
echo "🌍 Opening language learning tools..."
open -na "/Applications/Duolingo.app"
open -na "/Applications/Babbel.app"
open -na "/Applications/Rosetta Stone.app"

# Focus & Productivity
echo "⏰ Setting up focus environment..."
open -na "/Applications/Be Focused.app"         # Pomodoro timer
open -na "/Applications/Forest.app"             # Focus app
open -na "/Applications/RescueTime.app"         # Time tracking

# AI Learning Assistant
echo "🤖 Loading AI learning assistant..."
open -na "/Applications/ChatGPT.app"
open -na "/Applications/Grok.app"
open -na "/Applications/Perplexity- Ask Anything.app"

# Wait for apps to launch
sleep 4

# Apply learning-specific YABAI rules for 2-display setup
echo "📐 Applying learning layout for Center (main) + Right displays..."

# Center Display (34" curved - Display 1 - Main Learning Content)
yabai -m rule --add app="Safari" title=".*coursera.*" display=1 space=1
yabai -m rule --add app="Vivaldi" title=".*udemy.*" display=1 space=1
yabai -m rule --add app="YouTube" display=1 space=2
yabai -m rule --add app="Chrome" title=".*khan.*" display=1 space=2
yabai -m rule --add app="Cursor" display=1 space=3
yabai -m rule --add app="iTerm2" display=1 space=3
yabai -m rule --add app="Kindle" display=1 space=4
yabai -m rule --add app="PDF Expert" display=1 space=4

# Right Display (iMac 24" - Display 2 - Notes & Organization)
yabai -m rule --add app="Obsidian" display=2 space=1
yabai -m rule --add app="Notion" display=2 space=1
yabai -m rule --add app="Notes" display=2 space=2
yabai -m rule --add app="Anki" display=2 space=2
yabai -m rule --add app="GoodNotes 5" display=2 space=3
yabai -m rule --add app="Zotero" display=2 space=3
yabai -m rule --add app="DEVONthink 3" display=2 space=4

# Language learning - floating for quick practice
yabai -m rule --add app="Duolingo" manage=off sticky=on
yabai -m rule --add app="Babbel" manage=off sticky=on

# Focus tools - floating and always accessible
yabai -m rule --add app="Be Focused" manage=off sticky=on
yabai -m rule --add app="Forest" manage=off sticky=on

# AI Tools - Always visible for learning assistance
yabai -m rule --add app="ChatGPT" sticky=on manage=off
yabai -m rule --add app="Grok" sticky=on manage=off
yabai -m rule --add app="Perplexity- Ask Anything" sticky=on manage=off

# Learning-specific floating windows
yabai -m rule --add app="Calculator" manage=off
yabai -m rule --add app="Dictionary" manage=off
yabai -m rule --add app="Translate" manage=off

echo "✅ Learning profile loaded successfully for 2-display setup!"
echo "🎓 Center Display: Learning Content & Practice"
echo "📚 Right Display: Notes, Organization & Research"
echo "🧠 AI assistants available for instant help and explanations"
echo "⏰ Focus tools floating for productivity management"
