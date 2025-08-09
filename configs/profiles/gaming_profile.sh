#!/bin/zsh

# Gaming Profile - Gaming, Streaming, Entertainment
# Optimized for gaming, streaming, and entertainment
# 2-Display Setup: Center (34" curved main) + Right (iMac 24")

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"

echo "🎮 Loading Gaming Profile for 2-Display Setup..."

# Gaming & Entertainment
echo "🕹️ Setting up gaming and entertainment..."
# Web-based gaming platforms
open -na "/Applications/Google Chrome.app" --args "https://stadia.google.com"
open -na "/Applications/Safari.app" --args "https://xbox.com/play"

# Gaming Utilities & Performance
echo "⚡ Setting up gaming utilities..."
open -na "/Applications/iStatistica Pro.app"        # System monitoring
open -na "/Applications/iStatistica Sensors.app"    # Thermal monitoring  
open -na "/Applications/CleanMyMac_5_MAS.app"       # System cleanup
open -na "/Applications/ActivityWatch.app"          # Activity tracking

# Entertainment
echo "📺 Opening entertainment apps..."
open -na "/Users/eduardof.giovannini/Applications/YouTube.app" # Gaming videos
open -na "/Applications/Music.app"              # Apple Music
open -na "/Applications/Boom 3D.app"            # Audio enhancement

# Gaming Browsers (for game guides, wikis)
echo "🌐 Setting up gaming research..."
open -na "/Applications/Safari.app"
open -na "/Applications/Vivaldi.app"

# AI Gaming Assistant
echo "🤖 Loading AI gaming assistant..."
open -na "/Applications/ChatGPT.app"
open -na "/Applications/Grok.app"

# Wait for apps to launch
sleep 4

# Apply gaming-specific YABAI rules for 2-display setup
echo "📐 Applying gaming layout for Center (main) + Right displays..."

# Center Display (34" curved - Display 1 - Main Gaming)
yabai -m rule --add app="Steam" display=1 space=1
yabai -m rule --add app="Epic Games Launcher" display=1 space=1
yabai -m rule --add app="Battle.net" display=1 space=2
yabai -m rule --add app="GeForce NOW" display=1 space=2
yabai -m rule --add app="Xbox" display=1 space=3
yabai -m rule --add app="PlayStation Remote Play" display=1 space=3

# Right Display (iMac 24" - Display 2 - Communication & Streaming)
yabai -m rule --add app="Discord" display=2 space=1
yabai -m rule --add app="OBS" display=2 space=1
yabai -m rule --add app="Elgato Stream Deck" display=2 space=2
yabai -m rule --add app="YouTube" display=2 space=2
yabai -m rule --add app="Twitch" display=2 space=3
yabai -m rule --add app="Safari" display=2 space=3
yabai -m rule --add app="Vivaldi" display=2 space=4
yabai -m rule --add app="Stats" display=2 space=4

# Entertainment apps - floating for quick access
yabai -m rule --add app="Netflix" manage=off sticky=on
yabai -m rule --add app="Spotify" manage=off sticky=on

# AI Tools - Always visible for gaming help
yabai -m rule --add app="ChatGPT" sticky=on manage=off
yabai -m rule --add app="Grok" sticky=on manage=off

# Gaming-specific floating windows
yabai -m rule --add app="Game Center" manage=off
yabai -m rule --add app="Activity Monitor" manage=off  # Performance monitoring
yabai -m rule --add app="Console" manage=off           # Debug logs
yabai -m rule --add app="Temperature Gauge Pro" manage=off # Thermal monitoring

# Don't manage fullscreen games
yabai -m rule --add app=".*\\.exe" manage=off          # Windows games via Wine
yabai -m rule --add title=".*Fullscreen.*" manage=off   # Fullscreen games

echo "✅ Gaming profile loaded successfully for 2-display setup!"
echo "🎮 Center Display: Gaming Platforms & Games"
echo "💬 Right Display: Communication, Streaming & Guides"
echo "🎵 Entertainment apps float for easy access during gaming"
