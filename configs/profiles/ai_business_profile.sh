#!/bin/zsh

# AI Business Profile - AI-Powered Business Workflows & Automation
# Optimized for business automation, AI-powered productivity, and professional workflows
# 2-Display Setup: Center (34" curved main) + Right (iMac 24")

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"

echo "💼 Loading AI Business Profile for 2-Display Setup..."

# Business Communication & Collaboration
echo "💬 Setting up business communication..."
open -na "/Applications/Slack.app"                      # Team collaboration
open -na "/Applications/Microsoft Teams.app"            # Video meetings
open -na "/Applications/Zoom.app"                       # Video conferencing
open -na "/Applications/Skype.app"                      # Client calls
open -na "/Applications/WhatsApp.app"                   # Business messaging
open -na "/Applications/Telegram.app"                   # Team chat

# AI-Powered Business Tools
echo "🤖 Setting up AI business tools..."
open -na "/Applications/ChatGPT.app"                    # AI business assistant
open -na "/Applications/Grok.app"                       # Alternative AI assistant
open -na "/Applications/Claude.app"                     # Anthropic AI assistant
open -na "/Applications/Perplexity- Ask Anything.app"   # Business research
open -na "/Applications/Jasper.app"                     # AI content creation
open -na "/Applications/Copy.ai.app"                    # AI copywriting

# Business Productivity
echo "📊 Setting up business productivity..."
open -na "/Applications/Microsoft Excel.app"            # Data analysis
open -na "/Applications/Microsoft Word.app"             # Document creation
open -na "/Applications/Microsoft PowerPoint.app"       # Presentations
open -na "/Applications/Notion.app"                     # Project management
open -na "/Applications/Asana.app"                      # Task management
open -na "/Applications/Trello.app"                     # Kanban boards

# Business Intelligence & Analytics
echo "📈 Setting up business intelligence..."
open -na "/Applications/Tableau.app"                    # Data visualization
open -na "/Applications/Power BI.app"                   # Microsoft analytics
open -na "/Applications/Google Analytics.app"           # Web analytics
open -na "/Applications/Mixpanel.app"                   # Product analytics
open -na "/Applications/Amplitude.app"                  # User analytics

# AI Development & Automation
echo "⚙️ Setting up AI automation..."
open -na "/Applications/Cursor.app"                     # AI-powered coding
open -na "/Applications/Visual Studio Code.app"         # Development
open -na "/Applications/Python.app"                     # AI/ML development
open -na "/Applications/Jupyter.app"                    # Data analysis
open -na "/Applications/Postman.app"                    # API testing

# Wait for apps to launch
sleep 4

# Apply AI business-specific YABAI rules for 2-display setup
echo "📐 Applying AI business layout for Center (main) + Right displays..."

# Center Display (34" curved - Display 1 - Main Business)
yabai -m rule --add app="Microsoft Excel" display=1 space=1
yabai -m rule --add app="Microsoft Word" display=1 space=2
yabai -m rule --add app="Microsoft PowerPoint" display=1 space=3
yabai -m rule --add app="Notion" display=1 space=4

# Right Display (iMac 24" - Display 2 - AI Tools & Communication)
yabai -m rule --add app="ChatGPT" display=2 space=1
yabai -m rule --add app="Grok" display=2 space=2
yabai -m rule --add app="Slack" display=2 space=3
yabai -m rule --add app="Microsoft Teams" display=2 space=4

# AI Tools - Always visible (sticky across spaces)
yabai -m rule --add app="ChatGPT" sticky=on manage=off
yabai -m rule --add app="Grok" sticky=on manage=off
yabai -m rule --add app="Claude" sticky=on manage=off
yabai -m rule --add app="Perplexity- Ask Anything" sticky=on manage=off

# Business tools - floating for quick access
yabai -m rule --add app="Slack" manage=off
yabai -m rule --add app="Microsoft Teams" manage=off
yabai -m rule --add app="Zoom" manage=off
yabai -m rule --add app="WhatsApp" manage=off

# Floating Windows (as per user preference)
yabai -m rule --add app="Finder" manage=off
yabai -m rule --add app="System Settings" manage=off
yabai -m rule --add app="Activity Monitor" manage=off

echo "✅ AI Business profile loaded successfully for 2-display setup!"
echo "💼 Center Display: Business Productivity & Analysis"
echo "🤖 Right Display: AI Assistants & Communication"
echo "💬 Business tools float for quick access"
echo "🧠 AI assistants always visible across spaces"

# Check for business tools
if [ -d "/Applications/Tableau.app" ]; then
    echo "📊 Tableau available for advanced data visualization"
fi

if [ -d "/Applications/Power BI.app" ]; then
    echo "📈 Power BI available for Microsoft ecosystem analytics"
fi

if [ -d "/Applications/Jasper.app" ]; then
    echo "✍️ Jasper available for AI-powered content creation"
fi

echo "💡 Tip: Use AI assistants for:"
echo "   • Data analysis and insights"
echo "   • Report and presentation creation"
echo "   • Business research and market analysis"
echo "   • Process automation ideas"
echo "   • Customer communication templates"

echo "🎯 Recommended business workflow:"
echo "   1. Use AI for research and analysis"
echo "   2. Create content with AI assistance"
echo "   3. Automate repetitive tasks"
echo "   4. Monitor performance with analytics"
echo "   5. Collaborate effectively with team tools"

