#!/bin/zsh

# AI Gaming Profile - AI-Enhanced Gaming & Entertainment
# Optimized for AI-powered gaming, streaming, and entertainment workflows
# 2-Display Setup: Center (34" curved main) + Right (iMac 24")

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"

echo "🎮 Loading AI Gaming Profile for 2-Display Setup..."

# Gaming Platforms & Launchers
echo "🕹️ Setting up gaming platforms..."
open -na "/Applications/Steam.app"                      # Steam games
open -na "/Applications/Epic Games Launcher.app"        # Epic games
open -na "/Applications/Battle.net.app"                 # Blizzard games
open -na "/Applications/Origin.app"                     # EA games
open -na "/Applications/Uplay.app"                      # Ubisoft games
open -na "/Applications/GOG Galaxy.app"                 # GOG games

# AI-Enhanced Gaming Tools
echo "🤖 Setting up AI gaming tools..."
open -na "/Applications/ChatGPT.app"                    # AI gaming assistant
open -na "/Applications/Grok.app"                       # Alternative AI assistant
open -na "/Applications/Perplexity- Ask Anything.app"   # Gaming research
open -na "/Applications/Claude.app"                     # Anthropic AI assistant
open -na "/Applications/GameChanger.app"                # AI game optimization

# Streaming & Content Creation
echo "📺 Setting up streaming tools..."
open -na "/Applications/OBS Studio.app"                 # Stream broadcasting
open -na "/Applications/Streamlabs.app"                 # Stream overlays
open -na "/Applications/Elgato Stream Deck.app"         # Stream control
open -na "/Applications/StreamElements.app"             # Stream management
open -na "/Applications/Twitch.app"                     # Twitch streaming

# Gaming Communication
echo "💬 Setting up gaming communication..."
open -na "/Applications/Discord.app"                    # Gaming chat
open -na "/Applications/TeamSpeak.app"                  # Voice chat
open -na "/Applications/Mumble.app"                     # Alternative voice
open -na "/Applications/Skype.app"                      # Video calls
open -na "/Applications/WhatsApp.app"                   # Team messaging

# Gaming Research & Guides
echo "🔍 Setting up gaming research..."
open -na "/Applications/Safari.app"                     # Web research
open -na "/Applications/Google Chrome.app"              # Alternative browser
open -na "/Applications/YouTube.app"                    # Gaming videos
open -na "/Applications/Twitch.app"                     # Live streams
open -na "/Applications/Reddit.app"                     # Gaming community

# Performance Monitoring
echo "⚡ Setting up performance monitoring..."
open -na "/Applications/Activity Monitor.app"            # System monitoring
open -na "/Applications/iStatistica Pro.app"            # Advanced monitoring
open -na "/Applications/iStatistica Sensors.app"        # Thermal monitoring
open -na "/Applications/Stats.app"                      # Menu bar stats
open -na "/Applications/Temperature Gauge Pro.app"      # Thermal monitoring

# Wait for apps to launch
sleep 4

# Apply AI gaming-specific YABAI rules for 2-display setup
echo "📐 Applying AI gaming layout for Center (main) + Right displays..."

# Center Display (34" curved - Display 1 - Main Gaming)
yabai -m rule --add app="Steam" display=1 space=1
yabai -m rule --add app="Epic Games Launcher" display=1 space=2
yabai -m rule --add app="Battle.net" display=1 space=3
yabai -m rule --add app="Origin" display=1 space=4

# Right Display (iMac 24" - Display 2 - AI Tools & Communication)
yabai -m rule --add app="ChatGPT" display=2 space=1
yabai -m rule --add app="Grok" display=2 space=2
yabai -m rule --add app="Discord" display=2 space=3
yabai -m rule --add app="OBS Studio" display=2 space=4

# AI Tools - Always visible (sticky across spaces)
yabai -m rule --add app="ChatGPT" sticky=on manage=off
yabai -m rule --add app="Grok" sticky=on manage=off
yabai -m rule --add app="Perplexity- Ask Anything" sticky=on manage=off
yabai -m rule --add app="Claude" sticky=on manage=off

# Gaming tools - floating for quick access
yabai -m rule --add app="Discord" manage=off
yabai -m rule --add app="OBS Studio" manage=off
yabai -m rule --add app="Elgato Stream Deck" manage=off
yabai -m rule --add app="Activity Monitor" manage=off

# Floating Windows (as per user preference)
yabai -m rule --add app="Finder" manage=off
yabai -m rule --add app="System Settings" manage=off
yabai -m rule --add app="Terminal" manage=off

# Don't manage fullscreen games
yabai -m rule --add app=".*\\.exe" manage=off          # Windows games via Wine
yabai -m rule --add title=".*Fullscreen.*" manage=off   # Fullscreen games

echo "✅ AI Gaming profile loaded successfully for 2-display setup!"
echo "🎮 Center Display: Gaming Platforms & Games"
echo "🤖 Right Display: AI Assistants & Communication"
echo "💬 Gaming tools float for quick access"
echo "🧠 AI assistants always visible across spaces"

# Check for gaming tools
if [ -d "/Applications/Steam.app" ]; then
    echo "🕹️ Steam available for PC gaming"
fi

if [ -d "/Applications/Epic Games Launcher.app" ]; then
    echo "🎮 Epic Games Launcher available for free games"
fi

if [ -d "/Applications/Discord.app" ]; then
    echo "💬 Discord available for gaming communication"
fi

echo "💡 Tip: Use AI assistants for:"
echo "   • Game strategy and tips"
echo "   • Performance optimization"
echo "   • Stream content ideas"
echo "   • Gaming research and guides"
echo "   • Community management"

echo "🎯 Recommended gaming workflow:"
echo "   1. Use AI for game research and strategy"
echo "   2. Optimize performance with monitoring tools"
echo "   3. Stream with OBS and manage with AI assistance"
echo "   4. Communicate with team via Discord/TeamSpeak"
echo "   5. Document gaming achievements and strategies"

