#!/bin/zsh
# 🧪 NEXUS YABAI Setup Test Script
# Tests if YABAI and SKHD are working correctly

set -euo pipefail

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo "🧪 Testing NEXUS YABAI Setup..."
echo "=================================="
echo ""

# Test 1: Check if YABAI is running
echo "1️⃣ Testing YABAI service..."
if pgrep -f "yabai" >/dev/null 2>&1; then
    echo -e "${GREEN}✅ YABAI is running${NC}"
else
    echo -e "${RED}❌ YABAI is not running${NC}"
    exit 1
fi

# Test 2: Check if SKHD is running
echo "2️⃣ Testing SKHD service..."
if pgrep -f "skhd" >/dev/null 2>&1; then
    echo -e "${GREEN}✅ SKHD is running${NC}"
else
    echo -e "${RED}❌ SKHD is not running${NC}"
    exit 1
fi

# Test 3: Test YABAI window query
echo "3️⃣ Testing YABAI window detection..."
if yabai -m query --windows >/dev/null 2>&1; then
    echo -e "${GREEN}✅ YABAI can detect windows${NC}"
    local window_count=$(yabai -m query --windows | jq 'length' 2>/dev/null || echo "unknown")
    echo "   Windows detected: $window_count"
else
    echo -e "${RED}❌ YABAI cannot detect windows${NC}"
    exit 1
fi

# Test 4: Test YABAI space query
echo "4️⃣ Testing YABAI space detection..."
if yabai -m query --spaces >/dev/null 2>&1; then
    echo -e "${GREEN}✅ YABAI can detect spaces${NC}"
    local space_count=$(yabai -m query --spaces | jq 'length' 2>/dev/null || echo "unknown")
    echo "   Spaces detected: $space_count"
else
    echo -e "${RED}❌ YABAI cannot detect spaces${NC}"
    exit 1
fi

# Test 5: Test SKHD configuration
echo "5️⃣ Testing SKHD configuration..."
if [[ -f "$HOME/.skhdrc" ]]; then
    echo -e "${GREEN}✅ SKHD configuration file exists${NC}"
    local hotkey_count=$(grep -c "^[a-z]" "$HOME/.skhdrc" 2>/dev/null || echo "unknown")
    echo "   Hotkeys configured: $hotkey_count"
else
    echo -e "${RED}❌ SKHD configuration file missing${NC}"
    exit 1
fi

# Test 6: Test basic YABAI commands
echo "6️⃣ Testing basic YABAI commands..."
if yabai -m space --layout bsp >/dev/null 2>&1; then
    echo -e "${GREEN}✅ YABAI layout commands working${NC}"
else
    echo -e "${YELLOW}⚠️ YABAI layout commands may have issues${NC}"
fi

echo ""
echo -e "${GREEN}🎉 All tests completed!${NC}"
echo ""
echo "🎯 Your YABAI + SKHD setup is working!"
echo ""
echo "📋 Try these hotkeys:"
echo "   • Cmd+Shift+H/J/K/L: Focus windows"
echo "   • Ctrl+Cmd+1-5: Switch spaces"
echo "   • Cmd+Shift+F: Toggle float"
echo ""
echo "🚀 Next steps:"
echo "   1. Test the hotkeys above"
echo "   2. Customize your workspace layout"
echo "   3. Set up your NEXUS profiles"
echo "   4. Start the NEXUS dashboard"
echo ""
echo "🔧 If you need to restart services:"
echo "   yabai --restart-service"
echo "   pkill skhd && skhd &"
