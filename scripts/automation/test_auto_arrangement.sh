#!/bin/bash
# 🧪 Test Auto Window Arrangement for YABAI
# This script tests the automatic window arrangement system

# =============================================================================
# 🎯 TEST FUNCTIONS
# =============================================================================

# Test floating window rules
test_floating_rules() {
    echo "🧪 Testing floating window rules..."
    
    local floating_apps=("Terminal" "Finder" "iTerm2" "iTerm")
    local passed=0
    local total=${#floating_apps[@]}
    
    for app in "${floating_apps[@]}"; do
        if yabai -m rule --list | grep -q "app=$app.*manage=off"; then
            echo "  ✅ $app is set to float"
            ((passed++))
        else
            echo "  ❌ $app is NOT set to float"
        fi
    done
    
    echo "  📊 Floating rules: $passed/$total passed"
    return $((passed == total ? 0 : 1))
}

# Test auto_balance setting
test_auto_balance() {
    echo "🧪 Testing auto_balance setting..."
    
    local auto_balance=$(yabai -m config | grep "auto_balance" | awk '{print $2}')
    
    if [[ "$auto_balance" == "on" ]]; then
        echo "  ✅ auto_balance is ON"
        return 0
    else
        echo "  ❌ auto_balance is OFF (should be ON)"
        return 1
    fi
}

# Test signals
test_signals() {
    echo "🧪 Testing auto-arrangement signals..."
    
    local signals=$(yabai -m signal --list | grep -E "(window_created|window_moved|window_resized)" | wc -l)
    
    if [[ "$signals" -ge 3 ]]; then
        echo "  ✅ Found $signals auto-arrangement signals"
        return 0
    else
        echo "  ❌ Found only $signals signals (should be 3+)"
        return 1
    fi
}

# Test window counting
test_window_counting() {
    echo "🧪 Testing window counting..."
    
    if ! command -v jq &> /dev/null; then
        echo "  ⚠️  jq not installed, skipping window counting test"
        return 0
    fi
    
    local displays=$(yabai -m query --displays 2>/dev/null | jq -r '.[].index' 2>/dev/null)
    
    if [[ -n "$displays" ]]; then
        echo "  ✅ Found displays: $displays"
        for display_id in $displays; do
            local window_count=$(yabai -m query --windows --display "$display_id" 2>/dev/null | jq 'length')
            echo "    📱 Display $display_id: $window_count windows"
        done
        return 0
    else
        echo "  ❌ Could not detect displays"
        return 1
    fi
}

# Test manual arrangement
test_manual_arrangement() {
    echo "🧪 Testing manual window arrangement..."
    
    local current_space=$(yabai -m query --spaces --space | jq -r '.index')
    echo "  📍 Current space: $current_space"
    
    # Try to balance the current space
    if yabai -m space --balance 2>/dev/null; then
        echo "  ✅ Manual arrangement successful"
        return 0
    else
        echo "  ❌ Manual arrangement failed"
        return 1
    fi
}

# =============================================================================
# 🚀 MAIN TEST EXECUTION
# =============================================================================

main() {
    echo "🧪 YABAI Auto Window Arrangement Test Suite"
    echo "==========================================="
    echo ""
    
    local total_tests=5
    local passed_tests=0
    
    # Run all tests
    test_floating_rules && ((passed_tests++))
    echo ""
    
    test_auto_balance && ((passed_tests++))
    echo ""
    
    test_signals && ((passed_tests++))
    echo ""
    
    test_window_counting && ((passed_tests++))
    echo ""
    
    test_manual_arrangement && ((passed_tests++))
    echo ""
    
    # Show results
    echo "📊 Test Results: $passed_tests/$total_tests passed"
    echo ""
    
    if [[ "$passed_tests" -eq "$total_tests" ]]; then
        echo "🎉 All tests passed! Auto window arrangement is working correctly."
        echo ""
        echo "📋 What's working:"
        echo "  • Terminal, Finder, and iTerm are floating"
        echo "  • Auto-balance is enabled"
        echo "  • Auto-arrangement signals are active"
        echo "  • Window counting is functional"
        echo "  • Manual arrangement works"
    else
        echo "⚠️  Some tests failed. Please check the configuration:"
        echo "  • Run: scripts/launch_auto_arranger.sh"
        echo "  • Check: yabai -m rule --list"
        echo "  • Check: yabai -m signal --list"
        echo "  • Check: yabai -m config"
    fi
}

# =============================================================================
# 📱 USAGE
# =============================================================================

case "${1:-}" in
    "help"|"-h"|"--help")
        echo "Usage: $0 [command]"
        echo ""
        echo "Commands:"
        echo "  (no args)  Run all tests"
        echo "  help       Show this help"
        echo ""
        echo "This script tests the auto window arrangement system."
        ;;
    *)
        main
        ;;
esac
