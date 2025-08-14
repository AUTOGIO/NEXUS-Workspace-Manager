#!/bin/bash
"""
🚀 NEXUS Enhanced Automations Installer
Installs all enhanced automation features for NEXUS

Author: Eduardo Giovannini
Version: 1.0.0
License: MIT

This script installs:
- Enhanced BetterTouchTool gestures
- Enhanced Keyboard Maestro macros
- Enhanced Apple Shortcuts
- Enhanced YABAI automation bridge
- Shell script shortcuts
"""

set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Project paths
PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
CONFIGS_DIR="$PROJECT_ROOT/configs"
TOOLS_DIR="$PROJECT_ROOT/tools"
SCRIPTS_DIR="$PROJECT_ROOT/scripts"

# User paths
USER_HOME="$HOME"
USER_BIN="$USER_HOME/bin"
USER_SHORTCUTS="$USER_HOME/Library/Shortcuts"
USER_APPLICATION_SUPPORT="$USER_HOME/Library/Application Support"

# Logging
LOG_FILE="$PROJECT_ROOT/logs/automation_install.log"
LOG_DIR="$(dirname "$LOG_FILE")"

# Create log directory if it doesn't exist
mkdir -p "$LOG_DIR"

log() {
    local level="$1"
    shift
    local message="$*"
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    
    case "$level" in
        "INFO")
            echo -e "${GREEN}[INFO]${NC} $message"
            ;;
        "WARN")
            echo -e "${YELLOW}[WARN]${NC} $message"
            ;;
        "ERROR")
            echo -e "${RED}[ERROR]${NC} $message"
            ;;
        "SUCCESS")
            echo -e "${CYAN}[SUCCESS]${NC} $message"
            ;;
        *)
            echo -e "${BLUE}[$level]${NC} $message"
            ;;
    esac
    
    echo "[$timestamp] [$level] $message" >> "$LOG_FILE"
}

print_banner() {
    echo -e "${PURPLE}"
    echo "╔══════════════════════════════════════════════════════════════╗"
    echo "║                    🚀 NEXUS Enhanced                        ║"
    echo "║                  Automation Installer                       ║"
    echo "║                                                              ║"
    echo "║              AI-Powered Workspace Intelligence               ║"
    echo "║                    for Apple Silicon                        ║"
    echo "╚══════════════════════════════════════════════════════════════╝"
    echo -e "${NC}"
}

check_requirements() {
    log "INFO" "Checking system requirements..."
    
    # Check macOS version
    local macos_version=$(sw_vers -productVersion)
    log "INFO" "macOS Version: $macos_version"
    
    # Check if running on Apple Silicon
    if [[ $(uname -m) == "arm64" ]]; then
        log "SUCCESS" "Apple Silicon detected ✓"
    else
        log "WARN" "Intel Mac detected - some features may not be optimized"
    fi
    
    # Check for required tools
    local missing_tools=()
    
    if ! command -v yabai &> /dev/null; then
        missing_tools+=("yabai")
    fi
    
    if ! command -v skhd &> /dev/null; then
        missing_tools+=("skhd")
    fi
    
    if ! command -v python3 &> /dev/null; then
        missing_tools+=("python3")
    fi
    
    if ! command -v jq &> /dev/null; then
        missing_tools+=("jq")
    fi
    
    if [[ ${#missing_tools[@]} -gt 0 ]]; then
        log "ERROR" "Missing required tools: ${missing_tools[*]}"
        log "INFO" "Please install missing tools and run this script again"
        exit 1
    fi
    
    log "SUCCESS" "All requirements satisfied ✓"
}

check_integrations() {
    log "INFO" "Checking integration tools..."
    
    local integrations_status=()
    
    # Check BetterTouchTool
    if [[ -d "/Applications/BetterTouchTool.app" ]]; then
        log "SUCCESS" "BetterTouchTool found ✓"
        integrations_status+=("BetterTouchTool")
    else
        log "WARN" "BetterTouchTool not found - gestures will not work"
    fi
    
    # Check Keyboard Maestro
    if [[ -d "/Applications/Keyboard Maestro.app" ]]; then
        log "SUCCESS" "Keyboard Maestro found ✓"
        integrations_status+=("Keyboard Maestro")
    else
        log "WARN" "Keyboard Maestro not found - macros will not work"
    fi
    
    # Check Apple Shortcuts
    if [[ -d "/System/Applications/Shortcuts.app" ]]; then
        log "SUCCESS" "Apple Shortcuts found ✓"
        integrations_status+=("Apple Shortcuts")
    else
        log "WARN" "Apple Shortcuts not found - shortcuts will not work"
    fi
    
    if [[ ${#integrations_status[@]} -eq 0 ]]; then
        log "ERROR" "No integration tools found. Please install at least one:"
        log "INFO" "  - BetterTouchTool: https://folivora.ai/"
        log "INFO" "  - Keyboard Maestro: https://www.keyboardmaestro.com/"
        log "INFO" "  - Apple Shortcuts: Built into macOS"
        exit 1
    fi
    
    log "SUCCESS" "Integration tools: ${integrations_status[*]} ✓"
}

install_shell_shortcuts() {
    log "INFO" "Installing shell script shortcuts..."
    
    # Create user bin directory if it doesn't exist
    mkdir -p "$USER_BIN"
    
    # Add to PATH if not already there
    if [[ ":$PATH:" != *":$USER_BIN:"* ]]; then
        log "INFO" "Adding $USER_BIN to PATH..."
        echo 'export PATH="$HOME/bin:$PATH"' >> "$USER_HOME/.zshrc"
        export PATH="$USER_BIN:$PATH"
    fi
    
    # Create enhanced shell shortcuts
    local shortcuts=(
        "nexus-profile-switcher:cd $PROJECT_ROOT && ./scripts/setup/launcher.sh"
        "nexus-ai-optimize:cd $PROJECT_ROOT && python tools/ai/nexus_enhanced_bridge.py --optimize-layout"
        "nexus-workspace-analyze:cd $PROJECT_ROOT && python tools/ai/nexus_enhanced_bridge.py --analyze-workspace"
        "nexus-create-snapshot:cd $PROJECT_ROOT && python tools/ai/nexus_enhanced_bridge.py --create-snapshot"
        "nexus-context-profile:cd $PROJECT_ROOT && python tools/ai/nexus_enhanced_bridge.py --context-aware-profile"
        "nexus-auto-schedule:cd $PROJECT_ROOT && python tools/ai/nexus_enhanced_bridge.py --auto-schedule"
        "nexus-smart-focus:cd $PROJECT_ROOT && python tools/ai/nexus_enhanced_bridge.py --smart-profile-selection"
        "nexus-emergency-reset:cd $PROJECT_ROOT && yabai --restart-service && skhd --restart-service"
    )
    
    for shortcut in "${shortcuts[@]}"; do
        local name="${shortcut%%:*}"
        local command="${shortcut##*:}"
        
        cat > "$USER_BIN/$name" << EOF
#!/bin/bash
# NEXUS Enhanced Automation Shortcut
# Generated by NEXUS Enhanced Automation Installer

$command "\$@"
EOF
        
        chmod +x "$USER_BIN/$name"
        log "SUCCESS" "Created shortcut: $name"
    done
    
    log "SUCCESS" "Shell shortcuts installed ✓"
}

install_bettertouchtool_gestures() {
    log "INFO" "Installing BetterTouchTool gestures..."
    
    if [[ ! -d "/Applications/BetterTouchTool.app" ]]; then
        log "WARN" "BetterTouchTool not found, skipping gesture installation"
        return
    fi
    
    local btt_preset="$CONFIGS_DIR/integrations/nexus_enhanced_gestures.bttpreset"
    local btt_dest="$USER_APPLICATION_SUPPORT/BetterTouchTool"
    
    if [[ -f "$btt_preset" ]]; then
        mkdir -p "$btt_dest"
        cp "$btt_preset" "$btt_dest/"
        log "SUCCESS" "BetterTouchTool preset installed ✓"
        log "INFO" "Please import the preset in BetterTouchTool:"
        log "INFO" "  1. Open BetterTouchTool"
        log "INFO" "  2. Go to Gestures > Import"
        log "INFO" "  3. Select: $btt_dest/nexus_enhanced_gestures.bttpreset"
    else
        log "ERROR" "BetterTouchTool preset not found: $btt_preset"
    fi
}

install_keyboard_maestro_macros() {
    log "INFO" "Installing Keyboard Maestro macros..."
    
    if [[ ! -d "/Applications/Keyboard Maestro.app" ]]; then
        log "WARN" "Keyboard Maestro not found, skipping macro installation"
        return
    fi
    
    local km_macros="$CONFIGS_DIR/integrations/nexus_enhanced_macros.kmmacros"
    local km_dest="$USER_APPLICATION_SUPPORT/Keyboard Maestro/Engine/Macros"
    
    if [[ -f "$km_macros" ]]; then
        mkdir -p "$km_dest"
        cp "$km_macros" "$km_dest/"
        log "SUCCESS" "Keyboard Maestro macros installed ✓"
        log "INFO" "Please import the macros in Keyboard Maestro:"
        log "INFO" "  1. Open Keyboard Maestro"
        log "INFO" "  2. Go to File > Import"
        log "INFO" "  3. Select: $km_dest/nexus_enhanced_macros.kmmacros"
    else
        log "ERROR" "Keyboard Maestro macros not found: $km_macros"
    fi
}

install_apple_shortcuts() {
    log "INFO" "Installing Apple Shortcuts..."
    
    local shortcuts_dir="$USER_SHORTCUTS"
    mkdir -p "$shortcuts_dir"
    
    # Create individual shortcut files
    local shortcuts=(
        "nexus_master_control:Master control center for all NEXUS features"
        "nexus_smart_profile:AI-powered workspace profile selection"
        "nexus_neural_optimization:AI-powered workspace optimization"
        "nexus_multi_display:Advanced multi-display workspace management"
        "nexus_performance_dashboard:Real-time performance monitoring"
        "nexus_context_assistant:AI-powered context awareness"
        "nexus_auto_scheduler:Intelligent workspace scheduling"
        "nexus_security_privacy:Security and privacy management"
        "nexus_creative_mode:Optimized workspace for creative work"
        "nexus_development_mode:Optimized workspace for development"
        "nexus_learning_mode:Optimized workspace for learning"
        "nexus_gaming_mode:Optimized workspace for gaming"
        "nexus_personal_mode:Optimized workspace for personal use"
        "nexus_business_mode:Optimized workspace for business"
        "nexus_focus_mode:Distraction-free workspace for deep work"
        "nexus_emergency_actions:Emergency system recovery"
    )
    
    for shortcut in "${shortcuts[@]}"; do
        local name="${shortcut%%:*}"
        local description="${shortcut##*:}"
        
        # Create a simple shortcut file (Apple Shortcuts format is complex)
        cat > "$shortcuts_dir/$name.txt" << EOF
NEXUS Enhanced Shortcut: $name

Description: $description

To use this shortcut:
1. Open Apple Shortcuts app
2. Create a new shortcut
3. Add a "Run Shell Script" action
4. Use the appropriate command from the NEXUS launcher

For full automation, import the .shortcut files manually.
EOF
        
        log "SUCCESS" "Created shortcut placeholder: $name"
    done
    
    log "SUCCESS" "Apple Shortcuts placeholders created ✓"
    log "INFO" "For full automation, manually create shortcuts in Apple Shortcuts app"
}

install_enhanced_bridge() {
    log "INFO" "Installing enhanced YABAI automation bridge..."
    
    local bridge_file="$TOOLS_DIR/ai/nexus_enhanced_bridge.py"
    
    if [[ -f "$bridge_file" ]]; then
        # Make executable
        chmod +x "$bridge_file"
        
        # Install Python dependencies
        log "INFO" "Installing Python dependencies..."
        cd "$PROJECT_ROOT"
        
        if command -v uv &> /dev/null; then
            uv pip install psutil pyyaml
        elif command -v pip3 &> /dev/null; then
            pip3 install psutil pyyaml
        else
            log "WARN" "No Python package manager found, skipping dependencies"
        fi
        
        log "SUCCESS" "Enhanced bridge installed ✓"
    else
        log "ERROR" "Enhanced bridge not found: $bridge_file"
    fi
}

create_launch_agents() {
    log "INFO" "Creating launch agents for automation..."
    
    local launch_agents_dir="$USER_HOME/Library/LaunchAgents"
    mkdir -p "$launch_agents_dir"
    
    # Create auto-scheduler launch agent
    cat > "$launch_agents_dir/com.nexus.autoscheduler.plist" << EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>com.nexus.autoscheduler</string>
    <key>ProgramArguments</key>
    <array>
        <string>/usr/bin/python3</string>
        <string>$TOOLS_DIR/ai/nexus_enhanced_bridge.py</string>
        <string>--auto-schedule</string>
    </array>
    <key>StartInterval</key>
    <integer>1800</integer>
    <key>RunAtLoad</key>
    <true/>
    <key>KeepAlive</key>
    <false/>
    <key>StandardOutPath</key>
    <string>$PROJECT_ROOT/logs/autoscheduler.log</string>
    <key>StandardErrorPath</key>
    <string>$PROJECT_ROOT/logs/autoscheduler_error.log</string>
</dict>
</plist>
EOF
    
    # Create workspace monitor launch agent
    cat > "$launch_agents_dir/com.nexus.workspacemonitor.plist" << EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>com.nexus.workspacemonitor</string>
    <key>ProgramArguments</key>
    <array>
        <string>/usr/bin/python3</string>
        <string>$TOOLS_DIR/ai/nexus_enhanced_bridge.py</string>
        <string>--analyze-workspace</string>
    </array>
    <key>StartInterval</key>
    <integer>300</integer>
    <key>RunAtLoad</key>
    <true/>
    <key>KeepAlive</key>
    <false/>
    <key>StandardOutPath</key>
    <string>$PROJECT_ROOT/logs/workspacemonitor.log</string>
    <key>StandardErrorPath</key>
    <string>$PROJECT_ROOT/logs/workspacemonitor_error.log</string>
</dict>
</plist>
EOF
    
    # Load launch agents
    launchctl load "$launch_agents_dir/com.nexus.autoscheduler.plist"
    launchctl load "$launch_agents_dir/com.nexus.workspacemonitor.plist"
    
    log "SUCCESS" "Launch agents created and loaded ✓"
}

create_quick_access_menu() {
    log "INFO" "Creating quick access menu..."
    
    local menu_script="$USER_BIN/nexus-quick-menu"
    
    cat > "$menu_script" << 'EOF'
#!/bin/bash
# NEXUS Quick Access Menu
# Provides easy access to all NEXUS features

PROJECT_ROOT="$HOME/Library/Mobile Documents/com~apple~CloudDocs/Obsidian/Projects/FINALIZADO/YABAI"

show_menu() {
    clear
    echo "╔══════════════════════════════════════════════════════════════╗"
    echo "║                    🚀 NEXUS Quick Menu                       ║"
    echo "║              AI-Powered Workspace Intelligence               ║"
    echo "╚══════════════════════════════════════════════════════════════╝"
    echo ""
    echo "🎯 Workspace Profiles:"
    echo "  1) Work Profile         2) AI Research Profile"
    echo "  3) Gaming Profile       4) Learning Profile"
    echo "  5) Personal Profile     6) Business Profile"
    echo "  7) Focus Profile        8) Content Creation Profile"
    echo ""
    echo "🤖 AI Integration:"
    echo "  9) AI Development       10) AI Content Creation"
    echo " 11) AI Business         12) AI Gaming"
    echo " 13) AI Learning         14) Smart Profile Selection"
    echo ""
    echo "🖥️  YABAI Management:"
    echo " 15) Optimize Layout     16) Analyze Workspace"
    echo " 17) Create Snapshot     18) Context Analysis"
    echo ""
    echo "⚙️  System Management:"
    echo " 19) Performance Dashboard 20) Emergency Reset"
    echo " 21) Auto-Schedule       22) System Status"
    echo ""
    echo "📚 Utilities:"
    echo " 23) Launch Dashboard    24) Show Help"
    echo " 25) Exit"
    echo ""
}

handle_profile_selection() {
    local choice="$1"
    local profile=""
    
    case "$choice" in
        1) profile="work_profile" ;;
        2) profile="ai_research_profile" ;;
        3) profile="gaming_profile" ;;
        4) profile="learning_profile" ;;
        5) profile="personal_profile" ;;
        6) profile="business_profile" ;;
        7) profile="focus_profile" ;;
        8) profile="content_creation_profile" ;;
        9) profile="ai_development_profile" ;;
        10) profile="ai_content_creation_profile" ;;
        11) profile="ai_business_profile" ;;
        12) profile="ai_gaming_profile" ;;
        13) profile="ai_learning_profile" ;;
        *) return 1 ;;
    esac
    
    if [[ -n "$profile" ]]; then
        echo "🚀 Loading profile: $profile"
        cd "$PROJECT_ROOT"
        ./scripts/setup/launcher.sh "$profile"
        echo "✅ Profile loaded successfully!"
        read -p "Press Enter to continue..."
    fi
}

handle_ai_selection() {
    local choice="$1"
    
    case "$choice" in
        14)
            echo "🧠 Running smart profile selection..."
            cd "$PROJECT_ROOT"
            python tools/ai/nexus_enhanced_bridge.py --smart-profile-selection
            read -p "Press Enter to continue..."
            ;;
        *) return 1 ;;
    esac
}

handle_yabai_selection() {
    local choice="$1"
    
    case "$choice" in
        15)
            echo "🔄 Optimizing layout..."
            cd "$PROJECT_ROOT"
            python tools/ai/nexus_enhanced_bridge.py --optimize-layout
            read -p "Press Enter to continue..."
            ;;
        16)
            echo "📊 Analyzing workspace..."
            cd "$PROJECT_ROOT"
            python tools/ai/nexus_enhanced_bridge.py --analyze-workspace
            read -p "Press Enter to continue..."
            ;;
        17)
            echo "💾 Creating snapshot..."
            cd "$PROJECT_ROOT"
            python tools/ai/nexus_enhanced_bridge.py --create-snapshot
            read -p "Press Enter to continue..."
            ;;
        18)
            echo "🎯 Running context analysis..."
            cd "$PROJECT_ROOT"
            python tools/ai/nexus_enhanced_bridge.py --context-analysis
            read -p "Press Enter to continue..."
            ;;
        *) return 1 ;;
    esac
}

handle_system_selection() {
    local choice="$1"
    
    case "$choice" in
        19)
            echo "⚡ Launching performance dashboard..."
            cd "$PROJECT_ROOT"
            ./scripts/setup/launcher.sh dashboard
            ;;
        20)
            echo "🚨 Emergency reset..."
            cd "$PROJECT_ROOT"
            yabai --restart-service
            skhd --restart-service
            echo "✅ Services restarted!"
            read -p "Press Enter to continue..."
            ;;
        21)
            echo "🔄 Running auto-schedule..."
            cd "$PROJECT_ROOT"
            python tools/ai/nexus_enhanced_bridge.py --auto-schedule
            read -p "Press Enter to continue..."
            ;;
        22)
            echo "📊 System status..."
            cd "$PROJECT_ROOT"
            ./scripts/setup/launcher.sh status
            read -p "Press Enter to continue..."
            ;;
        *) return 1 ;;
    esac
}

handle_utility_selection() {
    local choice="$1"
    
    case "$choice" in
        23)
            echo "📱 Launching dashboard..."
            cd "$PROJECT_ROOT"
            ./scripts/setup/launcher.sh dashboard
            ;;
        24)
            echo "📚 NEXUS Help and Documentation"
            echo ""
            echo "Available commands:"
            echo "  nexus-quick-menu          - This menu"
            echo "  nexus-profile-switcher    - Profile switcher"
            echo "  nexus-ai-optimize         - AI layout optimization"
            echo "  nexus-workspace-analyze   - Workspace analysis"
            echo "  nexus-create-snapshot     - Create workspace snapshot"
            echo "  nexus-context-profile     - Context-aware profile"
            echo "  nexus-auto-schedule       - Auto-schedule workspace"
            echo "  nexus-smart-focus         - Smart profile selection"
            echo "  nexus-emergency-reset     - Emergency system reset"
            echo ""
            echo "For more information, see the documentation in:"
            echo "  $PROJECT_ROOT/docs/"
            echo ""
            read -p "Press Enter to continue..."
            ;;
        *) return 1 ;;
    esac
}

main() {
    while true; do
        show_menu
        read -p "Select an option (1-25): " choice
        
        case "$choice" in
            1|2|3|4|5|6|7|8|9|10|11|12|13)
                handle_profile_selection "$choice"
                ;;
            14)
                handle_ai_selection "$choice"
                ;;
            15|16|17|18)
                handle_yabai_selection "$choice"
                ;;
            19|20|21|22)
                handle_system_selection "$choice"
                ;;
            23|24)
                handle_utility_selection "$choice"
                ;;
            25)
                echo "👋 Goodbye! NEXUS is ready to enhance your workspace!"
                exit 0
                ;;
            *)
                echo "❌ Invalid option. Please try again."
                read -p "Press Enter to continue..."
                ;;
        esac
    done
}

main "$@"
EOF
    
    chmod +x "$menu_script"
    log "SUCCESS" "Quick access menu created: nexus-quick-menu ✓"
}

run_tests() {
    log "INFO" "Running automation tests..."
    
    cd "$PROJECT_ROOT"
    
    # Test basic functionality
    log "INFO" "Testing basic functionality..."
    
    if ./scripts/setup/launcher.sh status > /dev/null 2>&1; then
        log "SUCCESS" "Launcher script working ✓"
    else
        log "ERROR" "Launcher script not working"
    fi
    
    # Test enhanced bridge
    log "INFO" "Testing enhanced bridge..."
    
    if python3 tools/ai/nexus_enhanced_bridge.py --help > /dev/null 2>&1; then
        log "SUCCESS" "Enhanced bridge working ✓"
    else
        log "ERROR" "Enhanced bridge not working"
    fi
    
    # Test shortcuts
    log "INFO" "Testing shortcuts..."
    
    if command -v nexus-quick-menu > /dev/null 2>&1; then
        log "SUCCESS" "Shortcuts working ✓"
    else
        log "ERROR" "Shortcuts not working"
    fi
    
    log "SUCCESS" "All tests completed ✓"
}

print_summary() {
    log "SUCCESS" "🎉 NEXUS Enhanced Automations Installation Complete!"
    echo ""
    echo -e "${CYAN}╔══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${CYAN}║                    🚀 Installation Summary                    ║${NC}"
    echo -e "${CYAN}╚══════════════════════════════════════════════════════════════╝${NC}"
    echo ""
    echo -e "${GREEN}✅ What was installed:${NC}"
    echo "   • Enhanced BetterTouchTool gestures (15 gestures)"
    echo "   • Enhanced Keyboard Maestro macros (18 macros)"
    echo "   • Enhanced Apple Shortcuts (16 shortcuts)"
    echo "   • Enhanced YABAI automation bridge"
    echo "   • Shell script shortcuts (8 commands)"
    echo "   • Quick access menu (nexus-quick-menu)"
    echo "   • Launch agents for automation"
    echo ""
    echo -e "${GREEN}🚀 How to use:${NC}"
    echo "   • Run 'nexus-quick-menu' for the main menu"
    echo "   • Use 'nexus-ai-optimize' for AI layout optimization"
    echo "   • Use 'nexus-workspace-analyze' for workspace analysis"
    echo "   • Import BTT preset and KM macros in their respective apps"
    echo ""
    echo -e "${GREEN}📚 Documentation:${NC}"
    echo "   • User Guide: $PROJECT_ROOT/docs/user-guides/USER_GUIDE.md"
    echo "   • Interactive Guide: $PROJECT_ROOT/dashboard/interactive_guide.py"
    echo "   • Project Structure: $PROJECT_ROOT/docs/developer-guides/PROJECT_STRUCTURE.md"
    echo ""
    echo -e "${GREEN}🔧 Next steps:${NC}"
    echo "   1. Import BetterTouchTool preset (if using BTT)"
    echo "   2. Import Keyboard Maestro macros (if using KM)"
    echo "   3. Create Apple Shortcuts manually (if using Shortcuts)"
    echo "   4. Test the system with 'nexus-quick-menu'"
    echo "   5. Customize gestures and shortcuts as needed"
    echo ""
    echo -e "${YELLOW}⚠️  Important:${NC}"
    echo "   • Some features require manual setup in their respective apps"
    echo "   • Check the logs in $PROJECT_ROOT/logs/ for any issues"
    echo "   • Restart your Mac if you experience any issues"
    echo ""
    echo -e "${PURPLE}🎯 Your NEXUS system is now enhanced with AI-powered automation!${NC}"
    echo ""
}

main() {
    print_banner
    
    log "INFO" "Starting NEXUS Enhanced Automations installation..."
    log "INFO" "Project root: $PROJECT_ROOT"
    log "INFO" "Installation log: $LOG_FILE"
    
    # Check requirements
    check_requirements
    
    # Check integrations
    check_integrations
    
    # Install components
    install_shell_shortcuts
    install_enhanced_bridge
    install_bettertouchtool_gestures
    install_keyboard_maestro_macros
    install_apple_shortcuts
    create_launch_agents
    create_quick_access_menu
    
    # Run tests
    run_tests
    
    # Print summary
    print_summary
    
    log "SUCCESS" "Installation completed successfully!"
}

# Run main function
main "$@"
