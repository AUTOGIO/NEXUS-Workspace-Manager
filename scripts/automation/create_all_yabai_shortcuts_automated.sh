#!/bin/zsh

# =============================================================================
# YABAI Profile Shortcuts Creator - FULLY AUTOMATED
# =============================================================================
# This script creates Apple Shortcuts for all YABAI AI-enhanced profiles
# with minimal human intervention using AppleScript automation.
# =============================================================================

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
SHORTCUTS_DIR="$HOME/Desktop/YABAI_Shortcuts"
SHORTCUTS_APP="/System/Applications/Shortcuts.app"

# Profile configurations
declare -A PROFILES=(
    ["ai_business_profile"]="Business Workflow Optimization"
    ["ai_content_creation_profile"]="Content Creation Setup"
    ["ai_development_profile"]="Development Environment"
    ["ai_gaming_profile"]="Gaming Workspace"
    ["ai_learning_profile"]="Learning Environment"
    ["ai_research_profile"]="Research Workspace"
)

# Icons and colors for each profile
declare -A PROFILE_ICONS=(
    ["ai_business_profile"]="💼"
    ["ai_content_creation_profile"]="✍️"
    ["ai_development_profile"]="💻"
    ["ai_gaming_profile"]="🎮"
    ["ai_learning_profile"]="📚"
    ["ai_research_profile"]="🔬"
)

declare -A PROFILE_COLORS=(
    ["ai_business_profile"]="blue"
    ["ai_content_creation_profile"]="green"
    ["ai_development_profile"]="purple"
    ["ai_gaming_profile"]="orange"
    ["ai_learning_profile"]="yellow"
    ["ai_research_profile"]="red"
)

# =============================================================================
# UTILITY FUNCTIONS
# =============================================================================

print_header() {
    echo -e "\n${BLUE}╔══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${BLUE}║                    YABAI SHORTCUTS CREATOR                    ║${NC}"
    echo -e "${BLUE}║                     FULLY AUTOMATED                          ║${NC}"
    echo -e "${BLUE}╚══════════════════════════════════════════════════════════════╝${NC}\n"
}

print_step() {
    echo -e "${CYAN}🔄 $1${NC}"
}

print_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

print_info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

# =============================================================================
# PREREQUISITE CHECKS
# =============================================================================

check_prerequisites() {
    print_step "Checking prerequisites..."
    
    # Check if Shortcuts app exists
    if [[ ! -d "$SHORTCUTS_APP" ]]; then
        print_error "Shortcuts app not found at $SHORTCUTS_APP"
        print_error "Please install Shortcuts from the App Store or check the path"
        exit 1
    fi
    print_success "Shortcuts app found"
    
    # Check if .command files exist
    if [[ ! -d "$SHORTCUTS_DIR" ]]; then
        print_error "YABAI Shortcuts directory not found at $SHORTCUTS_DIR"
        print_error "Please run create_yabai_shortcuts_simple.sh first"
        exit 1
    fi
    print_success "YABAI Shortcuts directory found"
    
    # Check if all profile scripts exist
    for profile in "${!PROFILES[@]}"; do
        if [[ ! -f "$SHORTCUTS_DIR/${profile}.command" ]]; then
            print_error "Profile script not found: ${profile}.command"
            exit 1
        fi
    done
    print_success "All profile scripts found"
    
    # Check if osascript is available
    if ! command -v osascript &> /dev/null; then
        print_error "osascript not found. This script requires macOS."
        exit 1
    fi
    print_success "osascript available"
}

# =============================================================================
# SHORTCUT MANAGEMENT FUNCTIONS
# =============================================================================

shortcut_exists() {
    local shortcut_name="$1"
    osascript << EOF
    tell application "Shortcuts"
        try
            get shortcut "$shortcut_name"
            return true
        on error
            return false
        end try
    end tell
EOF
}

delete_existing_shortcut() {
    local shortcut_name="$1"
    print_info "Deleting existing shortcut: $shortcut_name"
    
    osascript << EOF
    tell application "Shortcuts"
        try
            delete shortcut "$shortcut_name"
            return true
        on error
            return false
        end try
    end tell
EOF
}

create_profile_shortcut() {
    local profile_name="$1"
    local profile_path="$SHORTCUTS_DIR/${profile_name}.command"
    local shortcut_name="${profile_name//_/ }"
    local description="${PROFILES[$profile_name]}"
    local icon="${PROFILE_ICONS[$profile_name]}"
    local color="${PROFILE_COLORS[$profile_name]}"
    
    print_step "Creating shortcut: $shortcut_name"
    
    # Create the shortcut using AppleScript
    osascript << EOF
    tell application "Shortcuts"
        try
            -- Create new shortcut
            set newShortcut to make new shortcut with properties {name:"$shortcut_name"}
            
            -- Add Run Shell Script action
            set shellAction to make new action in newShortcut
            set action type of shellAction to "Run Shell Script"
            
            -- Configure the shell script action
            set shell path of shellAction to "/bin/bash"
            set script content of shellAction to "$profile_path"
            set pass input of shellAction to "as arguments"
            
            -- Set shortcut properties
            set icon of newShortcut to "$icon"
            set color of newShortcut to "$color"
            
            -- Save the shortcut
            save newShortcut
            
            return true
        on error errorMessage
            log "Error creating shortcut $shortcut_name: " & errorMessage
            return false
        end try
    end tell
EOF
}

# =============================================================================
# MAIN EXECUTION
# =============================================================================

main() {
    print_header
    
    # Check prerequisites
    check_prerequisites
    
    print_info "Starting automated shortcut creation for ${#PROFILES[@]} profiles..."
    print_info "This process will create shortcuts in the Shortcuts app"
    print_info "You may see the Shortcuts app open and close during creation"
    
    # Ask for confirmation
    echo -e "\n${YELLOW}⚠️  IMPORTANT: This script will:${NC}"
    echo -e "   • Open the Shortcuts app automatically"
    echo -e "   • Create/overwrite shortcuts for all YABAI profiles"
    echo -e "   • Require minimal interaction from you"
    echo -e "\n${CYAN}Press Enter to continue or Ctrl+C to cancel...${NC}"
    read -n 1
    
    # Create shortcuts for each profile
    local success_count=0
    local total_count=${#PROFILES[@]}
    
    for profile in "${!PROFILES[@]}"; do
        local shortcut_name="${profile//_/ }"
        
        print_step "Processing: $shortcut_name"
        
        # Check if shortcut already exists
        if shortcut_exists "$shortcut_name"; then
            print_warning "Shortcut '$shortcut_name' already exists"
            if delete_existing_shortcut "$shortcut_name"; then
                print_success "Existing shortcut deleted"
            else
                print_error "Failed to delete existing shortcut"
                continue
            fi
        fi
        
        # Create new shortcut
        if create_profile_shortcut "$profile"; then
            print_success "Shortcut created: $shortcut_name"
            ((success_count++))
        else
            print_error "Failed to create shortcut: $shortcut_name"
        fi
        
        # Small delay to prevent overwhelming the Shortcuts app
        sleep 1
    done
    
    # Final summary
    echo -e "\n${BLUE}╔══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${BLUE}║                    CREATION SUMMARY                          ║${NC}"
    echo -e "${BLUE}╚══════════════════════════════════════════════════════════════╝${NC}"
    echo -e "${GREEN}✅ Successfully created: $success_count/$total_count shortcuts${NC}"
    
    if [[ $success_count -eq $total_count ]]; then
        print_success "All shortcuts created successfully!"
        echo -e "\n${CYAN}🎉 Your YABAI profile shortcuts are now available in the Shortcuts app!${NC}"
        echo -e "${CYAN}   You can find them in the 'All Shortcuts' section.${NC}"
    else
        print_warning "Some shortcuts failed to create. Check the output above for details."
    fi
    
    # Open Shortcuts app to show results
    print_info "Opening Shortcuts app to show your new shortcuts..."
    open "$SHORTCUTS_APP"
}

# =============================================================================
# ERROR HANDLING
# =============================================================================

cleanup_on_error() {
    print_error "An error occurred. Cleaning up..."
    # Close Shortcuts app if it's open
    osascript << EOF
    tell application "Shortcuts"
        quit
    end tell
EOF
    exit 1
}

# Set up error handling
trap cleanup_on_error ERR

# =============================================================================
# SCRIPT EXECUTION
# =============================================================================

# Check if script is being sourced or executed
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
else
    print_info "Script sourced. Call main() to execute."
fi
