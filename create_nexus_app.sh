#!/bin/zsh
# 📱 Create NEXUS Dashboard App
# Creates a macOS app bundle that launches the dashboard as a floating window

set -e

APP_NAME="NEXUS Dashboard"
APP_DIR="$HOME/Applications/$APP_NAME.app"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "📱 Creating $APP_NAME.app..."

# Create app bundle structure
mkdir -p "$APP_DIR/Contents/MacOS"
mkdir -p "$APP_DIR/Contents/Resources"

# Create Info.plist
cat > "$APP_DIR/Contents/Info.plist" << EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>CFBundleExecutable</key>
    <string>NEXUS Dashboard</string>
    <key>CFBundleIdentifier</key>
    <string>com.nexus.dashboard</string>
    <key>CFBundleName</key>
    <string>NEXUS Dashboard</string>
    <key>CFBundleVersion</key>
    <string>1.0</string>
    <key>CFBundleShortVersionString</key>
    <string>1.0</string>
    <key>CFBundlePackageType</key>
    <string>APPL</string>
    <key>LSUIElement</key>
    <true/>
    <key>NSHighResolutionCapable</key>
    <true/>
</dict>
</plist>
EOF

# Create executable launcher
cat > "$APP_DIR/Contents/MacOS/NEXUS Dashboard" << 'EOF'
#!/bin/zsh

# NEXUS Dashboard App Launcher
PROJECT_ROOT="/Users/eduardof.giovannini/Desktop/Projects/YABAI"
DASHBOARD_PORT="8501"
DASHBOARD_URL="http://localhost:$DASHBOARD_PORT"

# Start dashboard if not running
if ! curl -s "$DASHBOARD_URL" > /dev/null 2>&1; then
    cd "$PROJECT_ROOT"
    python3 -m streamlit run src/nexus/dashboard/workspace_dashboard.py --server.port=$DASHBOARD_PORT &
    
    # Wait for startup
    for i in {1..15}; do
        if curl -s "$DASHBOARD_URL" > /dev/null 2>&1; then
            break
        fi
        sleep 1
    done
fi

# Open in app mode with Chrome/Safari
if [[ -d "/Applications/Google Chrome.app" ]]; then
    open -na "Google Chrome" --args \
        --app="$DASHBOARD_URL" \
        --window-size=1400,900 \
        --window-position=200,100 \
        --disable-web-security \
        --user-data-dir="/tmp/nexus-dashboard"
elif [[ -d "/Applications/Vivaldi.app" ]]; then
    open -na "Vivaldi" --args \
        --app="$DASHBOARD_URL" \
        --window-size=1400,900 \
        --window-position=200,100
else
    # Fallback to Safari with AppleScript
    osascript -e "
    tell application \"Safari\"
        activate
        make new document with properties {URL:\"$DASHBOARD_URL\"}
        tell front window
            set bounds to {200, 100, 1600, 1000}
        end tell
    end tell
    "
fi

# Configure YABAI for floating
if command -v yabai &> /dev/null; then
    yabai -m rule --add app="Google Chrome" title=".*localhost:$DASHBOARD_PORT.*" manage=off sticky=on
    yabai -m rule --add app="Vivaldi" title=".*localhost:$DASHBOARD_PORT.*" manage=off sticky=on
    yabai -m rule --add app="Safari" title=".*localhost:$DASHBOARD_PORT.*" manage=off sticky=on
fi
EOF

chmod +x "$APP_DIR/Contents/MacOS/NEXUS Dashboard"

# Create icon (using SF Symbols or emoji)
echo "🧠" > "$APP_DIR/Contents/Resources/icon.txt"

echo "✅ Created: $APP_DIR"
echo "🚀 You can now launch NEXUS Dashboard from Applications folder!"
echo "💡 Or run: open '$APP_DIR'"
