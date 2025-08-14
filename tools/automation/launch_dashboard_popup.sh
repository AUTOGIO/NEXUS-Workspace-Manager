#!/bin/zsh
# 🪟 NEXUS Dashboard Popup Launcher
# Creates a floating, app-like window for the NEXUS dashboard

set -e

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo "${BLUE}🪟 Launching NEXUS Dashboard as Floating Window...${NC}"

# Get script directory
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

# Dashboard configuration
DASHBOARD_PORT="8501"
DASHBOARD_URL="http://localhost:$DASHBOARD_PORT"

# Start Streamlit dashboard in background if not running
if ! curl -s "$DASHBOARD_URL" > /dev/null 2>&1; then
    echo "${YELLOW}📊 Starting dashboard server...${NC}"
    cd "$PROJECT_ROOT"
    python3 -m streamlit run src/nexus/dashboard/workspace_dashboard.py --server.port=$DASHBOARD_PORT &
    STREAMLIT_PID=$!
    
    # Wait for dashboard to start
    echo "${YELLOW}⏳ Waiting for dashboard to initialize...${NC}"
    for i in {1..10}; do
        if curl -s "$DASHBOARD_URL" > /dev/null 2>&1; then
            break
        fi
        sleep 1
    done
else
    echo "${GREEN}✅ Dashboard already running${NC}"
fi

# macOS: Open in Safari with specific window configuration
if command -v osascript &> /dev/null; then
    echo "${BLUE}🚀 Opening dashboard in floating Safari window...${NC}"
    
    osascript -e "
    tell application \"Safari\"
        activate
        make new document with properties {URL:\"$DASHBOARD_URL\"}
        
        -- Configure window as floating popup
        tell front window
            set bounds to {100, 100, 1200, 800}
            set miniaturizable to false
        end tell
        
        -- Enter full-screen mode for the tab (optional)
        delay 2
        tell application \"System Events\"
            tell process \"Safari\"
                -- Hide toolbar for cleaner look
                keystroke \"t\" using {command down, shift down}
            end tell
        end tell
    end tell
    "
    
    echo "${GREEN}✅ NEXUS Dashboard opened as floating window!${NC}"
    echo "${YELLOW}💡 Tip: Press ⌘+Shift+T to toggle toolbar in Safari${NC}"

# Alternative: Chrome/Vivaldi app mode
elif command -v open &> /dev/null; then
    echo "${BLUE}🚀 Opening dashboard in Chrome app mode...${NC}"
    
    # Try Chrome first, then Vivaldi
    if [[ -d "/Applications/Google Chrome.app" ]]; then
        open -na "Google Chrome" --args \
            --app="$DASHBOARD_URL" \
            --window-size=1200,800 \
            --window-position=100,100 \
            --disable-web-security \
            --disable-features=TranslateUI \
            --no-first-run
    elif [[ -d "/Applications/Vivaldi.app" ]]; then
        open -na "Vivaldi" --args \
            --app="$DASHBOARD_URL" \
            --window-size=1200,800 \
            --window-position=100,100
    else
        echo "${YELLOW}⚠️  Chrome/Vivaldi not found, opening in default browser...${NC}"
        open "$DASHBOARD_URL"
    fi
    
    echo "${GREEN}✅ NEXUS Dashboard opened in app mode!${NC}"
else
    echo "${YELLOW}⚠️  Could not detect macOS, opening in default browser...${NC}"
    python3 -c "import webbrowser; webbrowser.open('$DASHBOARD_URL')"
fi

# YABAI: Make the window floating (if YABAI is running)
if command -v yabai &> /dev/null && yabai -m query --displays > /dev/null 2>&1; then
    echo "${BLUE}🔧 Configuring YABAI rules for dashboard window...${NC}"
    
    # Add rule to make Safari/Chrome NEXUS windows floating
    yabai -m rule --add app="Safari" title=".*localhost:$DASHBOARD_PORT.*" manage=off
    yabai -m rule --add app="Google Chrome" title=".*NEXUS.*" manage=off
    yabai -m rule --add app="Vivaldi" title=".*NEXUS.*" manage=off
    
    echo "${GREEN}✅ Dashboard window configured as floating${NC}"
fi

echo ""
echo "${GREEN}🎉 NEXUS Dashboard is now running as a floating window!${NC}"
echo "${BLUE}📍 URL: $DASHBOARD_URL${NC}"
echo "${YELLOW}💡 The dashboard will stay on top and behave like a native app${NC}"
echo ""
echo "${YELLOW}🛑 To stop the dashboard: Press Ctrl+C or close the window${NC}"

# Keep script running to maintain the background process
if [[ -n "$STREAMLIT_PID" ]]; then
    echo "${BLUE}📊 Dashboard server running (PID: $STREAMLIT_PID)${NC}"
    echo "${YELLOW}Press Ctrl+C to stop...${NC}"
    
    # Wait for user to stop
    trap "echo '${YELLOW}🛑 Stopping dashboard...${NC}'; kill $STREAMLIT_PID 2>/dev/null; exit 0" INT
    wait $STREAMLIT_PID
fi
