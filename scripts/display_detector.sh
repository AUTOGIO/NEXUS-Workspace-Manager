#!/bin/zsh

# Dynamic Display Detection Script
# Automatically detects display IDs and layouts for YABAI configuration

echo "🔍 Detecting display configuration..."

# Get display information
DISPLAYS=$(system_profiler SPDisplaysDataType | grep -A 10 "Displays:")

# Extract display IDs using YABAI
YABAI_DISPLAYS=$(yabai -m query --displays | jq -r '.[] | "Display \(.index): \(.frame.width)x\(.frame.height) at (\(.frame.x), \(.frame.y))"')

echo "📺 Current Display Layout:"
echo "$YABAI_DISPLAYS"

# Detect display arrangement (left to right)
echo ""
echo "🎯 Detected Display Order:"
yabai -m query --displays | jq -r 'sort_by(.frame.x) | .[] | "Display \(.index): \(.frame.width)x\(.frame.height)"'

# Generate YABAI rules based on detected displays
echo ""
echo "📝 Suggested YABAI Rules:"
echo "# Auto-generated rules based on display detection"
echo "# Left Display (Display 1): Browsers"
echo "yabai -m rule --add app=\"Vivaldi\"   display=1 space=1"
echo "yabai -m rule --add app=\"Safari\"    display=1 space=1"
echo ""
echo "# Center Display (Display 2): AI & Development"
echo "yabai -m rule --add app=\"ChatGPT\"   display=2 space=1"
echo "yabai -m rule --add app=\"Grok\"      display=2 space=1"
echo ""
echo "# Right Display (Display 3): Productivity"
echo "yabai -m rule --add app=\"Obsidian\"  display=3 space=1"
echo "yabai -m rule --add app=\"WhatsApp\"  display=3 space=1"
echo "yabai -m rule --add app=\"X\"         display=3 space=1"

# Save display configuration
DISPLAY_CONFIG=$(yabai -m query --displays | jq -r 'sort_by(.frame.x) | .[] | "\(.index):\(.frame.width)x\(.frame.height)"')
echo "$DISPLAY_CONFIG" > configs/display_layout.txt

echo ""
echo "✅ Display configuration saved to configs/display_layout.txt" 