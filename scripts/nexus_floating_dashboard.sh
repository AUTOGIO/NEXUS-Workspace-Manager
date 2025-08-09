#!/bin/zsh
# 🪟 NEXUS Floating Dashboard - Simple & Reliable
# Opens dashboard as a floating app-like window

DASHBOARD_URL="http://localhost:8501"

echo "🧠 Opening NEXUS Dashboard as floating window..."

# Option 1: Chrome App Mode (most app-like)
if [[ -d "/Applications/Google Chrome.app" ]]; then
    echo "🚀 Launching in Chrome app mode..."
    open -na "Google Chrome" --args \
        --app="$DASHBOARD_URL" \
        --window-size=1200,800 \
        --window-position=100,100 \
        --no-first-run \
        --disable-web-security

# Option 2: Vivaldi App Mode  
elif [[ -d "/Applications/Vivaldi.app" ]]; then
    echo "🚀 Launching in Vivaldi app mode..."
    open -na "Vivaldi" --args \
        --app="$DASHBOARD_URL" \
        --window-size=1200,800 \
        --window-position=100,100

# Option 3: Safari (fallback)
else
    echo "🚀 Launching in Safari..."
    open -a Safari "$DASHBOARD_URL"
fi

# Configure YABAI for floating window
if command -v yabai &> /dev/null && yabai -m query --displays > /dev/null 2>&1; then
    echo "🔧 Setting up floating window rules..."
    
    # Make dashboard windows float and stick
    yabai -m rule --add app="Google Chrome" title=".*localhost:8501.*" manage=off sticky=on
    yabai -m rule --add app="Vivaldi" title=".*localhost:8501.*" manage=off sticky=on  
    yabai -m rule --add app="Safari" title=".*localhost:8501.*" manage=off sticky=on
    
    echo "✅ Dashboard configured as floating window"
fi

echo "🎉 NEXUS Dashboard is now floating!"
echo "💡 The window will stay on top and behave like an app"
