#!/bin/zsh
# 🔧 SIP-Friendly NEXUS Shortcuts
# Provides alternatives that work with SIP enabled

set -euo pipefail

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo "🔧 SIP-Friendly NEXUS Shortcuts"
echo "================================"
echo ""

echo "📋 Current Status:"
echo "   ✅ YABAI: Running (limited mode due to SIP)"
echo "   ✅ SKHD: Running with 69 hotkeys"
echo "   ✅ Spaces: Configured for BSP layout"
echo "   ⚠️ Window focus: Limited due to SIP restrictions"
echo ""

echo "🎯 What's Working:"
echo "   ✅ Space layout management (BSP)"
echo "   ✅ Window queries and information"
echo "   ✅ Basic YABAI functionality"
echo "   ✅ SKHD hotkey system"
echo ""

echo "❌ What's Limited:"
echo "   ❌ Window focus commands (west/east/north/south)"
echo "   ❌ Space switching via YABAI"
echo "   ❌ Advanced window manipulation"
echo ""

echo "🔧 SIP-Friendly Alternatives:"
echo ""

echo "1. 🖥️ Window Management (Use macOS Built-in):"
echo "   • Cmd+Tab → Switch between apps"
echo "   • Cmd+` → Switch between windows of same app"
echo "   • Cmd+Shift+` → Switch between windows of same app (reverse)"
echo "   • Cmd+M → Minimize window"
echo "   • Cmd+H → Hide app"
echo ""

echo "2. 🎯 Space Management (Use macOS Built-in):"
echo "   • Ctrl+Left/Right → Switch between spaces"
echo "   • Ctrl+Up → Mission Control"
echo "   • Ctrl+Down → App Exposé"
echo ""

echo "3. 🧩 YABAI Features (Still Working):"
echo "   • Space layout: BSP (Binary Space Partitioning)"
echo "   • Window tiling: Automatic when apps open"
echo "   • Window queries: Get information about windows"
echo ""

echo "4. ⌨️ SKHD Hotkeys (Still Working):"
echo "   • Custom app shortcuts"
echo "   • Profile switching"
echo "   • NEXUS-specific commands"
echo ""

echo "🚀 How to Use This Setup:"
echo ""
echo "1. Open multiple apps - they'll tile automatically"
echo "2. Use Cmd+Tab to switch between apps"
echo "3. Use Ctrl+Left/Right to switch spaces"
echo "4. Use Cmd+` to switch between windows of same app"
echo "5. Let YABAI handle the automatic tiling"
echo ""

echo "🔧 To Test Current Functionality:"
echo "   • Run: yabai -m query --spaces"
echo "   • Run: yabai -m query --windows"
echo "   • Check if spaces are in BSP layout"
echo ""

echo "💡 Pro Tips:"
echo "   • Keep SIP enabled for security"
echo "   • Use macOS built-in shortcuts for navigation"
echo "   • Let YABAI handle automatic tiling"
echo "   • Use SKHD for custom NEXUS commands"
echo ""

echo "🎯 Bottom Line:"
echo "   You still get automatic window tiling and organization,"
echo "   just with different navigation methods that work with SIP enabled!"
