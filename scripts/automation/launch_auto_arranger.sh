#!/bin/bash
# 🚀 Launch Auto Window Arranger for YABAI
# This script starts the automatic window arrangement system

# =============================================================================
# 🎯 CONFIGURATION
# =============================================================================

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
AUTO_ARRANGER_SCRIPT="$SCRIPT_DIR/auto_window_arranger.sh"
YABAI_CONFIG="$HOME/.yabairc"

# =============================================================================
# 🔧 FUNCTIONS
# =============================================================================

# Check if YABAI is running
check_yabai() {
    if ! pgrep -x "yabai" > /dev/null; then
        echo "❌ YABAI is not running. Please start YABAI first:"
        echo "   brew services start yabai"
        return 1
    fi
    return 0
}

# Check if jq is installed
check_jq() {
    if ! command -v jq &> /dev/null; then
        echo "❌ jq is not installed. Please install it first:"
        echo "   brew install jq"
        return 1
    fi
    return 0
}

# Setup floating windows
setup_floating_windows() {
    echo "🪟 Setting up floating window rules..."
    
    # Apps that should always float
    local floating_apps=(
        "Terminal"
        "Finder"
        "iTerm2"
        "iTerm"
        "System Settings"
        "System Preferences"
        "Activity Monitor"
        "Console"
        "Calculator"
        "Calendar"
        "Contacts"
        "Preview"
        "Quick Look"
    )
    
    for app in "${floating_apps[@]}"; do
        yabai -m rule --add app="$app" manage=off 2>/dev/null || true
        echo "  ✅ $app set to float"
    done
}

# Start auto arrangement
start_auto_arrangement() {
    echo "🚀 Starting automatic window arrangement..."
    
    # Enable auto_balance
    yabai -m config auto_balance on
    
    # Setup signals for automatic arrangement
    yabai -m signal --add event=window_created action="sleep 0.5 && yabai -m space --balance" 2>/dev/null || true
    yabai -m signal --add event=window_moved action="sleep 0.3 && yabai -m space --balance" 2>/dev/null || true
    yabai -m signal --add event=window_resized action="sleep 0.3 && yabai -m space --balance" 2>/dev/null || true
    
    echo "✅ Auto arrangement signals configured"
}

# Run initial arrangement
run_initial_arrangement() {
    echo "🔄 Running initial window arrangement..."
    
    # Get all displays
    local displays=$(yabai -m query --displays 2>/dev/null | jq -r '.[].index' 2>/dev/null)
    
    if [[ -n "$displays" ]]; then
        for display_id in $displays; do
            echo "  🔍 Checking display $display_id..."
            yabai -m display --focus "$display_id" 2>/dev/null
            yabai -m space --balance 2>/dev/null
        done
        echo "✅ Initial arrangement completed"
    else
        echo "⚠️  Could not detect displays"
    fi
}

# Show status
show_status() {
    echo ""
    echo "📊 Current YABAI Status:"
    echo "========================="
    
    # Check auto_balance setting
    local auto_balance=$(yabai -m config | grep "auto_balance" | awk '{print $2}')
    echo "🔄 Auto Balance: $auto_balance"
    
    # Check active rules
    local floating_rules=$(yabai -m rule --list | grep "manage=off" | wc -l)
    echo "🪟 Floating Window Rules: $floating_rules"
    
    # Check active signals
    local signals=$(yabai -m signal --list | wc -l)
    echo "📡 Active Signals: $((signals - 1))"  # Subtract 1 for header
    
    # Check displays
    local display_count=$(yabai -m query --displays | jq 'length')
    echo "🖥️  Active Displays: $display_count"
}

# =============================================================================
# 🚀 MAIN EXECUTION
# =============================================================================

main() {
    echo "🎯 YABAI Auto Window Arranger Launcher"
    echo "======================================"
    
    # Check prerequisites
    if ! check_yabai; then
        exit 1
    fi
    
    if ! check_jq; then
        exit 1
    fi
    
    echo "✅ Prerequisites check passed"
    echo ""
    
    # Setup floating windows
    setup_floating_windows
    echo ""
    
    # Start auto arrangement
    start_auto_arrangement
    echo ""
    
    # Run initial arrangement
    run_initial_arrangement
    echo ""
    
    # Show status
    show_status
    echo ""
    
    echo "🎉 Auto Window Arranger is now active!"
    echo ""
    echo "📋 What this does:"
    echo "  • Terminal, Finder, and iTerm will always float"
    echo "  • Other windows will automatically arrange when created/moved/resized"
    echo "  • Windows are arranged using BSP (binary space partitioning) layout"
    echo ""
    echo "🔧 Manual commands:"
    echo "  • Arrange current space: yabai -m space --balance"
    echo "  • View rules: yabai -m rule --list"
    echo "  • View signals: yabai -m signal --list"
    echo ""
    echo "🔄 To restart: run this script again"
}

# =============================================================================
# 📱 USAGE
# =============================================================================

case "${1:-}" in
    "status")
        show_status
        ;;
    "arrange")
        run_initial_arrangement
        ;;
    "setup")
        setup_floating_windows
        ;;
    "help"|"-h"|"--help")
        echo "Usage: $0 [command]"
        echo ""
        echo "Commands:"
        echo "  (no args)  Start auto window arranger"
        echo "  status     Show current status"
        echo "  arrange    Run manual arrangement"
        echo "  setup      Setup floating windows only"
        echo "  help       Show this help"
        ;;
    *)
        main
        ;;
esac
