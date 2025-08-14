#!/bin/zsh
# 🚀 NEXUS Quick App Launcher
# Fast access to your most important apps

set -e

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

show_menu() {
    clear
    echo ""
    echo "${BLUE}🚀 NEXUS Quick Launcher${NC}"
    echo "${BLUE}========================${NC}"
    echo ""
    echo "${GREEN}💻 Development${NC}"
    echo "  1) Cursor (Code Editor)"
    echo "  2) iTerm (Terminal)"
    echo "  3) Visual Studio Code"
    echo ""
    echo "${GREEN}🧠 AI Tools${NC}"
    echo "  4) ChatGPT"
    echo "  5) Grok"
    echo "  6) Perplexity"
    echo "  7) LM Studio"
    echo "  8) Ollama"
    echo ""
    echo "${GREEN}📝 Productivity${NC}"
    echo "  9) Obsidian"
    echo "  10) Notes"
    echo "  11) Microsoft Excel"
    echo "  12) Pages"
    echo ""
    echo "${GREEN}🌐 Browsers${NC}"
    echo "  13) Vivaldi"
    echo "  14) Google Chrome"
    echo "  15) Safari"
    echo ""
    echo "${GREEN}🎨 Creative${NC}"
    echo "  16) Wondershare Filmora"
    echo "  17) PhotoScapeX"
    echo ""
    echo "${GREEN}📊 Monitoring${NC}"
    echo "  18) ActivityWatch"
    echo "  19) iStatistica Pro"
    echo "  20) One Thing (Focus)"
    echo ""
    echo "${GREEN}🛠️  Utilities${NC}"
    echo "  21) System Monitor"
    echo "  22) Caffeine"
    echo "  23) Boom 3D"
    echo ""
    echo "${GREEN}📱 Communication${NC}"
    echo "  24) WhatsApp"
    echo "  25) Telegram"
    echo "  26) Messages"
    echo ""
    echo "${GREEN}🎯 Quick Actions${NC}"
    echo "  30) Launch NEXUS Dashboard"
    echo "  31) Performance Monitor"
    echo "  32) Focus Mode (One Thing + Caffeine)"
    echo ""
    echo "  0) Exit"
    echo ""
    echo -n "${YELLOW}Select an app (0-32): ${NC}"
}

launch_app() {
    case $1 in
        1) echo "🚀 Launching Cursor..." && open -na "/Applications/Cursor.app" ;;
        2) echo "🚀 Launching iTerm..." && open -na "/Applications/iTerm.app" ;;
        3) echo "🚀 Launching VS Code..." && open -na "/Applications/Visual Studio Code.app" ;;
        4) echo "🚀 Launching ChatGPT..." && open -na "/Applications/ChatGPT.app" ;;
        5) echo "🚀 Launching Grok..." && open -na "/Users/eduardof.giovannini/Applications/Grok.app" ;;
        6) echo "🚀 Launching Perplexity..." && open -na "/Applications/Perplexity.app" ;;
        7) echo "🚀 Launching LM Studio..." && open -na "/Applications/LM Studio.app" ;;
        8) echo "🚀 Launching Ollama..." && open -na "/Applications/Ollama.app" ;;
        9) echo "🚀 Launching Obsidian..." && open -na "/Applications/Obsidian.app" ;;
        10) echo "🚀 Launching Notes..." && open -na "/Applications/Notes.app" ;;
        11) echo "🚀 Launching Excel..." && open -na "/Applications/Microsoft Excel.app" ;;
        12) echo "🚀 Launching Pages..." && open -na "/Applications/Pages.app" ;;
        13) echo "🚀 Launching Vivaldi..." && open -na "/Applications/Vivaldi.app" ;;
        14) echo "🚀 Launching Chrome..." && open -na "/Applications/Google Chrome.app" ;;
        15) echo "🚀 Launching Safari..." && open -na "/Applications/Safari.app" ;;
        16) echo "🚀 Launching Filmora..." && open -na "/Applications/Wondershare Filmora Mac.app" ;;
        17) echo "🚀 Launching PhotoScapeX..." && open -na "/Applications/PhotoScapeX.app" ;;
        18) echo "🚀 Launching ActivityWatch..." && open -na "/Applications/ActivityWatch.app" ;;
        19) echo "🚀 Launching iStatistica..." && open -na "/Applications/iStatistica Pro.app" ;;
        20) echo "🚀 Launching One Thing..." && open -na "/Applications/One Thing.app" ;;
        21) echo "🚀 Launching System Monitor..." && open -na "/Applications/Activity Monitor.app" ;;
        22) echo "🚀 Launching Caffeine..." && open -na "/Applications/Caffeine.app" ;;
        23) echo "🚀 Launching Boom 3D..." && open -na "/Applications/Boom 3D.app" ;;
        24) echo "🚀 Launching WhatsApp..." && open -na "/Applications/WhatsApp.app" ;;
        25) echo "🚀 Launching Telegram..." && open -na "/Applications/Telegram.app" ;;
        26) echo "🚀 Launching Messages..." && open -na "/Applications/Messages.app" ;;
        30) echo "🚀 Launching NEXUS Dashboard..." && ./scripts/nexus_floating_dashboard.sh ;;
        31) echo "🚀 Running Performance Monitor..." && ./scripts/system_performance_monitor.sh ;;
        32) 
            echo "🎯 Activating Focus Mode..."
            open -na "/Applications/One Thing.app"
            open -na "/Applications/Caffeine.app"
            echo "✅ Focus mode activated! One Thing + Caffeine running"
            ;;
        0) echo "${GREEN}👋 Goodbye!${NC}" && exit 0 ;;
        *) echo "${RED}❌ Invalid option. Please try again.${NC}" ;;
    esac
}

# Main loop
main() {
    while true; do
        show_menu
        read -r choice
        launch_app "$choice"
        echo ""
        echo -n "${YELLOW}Press Enter to continue...${NC}"
        read -r
    done
}

main "$@"
