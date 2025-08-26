#!/bin/zsh
# 🔄 NEXUS Restart Script
# Restarts all NEXUS services

set -euo pipefail

echo "🔄 Restarting NEXUS Workspace Manager..."
echo "========================================"

# Stop services
echo "🛑 Stopping services..."
pkill yabai 2>/dev/null || true
pkill skhd 2>/dev/null || true

# Wait a moment
sleep 2

# Start services
echo "🚀 Starting services..."

# Start YABAI
if command -v yabai >/dev/null 2>&1; then
    echo "🐟 Starting YABAI..."
    yabai --start-service
    echo "✅ YABAI started"
else
    echo "❌ YABAI not found"
fi

# Start SKHD
if command -v skhd >/dev/null 2>&1; then
    echo "⌨️ Starting SKHD..."
    skhd --config ~/.skhdrc &
    echo "✅ SKHD started"
else
    echo "❌ SKHD not found"
fi

echo ""
echo "🎉 NEXUS restarted successfully!"
echo ""
echo "🧪 Test your shortcuts now:"
echo "   Cmd+Shift+H → Focus left window"
echo "   Cmd+Shift+L → Focus right window"
echo "   Cmd+Shift+J → Focus window below"
echo "   Cmd+Shift+K → Focus window above"
echo ""
echo "🔧 If shortcuts still don't work, check Accessibility permissions in System Settings"
