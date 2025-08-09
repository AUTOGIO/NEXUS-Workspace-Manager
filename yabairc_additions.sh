#!/bin/zsh
# 🎯 NEXUS YABAI Rules - Enhanced for 2-Display Setup
# Automatically generated adaptive YABAI rules for optimal workspace management
# Compatible with separated spaces and adaptive display detection

# =============================================================================
# 🖥️  ADAPTIVE DISPLAY CONFIGURATION
# =============================================================================

# Read current display count
DISPLAY_COUNT=$(cat configs/current_display_count.txt 2>/dev/null || echo "2")
echo "📺 Configuring YABAI rules for $DISPLAY_COUNT display(s)"

# =============================================================================
# 🚀 GLOBAL YABAI SETTINGS
# =============================================================================

# Window management settings
yabai -m config layout                       bsp
yabai -m config window_placement             second_child
yabai -m config window_topmost               off
yabai -m config window_shadow                on
yabai -m config window_opacity               off
yabai -m config window_opacity_duration      0.0
yabai -m config active_window_opacity        1.0
yabai -m config normal_window_opacity        0.90

# Padding and gaps
yabai -m config top_padding                  12
yabai -m config bottom_padding               12
yabai -m config left_padding                 12
yabai -m config right_padding                12
yabai -m config window_gap                   06

# Mouse settings
yabai -m config mouse_follows_focus          off
yabai -m config focus_follows_mouse          off
yabai -m config mouse_modifier               fn
yabai -m config mouse_action1                move
yabai -m config mouse_action2                resize
yabai -m config mouse_drop_action            swap

# =============================================================================
# 📱 APPLICATION-SPECIFIC RULES
# =============================================================================

# 🤖 AI Tools - Always Visible (Sticky across spaces)
yabai -m rule --add app="ChatGPT"            sticky=on manage=off
yabai -m rule --add app="Grok"               sticky=on manage=off
yabai -m rule --add app="GitHub Copilot"     sticky=on manage=off

# 🗂️  System Tools - Floating Windows
yabai -m rule --add app="Finder"             manage=off
yabai -m rule --add app="iTerm2"             manage=off
yabai -m rule --add app="Terminal"           manage=off
yabai -m rule --add app="System Settings"    manage=off
yabai -m rule --add app="System Preferences" manage=off
yabai -m rule --add app="Activity Monitor"   manage=off
yabai -m rule --add app="Console"            manage=off

# 📊 Utility Apps - Floating
yabai -m rule --add app="Calculator"         manage=off
yabai -m rule --add app="Calendar"           manage=off
yabai -m rule --add app="Contacts"           manage=off
yabai -m rule --add app="Preview"            manage=off
yabai -m rule --add app="Quick Look"         manage=off

# =============================================================================
# 🖥️  ADAPTIVE DISPLAY ASSIGNMENTS
# =============================================================================

if [ "$DISPLAY_COUNT" = "3" ]; then
    echo "🎯 Configuring for 3-display setup..."
    
    # Left Display (Display 1) - Communication & Tools
    yabai -m rule --add app="WhatsApp"       display=1 space=1
    yabai -m rule --add app="X"              display=1 space=2
    yabai -m rule --add app="Telegram"       display=1 space=3
    yabai -m rule --add app="Obsidian"       display=1 space=4
    
    # Center Display (Display 2) - Primary Development
    yabai -m rule --add app="Cursor"         display=2 space=1
    yabai -m rule --add app="Vivaldi"        display=2 space=2
    yabai -m rule --add app="YouTube"        display=2 space=3
    yabai -m rule --add app="Perplexity- Ask Anything" display=2 space=4
    
    # Right Display (Display 3) - AI & Research
    yabai -m rule --add app="Ollama"         display=3 space=1
    yabai -m rule --add app="LM Studio"      display=3 space=2
    yabai -m rule --add app="MLX"            display=3 space=3
    yabai -m rule --add app="Safari"         display=3 space=4

elif [ "$DISPLAY_COUNT" = "2" ]; then
    echo "🎯 Configuring for 2-display setup (Current)..."
    
    # Center Display (Display 1) - Primary Development & Content
    yabai -m rule --add app="Cursor"                   display=1 space=1
    yabai -m rule --add app="Vivaldi"                  display=1 space=2
    yabai -m rule --add app="YouTube"                  display=1 space=3
    yabai -m rule --add app="Perplexity- Ask Anything" display=1 space=4
    yabai -m rule --add app="Ollama"                   display=1 space=5
    yabai -m rule --add app="LM Studio"                display=1 space=6
    yabai -m rule --add app="MLX"                      display=1 space=7
    
    # Right Display (Display 2) - Communication & Productivity
    yabai -m rule --add app="Obsidian"                 display=2 space=1
    yabai -m rule --add app="Notes"                    display=2 space=2
    yabai -m rule --add app="Safari"                   display=2 space=3
    yabai -m rule --add app="Shortcuts"                display=2 space=4
    yabai -m rule --add app="WhatsApp"                 display=2 space=5
    yabai -m rule --add app="X"                        display=2 space=6
    yabai -m rule --add app="Telegram"                 display=2 space=7

else
    echo "🎯 Configuring for single display setup..."
    
    # Single Display - All applications on different spaces
    yabai -m rule --add app="Cursor"                   display=1 space=1
    yabai -m rule --add app="Vivaldi"                  display=1 space=2
    yabai -m rule --add app="Obsidian"                 display=1 space=3
    yabai -m rule --add app="Safari"                   display=1 space=4
    yabai -m rule --add app="WhatsApp"                 display=1 space=5
    yabai -m rule --add app="X"                        display=1 space=6
    yabai -m rule --add app="Telegram"                 display=1 space=7
    yabai -m rule --add app="YouTube"                  display=1 space=8
    yabai -m rule --add app="Ollama"                   display=1 space=9
    yabai -m rule --add app="LM Studio"                display=1 space=10
fi

# =============================================================================
# 🔧 DEVELOPMENT TOOLS
# =============================================================================

# Code Editors
yabai -m rule --add app="Cursor"             border=on
yabai -m rule --add app="Visual Studio Code" border=on
yabai -m rule --add app="Xcode"              border=on
yabai -m rule --add app="Sublime Text"       border=on

# Development Support
yabai -m rule --add app="Postman"            display=1 space=3
yabai -m rule --add app="Docker Desktop"     manage=off
yabai -m rule --add app="Simulator"          manage=off

# =============================================================================
# 🌐 BROWSERS & RESEARCH
# =============================================================================

# Browser assignments
yabai -m rule --add app="Vivaldi"            border=on
yabai -m rule --add app="Safari"             border=on
yabai -m rule --add app="Firefox"            border=on
yabai -m rule --add app="Chrome"             border=on

# Research tools
yabai -m rule --add app="Perplexity- Ask Anything" border=on
yabai -m rule --add app="YouTube"            border=on

# =============================================================================
# 💬 COMMUNICATION & PRODUCTIVITY
# =============================================================================

# Social & Communication
yabai -m rule --add app="WhatsApp"           border=on
yabai -m rule --add app="X"                  border=on
yabai -m rule --add app="Telegram"           border=on
yabai -m rule --add app="Slack"              border=on
yabai -m rule --add app="Discord"            border=on

# Productivity
yabai -m rule --add app="Obsidian"           border=on
yabai -m rule --add app="Notes"              border=on
yabai -m rule --add app="Shortcuts"          border=on
yabai -m rule --add app="Notion"             border=on

# =============================================================================
# 🤖 AI & ML TOOLS
# =============================================================================

# Local AI Platforms
yabai -m rule --add app="Ollama"             border=on
yabai -m rule --add app="LM Studio"          border=on
yabai -m rule --add app="MLX"                border=on

# Cloud AI Services (if they have dedicated apps)
yabai -m rule --add app="Claude"             sticky=on manage=off
yabai -m rule --add app="Perplexity"         border=on

# =============================================================================
# 🎵 MEDIA & ENTERTAINMENT
# =============================================================================

# Media applications
yabai -m rule --add app="Spotify"            manage=off
yabai -m rule --add app="Music"              manage=off
yabai -m rule --add app="TV"                 manage=off
yabai -m rule --add app="Photos"             manage=off
yabai -m rule --add app="IINA"               manage=off
yabai -m rule --add app="VLC"                manage=off

# =============================================================================
# 🛡️  SYSTEM & SECURITY
# =============================================================================

# Security & System
yabai -m rule --add app="1Password"          manage=off
yabai -m rule --add app="Keychain Access"    manage=off
yabai -m rule --add app="Little Snitch"      manage=off
yabai -m rule --add app="CleanMyMac X"       manage=off

# =============================================================================
# 📊 DASHBOARD & MONITORING
# =============================================================================

# Development dashboards
yabai -m rule --add app="Streamlit"          manage=off
yabai -m rule --add app="Python"             title="NEXUS.*Dashboard" manage=off

# =============================================================================
# 🔧 SIGNALS & CLEANUP
# =============================================================================

# Add signals for automatic rule reloading
yabai -m signal --add event=dock_did_restart action="sudo yabai --load-sa"
yabai -m signal --add event=window_focused action="yabai -m window --toggle border"

echo "✅ NEXUS YABAI rules configured successfully for $DISPLAY_COUNT display(s)!"
echo "🔄 Restart YABAI to apply changes: yabai --restart-service"
echo "📋 View active rules: yabai -m rule --list"
echo "🖥️  Check displays: yabai -m query --displays"
