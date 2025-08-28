#!/bin/bash
# 🚀 YABAI Profile Shortcuts Creator (Simple Version)
# Creates shell scripts that can be easily converted to Apple Shortcuts
# Author: NEXUS Development Team
# Date: 12 Aug 2025

set -e  # Exit on any error

# =============================================================================
# 🎯 CONFIGURATION
# =============================================================================

# Base directory for YABAI profiles
YABAI_BASE_DIR="/Users/eduardof.giovannini/Library/Mobile Documents/com~apple~CloudDocs/Obsidian/Projects/FINALIZADO/YABAI/configs/profiles"

# Output directory for shortcut scripts
SHORTCUTS_DIR="$HOME/Desktop/YABAI_Shortcuts"

# Array of profile scripts to create shortcuts for
PROFILES=(
    "ai_business_profile.sh"
    "ai_content_creation_profile.sh"
    "ai_development_profile.sh"
    "ai_gaming_profile.sh"
    "ai_learning_profile.sh"
    "ai_research_profile.sh"
)

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# =============================================================================
# 🔧 HELPER FUNCTIONS
# =============================================================================

# Print colored output
print_status() {
    local color=$1
    local message=$2
    echo -e "${color}${message}${NC}"
}

# Check if profile script exists and is executable
validate_profile() {
    local profile_path="$1"
    local profile_name="$2"
    
    if [[ ! -f "$profile_path" ]]; then
        print_status $RED "❌ Profile script not found: $profile_path"
        return 1
    fi
    
    if [[ ! -x "$profile_path" ]]; then
        print_status $YELLOW "🔧 Making profile executable: $profile_name"
        chmod +x "$profile_path"
    fi
    
    print_status $GREEN "✅ Profile validated: $profile_name"
    return 0
}

# Create a shortcut script for a profile
create_shortcut_script() {
    local profile_path="$1"
    local profile_name="$2"
    local shortcut_name="${profile_name%.sh}"  # Remove .sh extension
    
    print_status $BLUE "🔄 Creating shortcut script: $shortcut_name"
    
    # Create the shortcut script
    local shortcut_script="$SHORTCUTS_DIR/$shortcut_name.command"
    
    cat > "$shortcut_script" << EOF
#!/bin/bash
# 🚀 YABAI Profile: $shortcut_name
# Auto-generated shortcut script
# Date: $(date)

echo "🚀 Loading YABAI profile: $shortcut_name"
echo "========================================"

# Change to the YABAI project directory
cd "$(dirname "$0")/.."

# Run the profile script
if [ -f "$profile_path" ]; then
    echo "✅ Profile script found, executing..."
    "$profile_path"
    echo "✅ Profile loaded successfully!"
else
    echo "❌ Profile script not found: $profile_path"
    echo "Current directory: \$(pwd)"
    echo "Available profiles:"
    ls -la configs/profiles/*.sh 2>/dev/null || echo "No profiles found"
    exit 1
fi

echo ""
echo "🎉 $shortcut_name profile is now active!"
echo "Press any key to close this window..."
read -n 1
EOF
    
    # Make the script executable
    chmod +x "$shortcut_script"
    
    if [[ $? -eq 0 ]]; then
        print_status $GREEN "✅ Shortcut script created: $shortcut_script"
        return 0
    else
        print_status $RED "❌ Failed to create shortcut script: $shortcut_name"
        return 1
    fi
}

# =============================================================================
# 🚀 MAIN EXECUTION
# =============================================================================

main() {
    print_status $BLUE "🚀 YABAI Profile Shortcuts Creator (Simple)"
    print_status $BLUE "==========================================="
    echo ""
    
    # Validate YABAI base directory
    if [[ ! -d "$YABAI_BASE_DIR" ]]; then
        print_status $RED "❌ YABAI profiles directory not found: $YABAI_BASE_DIR"
        exit 1
    fi
    
    print_status $GREEN "✅ YABAI profiles directory found"
    
    # Create shortcuts directory
    if [[ ! -d "$SHORTCUTS_DIR" ]]; then
        print_status $BLUE "📁 Creating shortcuts directory: $SHORTCUTS_DIR"
        mkdir -p "$SHORTCUTS_DIR"
    fi
    
    print_status $GREEN "✅ Shortcuts directory ready: $SHORTCUTS_DIR"
    echo ""
    
    # Process each profile
    local success_count=0
    local total_count=${#PROFILES[@]}
    
    print_status $BLUE "🔄 Creating shortcut scripts for $total_count profiles..."
    echo ""
    
    for profile in "${PROFILES[@]}"; do
        local profile_path="$YABAI_BASE_DIR/$profile"
        local profile_name="$profile"
        local shortcut_name="${profile_name%.sh}"
        
        print_status $BLUE "🔄 Processing: $shortcut_name"
        
        # Validate profile
        if validate_profile "$profile_path" "$profile_name"; then
            # Create shortcut script
            if create_shortcut_script "$profile_path" "$profile_name"; then
                ((success_count++))
            fi
        fi
        
        echo ""
    done
    
    # Summary
    print_status $BLUE "📊 Summary"
    print_status $BLUE "=========="
    print_status $GREEN "✅ Successfully created: $success_count/$total_count shortcut scripts"
    
    if [[ $success_count -eq $total_count ]]; then
        print_status $GREEN "🎉 All shortcut scripts created successfully!"
    else
        print_status $YELLOW "⚠️  Some shortcut scripts failed to create. Check the output above."
    fi
    
    echo ""
    print_status $BLUE "🔗 Next Steps:"
    print_status $BLUE "1. Check your Desktop for the 'YABAI_Shortcuts' folder"
    print_status $BLUE "2. Double-click any .command file to run the profile"
    print_status $BLUE "3. To create Apple Shortcuts:"
    print_status $BLUE "   a. Open Shortcuts app"
    print_status $BLUE "   b. Create new shortcut"
    print_status $BLUE "   c. Add 'Run Shell Script' action"
    print_status $BLUE "   d. Point to the .command file in YABAI_Shortcuts folder"
    print_status $BLUE "4. Or use the shortcuts CLI: shortcuts run <shortcut_name>"
    echo ""
    print_status $YELLOW "💡 Tip: The .command files can be run directly from Finder!"
}

# =============================================================================
# 📱 USAGE & COMMAND LINE INTERFACE
# =============================================================================

show_usage() {
    echo "Usage: $0 [command]"
    echo ""
    echo "Commands:"
    echo "  (no args)  Create all shortcut scripts"
    echo "  create     Create all shortcut scripts"
    echo "  help       Show this help message"
    echo ""
    echo "Examples:"
    echo "  $0                    # Create all shortcut scripts"
    echo "  $0 create            # Create all shortcut scripts"
    echo ""
    echo "Note: This creates .command files that can be run directly or converted to Apple Shortcuts."
}

# Parse command line arguments
case "${1:-}" in
    "create"|"")
        main
        ;;
    "help"|"-h"|"--help")
        show_usage
        ;;
    *)
        print_status $RED "❌ Unknown command: $1"
        show_usage
        exit 1
        ;;
esac
