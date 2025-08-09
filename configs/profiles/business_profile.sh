#!/bin/zsh

# Business Profile - Meetings, Admin, Client Work
# Optimized for business meetings, administration, client work
# 2-Display Setup: Center (34" curved main) + Right (iMac 24")

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"

echo "💼 Loading Business Profile for 2-Display Setup..."

# Communication & Meetings
echo "📞 Setting up communication tools..."
open -na "/Applications/Zoom.app"               # Video meetings
open -na "/Applications/Microsoft Teams.app"    # Team collaboration
open -na "/Applications/Slack.app"              # Team chat
open -na "/Applications/Skype.app"              # Client calls
open -na "/Applications/FaceTime.app"           # Quick calls
open -na "/Applications/WhatsApp.app"           # Business messaging

# Business Applications
echo "📊 Launching business applications..."
open -na "/Applications/Microsoft Excel.app"    # Spreadsheets
open -na "/Applications/Microsoft Word.app"     # Documents
open -na "/Applications/Microsoft PowerPoint.app" # Presentations
open -na "/Applications/Keynote.app"            # Apple presentations
open -na "/Applications/Numbers.app"            # Apple spreadsheets
open -na "/Applications/Pages.app"              # Apple documents

# Project Management
echo "📋 Opening project management tools..."
open -na "/Applications/Notion.app"             # Project planning
open -na "/Applications/Trello.app"             # Task management
open -na "/Applications/Asana.app"              # Team projects
open -na "/Applications/Monday.com.app"         # Workflow management

# Email & Calendar
echo "📧 Setting up email and calendar..."
open -na "/Applications/Mail.app"               # Email client
open -na "/Applications/Calendar.app"           # Schedule management
open -na "/Applications/Contacts.app"           # Contact management
open -na "/Applications/Fantastical - Calendar & Tasks.app" # Advanced calendar

# Financial & Admin
echo "💰 Loading financial tools..."
open -na "/Applications/QuickBooks.app"         # Accounting
open -na "/Applications/Banking 4.app"          # Banking
open -na "/Applications/MoneyMoney.app"         # Finance management
open -na "/Applications/PDF Expert.app"         # Document handling

# Web Tools
echo "🌐 Opening business browsers..."
open -na "/Applications/Safari.app"             # General browsing
open -na "/Applications/Vivaldi.app"            # Client portals

# AI Business Assistant
echo "🤖 Loading AI business assistant..."
open -na "/Applications/ChatGPT.app"
open -na "/Applications/Grok.app"
open -na "/Applications/Perplexity- Ask Anything.app"

# Wait for apps to launch
sleep 5

# Apply business-specific YABAI rules for 2-display setup
echo "📐 Applying business layout for Center (main) + Right displays..."

# Center Display (34" curved - Display 1 - Main Business Work)
yabai -m rule --add app="Microsoft Excel" display=1 space=1
yabai -m rule --add app="Microsoft PowerPoint" display=1 space=1
yabai -m rule --add app="Keynote" display=1 space=2
yabai -m rule --add app="Numbers" display=1 space=2
yabai -m rule --add app="Microsoft Word" display=1 space=3
yabai -m rule --add app="Pages" display=1 space=3
yabai -m rule --add app="PDF Expert" display=1 space=4
yabai -m rule --add app="QuickBooks" display=1 space=4

# Right Display (iMac 24" - Display 2 - Communication & Management)
yabai -m rule --add app="Mail" display=2 space=1
yabai -m rule --add app="Calendar" display=2 space=1
yabai -m rule --add app="Contacts" display=2 space=2
yabai -m rule --add app="Fantastical - Calendar & Tasks" display=2 space=2
yabai -m rule --add app="Notion" display=2 space=3
yabai -m rule --add app="Trello" display=2 space=3
yabai -m rule --add app="Asana" display=2 space=4
yabai -m rule --add app="Monday.com" display=2 space=4

# Meeting apps - floating for quick access during calls
yabai -m rule --add app="Zoom" manage=off sticky=on
yabai -m rule --add app="Microsoft Teams" manage=off sticky=on
yabai -m rule --add app="FaceTime" manage=off sticky=on

# Communication - floating for constant access
yabai -m rule --add app="Slack" manage=off sticky=on
yabai -m rule --add app="WhatsApp" manage=off sticky=on

# Financial apps - dedicated space for security
yabai -m rule --add app="Banking 4" display=1 space=5
yabai -m rule --add app="MoneyMoney" display=1 space=5

# AI Tools - Always visible for business assistance
yabai -m rule --add app="ChatGPT" sticky=on manage=off
yabai -m rule --add app="Grok" sticky=on manage=off
yabai -m rule --add app="Perplexity- Ask Anything" sticky=on manage=off

# Business-specific floating windows
yabai -m rule --add app="Calculator" manage=off
yabai -m rule --add app="Activity Monitor" manage=off  # Performance during calls
yabai -m rule --add app="Screenshot" manage=off        # Quick screenshots

echo "✅ Business profile loaded successfully for 2-display setup!"
echo "💼 Center Display: Documents, Presentations & Finance"
echo "📞 Right Display: Communication, Calendar & Project Management"
echo "🤝 Meeting apps floating for seamless video calls"
echo "🧠 AI assistants ready for business writing and analysis"
