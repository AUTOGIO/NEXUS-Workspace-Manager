#!/bin/zsh
# 🚀 NEXUS Start Script
# Starts all NEXUS services

set -euo pipefail

echo "🚀 Starting NEXUS Workspace Manager..."
echo "======================================"

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
    pkill skhd 2>/dev/null || true
    skhd --config "$(dirname "$0")/configs/skhd/skhdrc" &
    echo "✅ SKHD started"
else
    echo "❌ SKHD not found"
fi

# Start NEXUS Dashboard
if command -v streamlit >/dev/null 2>&1; then
    echo "📊 Starting NEXUS Dashboard..."
    cd "$(dirname "$0")/dashboard"
    streamlit run interactive_guide.py &
    echo "✅ Dashboard started"
else
    echo "⚠️ Streamlit not found - dashboard not started"
fi

echo ""
echo "🎉 NEXUS started successfully!"
echo "   YABAI: Window management active"
echo "   SKHD: Hotkeys active"
echo "   Dashboard: Available at http://localhost:8501"
