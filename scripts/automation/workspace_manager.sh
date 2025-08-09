#!/bin/zsh

# YABAI Workspace Manager
# Main script for managing different workspace profiles

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to display menu
show_menu() {
    echo ""
    echo "${BLUE}🎯 YABAI Workspace Manager${NC}"
    echo "================================"
    echo "${GREEN}1)${NC} Work Profile (Development & Productivity)"
    echo "${GREEN}2)${NC} Personal Profile (Entertainment & Social)"
    echo "${GREEN}3)${NC} AI Research Profile (AI & ML Development)"
    echo "${GREEN}4)${NC} Daily Routine (Default Setup)"
    echo "${GREEN}5)${NC} Detect Display Configuration"
    echo "${GREEN}6)${NC} View Current Workspace Status"
    echo "${GREEN}7)${NC} Exit"
    echo ""
    echo -n "Select an option (1-7): "
}

# Function to check if YABAI is running
check_yabai() {
    if ! yabai -m query --displays >/dev/null 2>&1; then
        echo "${RED}⚠️  YABAI is not running. Starting YABAI...${NC}"
        yabai --start-service
        sleep 2
    fi
}

# Function to clear existing rules
clear_rules() {
    echo "${YELLOW}🧹 Clearing existing YABAI rules...${NC}"
    yabai -m rule --remove "*" 2>/dev/null || true
}

# Function to load profile
load_profile() {
    local profile_name=$1
    local profile_script=$2
    
    echo "${BLUE}🔄 Loading $profile_name...${NC}"
    
    # Clear existing rules
    clear_rules
    
    # Load the profile
    source "$profile_script"
    
    echo "${GREEN}✅ $profile_name loaded successfully!${NC}"
}

# Function to show current status
show_status() {
    echo "${BLUE}📊 Current Workspace Status${NC}"
    echo "================================"
    
    # Show active displays
    echo "${YELLOW}Active Displays:${NC}"
    yabai -m query --displays | jq -r '.[] | "Display \(.index): \(.frame.width)x\(.frame.height)"'
    
    echo ""
    echo "${YELLOW}Active Windows:${NC}"
    yabai -m query --windows | jq -r '.[] | "\(.app): Display \(.display) Space \(.space)"'
    
    echo ""
    echo "${YELLOW}YABAI Rules:${NC}"
    yabai -m rule --list
}

# Main script
main() {
    # Check if YABAI is running
    check_yabai
    
    while true; do
        show_menu
        read -r choice
        
        case $choice in
            1)
                load_profile "Work Profile" "workspace_profiles/work_profile.sh"
                ;;
            2)
                load_profile "Personal Profile" "workspace_profiles/personal_profile.sh"
                ;;
            3)
                load_profile "AI Research Profile" "workspace_profiles/ai_research_profile.sh"
                ;;
            4)
                load_profile "Daily Routine" "daily_routine.sh"
                ;;
            5)
                echo "${BLUE}🔍 Detecting display configuration...${NC}"
                ./scripts/display_detector.sh
                ;;
            6)
                show_status
                ;;
            7)
                echo "${GREEN}👋 Goodbye!${NC}"
                exit 0
                ;;
            *)
                echo "${RED}❌ Invalid option. Please try again.${NC}"
                ;;
        esac
        
        echo ""
        echo -n "Press Enter to continue..."
        read -r
    done
}

# Run main function
main 