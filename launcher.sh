#!/bin/zsh

# YABAI Workspace Launcher
# Main entry point for the workspace management system

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Function to display main menu
show_main_menu() {
    clear
    echo ""
    echo "${BLUE}🎯 YABAI Workspace Manager${NC}"
    echo "${CYAN}================================${NC}"
    echo ""
    echo "${GREEN}📋 Workspace Profiles${NC}"
    echo "  1) Work Profile (Development & Productivity)"
    echo "  2) Personal Profile (Entertainment & Social)"
    echo "  3) AI Research Profile (AI & ML Development)"
    echo "  4) Daily Routine (Default Setup)"
    echo "  ${BLUE}--- New Profiles ---${NC}"
    echo "  18) 🎨 Content Creation (Video, Design, Writing)"
    echo "  19) 🎮 Gaming & Entertainment"
    echo "  20) 📚 Learning & Education"
    echo "  21) 💼 Business & Meetings"
    echo "  22) 🎯 Focus & Deep Work"
    echo ""
    echo "${GREEN}🛠️  Management Tools${NC}"
    echo "  5) Interactive Workspace Manager"
    echo "  6) Adaptive Display Detector (1-3 displays)"
    echo "  7) Enhanced AI Integration & Optimization"
    echo "  8) AI Model Manager (Python)"
    echo "  9) Screen Time Data Collection"
    echo "  10) Activity Watch Integration"
    echo "  ${BLUE}--- New Tools ---${NC}"
    echo "  23) 🚀 Quick App Launcher"
    echo "  24) 📊 System Performance Monitor"
    echo ""
    echo "${GREEN}📊 Dashboard & Monitoring${NC}"
    echo "  11) Classic Streamlit Dashboard"
    echo "  12) 🧠 NEXUS Interactive Dashboard (NEW)"
    echo "  13) System Status Check"
    echo ""
    echo "${GREEN}⚙️  Configuration${NC}"
    echo "  14) Install YABAI Rules"
    echo "  15) View Current Configuration"
    echo ""
    echo "${GREEN}❓ Help & Information${NC}"
    echo "  16) Show Help"
    echo "  17) About"
    echo ""
    echo "${GREEN}🚪 Exit${NC}"
    echo "  0) Exit"
    echo ""
    echo -n "${YELLOW}Select an option (0-24): ${NC}"
}

# Function to show help
show_help() {
    echo ""
    echo "${BLUE}📖 YABAI Workspace Manager Help${NC}"
    echo "====================================="
    echo ""
    echo "${GREEN}Workspace Profiles:${NC}"
    echo "  • Work Profile: Development tools, IDEs, communication apps"
    echo "  • Personal Profile: Social media, entertainment, personal apps"
    echo "  • AI Research Profile: AI tools, model management, research apps"
    echo "  • Daily Routine: Basic setup with common apps"
    echo ""
    echo "${GREEN}Management Tools:${NC}"
    echo "  • Interactive Manager: Menu-driven workspace switching"
    echo "  • Display Detector: Auto-detect and configure displays"
    echo "  • AI Integration: Smart workspace optimization with your models"
    echo ""
    echo "${GREEN}Dashboard:${NC}"
    echo "  • Streamlit Dashboard: Visual workspace management interface"
    echo "  • System Status: Check YABAI and display status"
    echo ""
    echo "${GREEN}Configuration:${NC}"
    echo "  • Install Rules: Add YABAI rules to your configuration"
    echo "  • View Config: Show current YABAI configuration"
    echo ""
    echo "${YELLOW}Hardware Setup:${NC}"
    echo "  • Left Display: HZ30GAMER 30\" curved"
    echo "  • Center Display: LG ULTRAWIDE 34\" curved"
    echo "  • Right Display: iMac 24\""
    echo ""
    echo "${YELLOW}External Integration:${NC}"
    echo "  • Model Storage: /Volumes/MICRO/models"
    echo "  • AI Tools: Ollama, MLX, LM Studio"
    echo ""
}

# Function to show about information
show_about() {
    echo ""
    echo "${BLUE}ℹ️  About YABAI Workspace Manager${NC}"
    echo "====================================="
    echo ""
    echo "${GREEN}Version:${NC} 1.0.0"
    echo "${GREEN}Author:${NC} AI Assistant"
    echo "${GREEN}Hardware:${NC} Apple M3 iMac with 3 displays"
    echo "${GREEN}Window Manager:${NC} YABAI"
    echo ""
    echo "${CYAN}Features:${NC}"
    echo "  • Multi-display workspace management"
    echo "  • Context-aware workspace profiles"
    echo "  • AI-powered optimization"
    echo "  • Streamlit dashboard interface"
    echo "  • External model collection integration"
    echo ""
    echo "${YELLOW}Display Layout:${NC}"
    echo "  • Left: Browsers & Web Tools"
    echo "  • Center: AI & Development Tools"
    echo "  • Right: Productivity & Communication"
    echo ""
}

# Function to check system status
check_system_status() {
    echo ""
    echo "${BLUE}🔍 System Status Check${NC}"
    echo "========================"
    
    # Check YABAI
    if yabai -m query --displays >/dev/null 2>&1; then
        echo "${GREEN}✅ YABAI: Running${NC}"
    else
        echo "${RED}❌ YABAI: Not running${NC}"
    fi
    
    # Check displays
    DISPLAY_COUNT=$(yabai -m query --displays | jq length 2>/dev/null || echo "0")
    echo "${GREEN}📺 Displays: $DISPLAY_COUNT detected${NC}"
    
    # Check external storage
    if [ -d "/Volumes/MICRO/models" ]; then
        echo "${GREEN}✅ External Models: Available${NC}"
    else
        echo "${YELLOW}⚠️  External Models: Not found${NC}"
    fi
    
    # Check Ollama
    if command -v ollama &> /dev/null; then
        echo "${GREEN}✅ Ollama: Installed${NC}"
    else
        echo "${YELLOW}⚠️  Ollama: Not installed${NC}"
    fi
    
    # Check MLX
    if command -v mlx &> /dev/null; then
        echo "${GREEN}✅ MLX: Installed${NC}"
    else
        echo "${YELLOW}⚠️  MLX: Not installed${NC}"
    fi
    
    echo ""
}

# Function to install YABAI rules
install_rules() {
    echo ""
    echo "${BLUE}📋 Installing YABAI Rules${NC}"
    echo "============================="
    
    if [ -f "$SCRIPT_DIR/yabairc_additions.sh" ]; then
        echo "${YELLOW}Adding rules to ~/.yabai...${NC}"
        cat "$SCRIPT_DIR/yabairc_additions.sh" >> ~/.yabai
        echo "${GREEN}✅ Rules installed successfully!${NC}"
        echo "${YELLOW}Restart YABAI with: yabai --restart-service${NC}"
    else
        echo "${RED}❌ Rules file not found${NC}"
    fi
}

# Function to view current configuration
view_config() {
    echo ""
    echo "${BLUE}📋 Current YABAI Configuration${NC}"
    echo "================================="
    
    echo "${YELLOW}YABAI Rules:${NC}"
    yabai -m rule --list 2>/dev/null || echo "No rules configured"
    
    echo ""
    echo "${YELLOW}Display Layout:${NC}"
    yabai -m query --displays | jq -r '.[] | "Display \(.index): \(.frame.width)x\(.frame.height)"' 2>/dev/null || echo "No display information"
    
    echo ""
    echo "${YELLOW}Active Windows:${NC}"
    yabai -m query --windows | jq -r '.[] | "\(.app): Display \(.display) Space \(.space)"' 2>/dev/null || echo "No window information"
}

# Main function
main() {
    while true; do
        show_main_menu
        read -r choice
        
        case $choice in
            1)
                echo "${GREEN}🚀 Loading Work Profile...${NC}"
                source "$SCRIPT_DIR/configs/profiles/work_profile.sh"
                ;;
            2)
                echo "${GREEN}🚀 Loading Personal Profile...${NC}"
                source "$SCRIPT_DIR/configs/profiles/personal_profile.sh"
                ;;
            3)
                echo "${GREEN}🚀 Loading AI Research Profile...${NC}"
                source "$SCRIPT_DIR/configs/profiles/ai_research_profile.sh"
                ;;
            4)
                echo "${GREEN}🚀 Loading Daily Routine...${NC}"
                source "$SCRIPT_DIR/daily_routine.sh"
                ;;
            5)
                echo "${GREEN}🔄 Starting Interactive Manager...${NC}"
                "$SCRIPT_DIR/scripts/automation/workspace_manager.sh"
                ;;
            6)
                echo "${GREEN}🔍 Running Adaptive Display Detector...${NC}"
                "$SCRIPT_DIR/scripts/adaptive_display_detector.sh"
                ;;
            7)
                echo "${GREEN}🤖 Starting Enhanced AI Integration...${NC}"
                "$SCRIPT_DIR/scripts/ai/enhanced_ai_integration.sh"
                ;;
            8)
                echo "${GREEN}🐍 Starting AI Model Manager...${NC}"
                python3 "$SCRIPT_DIR/scripts/ai/ai_model_manager.py"
                ;;
            9)
                echo "${GREEN}📊 Starting Screen Time Collection...${NC}"
                "$SCRIPT_DIR/scripts/analytics/screen_time_collector.sh"
                ;;
            10)
                echo "${GREEN}📈 Starting Activity Watch Integration...${NC}"
                "$SCRIPT_DIR/scripts/analytics/activity_watch_integration.sh"
                ;;
            11)
                echo "${GREEN}📊 Starting Classic Dashboard...${NC}"
                echo "${YELLOW}Opening dashboard at http://localhost:8501${NC}"
                cd "$SCRIPT_DIR" && python3 -m streamlit run src/nexus/dashboard/workspace_dashboard.py
                ;;
            12)
                echo "${GREEN}🧠 Starting NEXUS Interactive Dashboard...${NC}"
                echo "${YELLOW}Opening Neural Workspace Intelligence at http://localhost:8502${NC}"
                cd "$SCRIPT_DIR" && python3 -m streamlit run src/nexus/dashboard/interactive_dashboard.py --server.port=8502
                ;;
            13)
                check_system_status
                ;;
            14)
                install_rules
                ;;
            15)
                view_config
                ;;
            16)
                show_help
                ;;
            17)
                show_about
                ;;
            18)
                echo "${GREEN}🎨 Loading Content Creation Profile...${NC}"
                source "$SCRIPT_DIR/configs/profiles/content_creation_profile.sh"
                ;;
            19)
                echo "${GREEN}🎮 Loading Gaming Profile...${NC}"
                source "$SCRIPT_DIR/configs/profiles/gaming_profile.sh"
                ;;
            20)
                echo "${GREEN}📚 Loading Learning Profile...${NC}"
                source "$SCRIPT_DIR/configs/profiles/learning_profile.sh"
                ;;
            21)
                echo "${GREEN}💼 Loading Business Profile...${NC}"
                source "$SCRIPT_DIR/configs/profiles/business_profile.sh"
                ;;
            22)
                echo "${GREEN}🎯 Loading Focus Profile...${NC}"
                source "$SCRIPT_DIR/configs/profiles/focus_profile.sh"
                ;;
            23)
                echo "${GREEN}🚀 Starting Quick App Launcher...${NC}"
                "$SCRIPT_DIR/scripts/quick_app_launcher.sh"
                ;;
            24)
                echo "${GREEN}📊 Running System Performance Monitor...${NC}"
                "$SCRIPT_DIR/scripts/system_performance_monitor.sh"
                ;;
            0)
                echo "${GREEN}👋 Goodbye!${NC}"
                exit 0
                ;;
            *)
                echo "${RED}❌ Invalid option. Please try again.${NC}"
                ;;
        esac
        
        echo ""
        echo -n "${YELLOW}Press Enter to continue...${NC}"
        read -r
    done
}

# Run main function
main 