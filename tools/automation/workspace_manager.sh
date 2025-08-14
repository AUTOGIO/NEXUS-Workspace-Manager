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
    echo "${GREEN}4)${NC} AI Development Profile (AI Coding & Training)"
    echo "${GREEN}5)${NC} AI Content Creation Profile (AI Writing & Design)"
    echo "${GREEN}6)${NC} AI Learning Profile (AI Education & Study)"
    echo "${GREEN}7)${NC} AI Business Profile (AI Business & Automation)"
    echo "${GREEN}8)${NC} AI Gaming Profile (AI Gaming & Streaming)"
    echo "${GREEN}9)${NC} Daily Routine (Default Setup)"
    echo "${GREEN}10)${NC} Detect Display Configuration"
    echo "${GREEN}11)${NC} View Current Workspace Status"
    echo "${GREEN}12)${NC} Exit"
    echo ""
    echo -n "Select an option (1-12): "
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
                load_profile "Work Profile" "configs/profiles/work_profile.sh"
                ;;
            2)
                load_profile "Personal Profile" "configs/profiles/personal_profile.sh"
                ;;
            3)
                load_profile "AI Research Profile" "configs/profiles/ai_research_profile.sh"
                ;;
            4)
                load_profile "AI Development Profile" "configs/profiles/ai_development_profile.sh"
                ;;
            5)
                load_profile "AI Content Creation Profile" "configs/profiles/ai_content_creation_profile.sh"
                ;;
            6)
                load_profile "AI Learning Profile" "configs/profiles/ai_learning_profile.sh"
                ;;
            7)
                load_profile "AI Business Profile" "configs/profiles/ai_business_profile.sh"
                ;;
            8)
                load_profile "AI Gaming Profile" "configs/profiles/ai_gaming_profile.sh"
                ;;
            9)
                load_profile "Daily Routine" "daily_routine.sh"
                ;;
            10)
                echo "${BLUE}🔍 Detecting display configuration...${NC}"
                "$SCRIPT_DIR/../display_detector.sh"
                ;;
            11)
                show_status
                ;;
            12)
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