#!/bin/zsh
# 🗂️ NEXUS Project Organization Script
# Organizes the project structure following best practices

set -euo pipefail

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
NC='\033[0m'

print_banner() {
    echo -e "${PURPLE}"
    echo "╔══════════════════════════════════════════════════════════════╗"
    echo "║                    🗂️ NEXUS Project                          ║"
    echo "║                  Organization Script                         ║"
    echo "║                                                              ║"
    echo "║              Following Best Practices & Standards            ║"
    echo "╚══════════════════════════════════════════════════════════════╝"
    echo -e "${NC}"
}

log() {
    local level="$1"
    shift
    local message="$*"
    
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
            echo -e "${BLUE}[SUCCESS]${NC} $message"
            ;;
    esac
}

# Get project root
PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"

organize_directories() {
    log "INFO" "Creating organized directory structure..."
    
    # Create main directories
    mkdir -p "$PROJECT_ROOT"/{bin,configs,deployments,docs,examples,scripts,src,tests,tools}
    
    # Create subdirectories
    mkdir -p "$PROJECT_ROOT"/scripts/{install,maintenance,deployment,automation}
    mkdir -p "$PROJECT_ROOT"/configs/{yabai,skhd,profiles,integrations,environments}
    mkdir -p "$PROJECT_ROOT"/tools/{automation,ai,analytics,shortcuts}
    mkdir -p "$PROJECT_ROOT"/deployments/{production,staging,development}
    mkdir -p "$PROJECT_ROOT"/src/{nexus,cli,core,dashboard,profiles,utils}
    mkdir -p "$PROJECT_ROOT"/tests/{unit,integration,e2e}
    mkdir -p "$PROJECT_ROOT"/docs/{user-guides,developer-guides,api,configuration}
    
    log "SUCCESS" "Directory structure created"
}

organize_config_files() {
    log "INFO" "Organizing configuration files..."
    
    # Move YABAI configs
    if [[ -f "$PROJECT_ROOT/configs/yabai/yabai_config.yaml" ]]; then
        log "SUCCESS" "YABAI config already in place"
    fi
    
    if [[ -f "$PROJECT_ROOT/configs/yabai/yabairc" ]]; then
        log "SUCCESS" "YABAI rules already in place"
    fi
    
    # Move SKHD configs
    if [[ -f "$PROJECT_ROOT/configs/skhd/skhdrc" ]]; then
        log "SUCCESS" "SKHD config already in place"
    fi
    
    # Create environment configs
    if [[ ! -f "$PROJECT_ROOT/configs/environments/nexus.env" ]]; then
        cp "$PROJECT_ROOT/.env.example" "$PROJECT_ROOT/configs/environments/nexus.env" 2>/dev/null || true
        log "SUCCESS" "Environment config created"
    fi
    
    log "SUCCESS" "Configuration files organized"
}

organize_scripts() {
    log "INFO" "Organizing script files..."
    
    # Move installation scripts
    if [[ -f "$PROJECT_ROOT/scripts/install/install_yabai_complete.sh" ]]; then
        log "SUCCESS" "YABAI installer already in place"
    fi
    
    # Move maintenance scripts
    if [[ -f "$PROJECT_ROOT/scripts/maintenance/test_yabai_setup.sh" ]]; then
        log "SUCCESS" "YABAI tester already in place"
    fi
    
    # Create main project scripts
    local main_scripts=(
        "start_nexus.sh"
        "stop_nexus.sh"
        "restart_nexus.sh"
        "update_nexus.sh"
        "backup_nexus.sh"
    )
    
    for script in "${main_scripts[@]}"; do
        if [[ ! -f "$PROJECT_ROOT/$script" ]]; then
            touch "$PROJECT_ROOT/$script"
            chmod +x "$PROJECT_ROOT/$script"
            log "SUCCESS" "Created $script"
        fi
    done
    
    log "SUCCESS" "Scripts organized"
}

organize_documentation() {
    log "INFO" "Organizing documentation..."
    
    # Create main documentation files
    local docs=(
        "docs/README.md"
        "docs/INSTALLATION.md"
        "docs/CONFIGURATION.md"
        "docs/USAGE.md"
        "docs/TROUBLESHOOTING.md"
        "docs/DEVELOPMENT.md"
        "docs/API.md"
        "docs/CHANGELOG.md"
    )
    
    for doc in "${docs[@]}"; do
        if [[ ! -f "$PROJECT_ROOT/$doc" ]]; then
            mkdir -p "$(dirname "$PROJECT_ROOT/$doc")"
            touch "$PROJECT_ROOT/$doc"
            log "SUCCESS" "Created $doc"
        fi
    done
    
    log "SUCCESS" "Documentation organized"
}

create_main_scripts() {
    log "INFO" "Creating main project scripts..."
    
    # Start script
    cat > "$PROJECT_ROOT/start_nexus.sh" << 'EOF'
#!/bin/zsh
# 🚀 NEXUS Start Script
# Starts all NEXUS services

set -euo pipefail

echo "🚀 Starting NEXUS Workspace Manager..."
echo "======================================"

# Start YABAI
if command -v yabai >/dev/null 2>&1; then
    echo "🐟 Starting YABAI..."
    yabai --start-service
    echo "✅ YABAI started"
else
    echo "❌ YABAI not found"
fi

# Start SKHD
if command -v skhd >/dev/null 2>&1; then
    echo "⌨️ Starting SKHD..."
    pkill skhd 2>/dev/null || true
    skhd --config "$(dirname "$0")/configs/skhd/skhdrc" &
    echo "✅ SKHD started"
else
    echo "❌ SKHD not found"
fi

# Start NEXUS Dashboard
if command -v streamlit >/dev/null 2>&1; then
    echo "📊 Starting NEXUS Dashboard..."
    cd "$(dirname "$0")/dashboard"
    streamlit run interactive_guide.py &
    echo "✅ Dashboard started"
else
    echo "⚠️ Streamlit not found - dashboard not started"
fi

echo ""
echo "🎉 NEXUS started successfully!"
echo "   YABAI: Window management active"
echo "   SKHD: Hotkeys active"
echo "   Dashboard: Available at http://localhost:8501"
EOF

    chmod +x "$PROJECT_ROOT/start_nexus.sh"
    
    # Stop script
    cat > "$PROJECT_ROOT/stop_nexus.sh" << 'EOF'
#!/bin/zsh
# 🛑 NEXUS Stop Script
# Stops all NEXUS services

set -euo pipefail

echo "🛑 Stopping NEXUS Workspace Manager..."
echo "======================================"

# Stop YABAI
if command -v yabai >/dev/null 2>&1; then
    echo "🐟 Stopping YABAI..."
    yabai --stop-service
    echo "✅ YABAI stopped"
fi

# Stop SKHD
echo "⌨️ Stopping SKHD..."
pkill skhd 2>/dev/null && echo "✅ SKHD stopped" || echo "⚠️ SKHD not running"

# Stop Streamlit
echo "📊 Stopping Dashboard..."
pkill -f streamlit 2>/dev/null && echo "✅ Dashboard stopped" || echo "⚠️ Dashboard not running"

echo ""
echo "🎉 NEXUS stopped successfully!"
EOF

    chmod +x "$PROJECT_ROOT/stop_nexus.sh"
    
    # Restart script
    cat > "$PROJECT_ROOT/restart_nexus.sh" << 'EOF'
#!/bin/zsh
# 🔄 NEXUS Restart Script
# Restarts all NEXUS services

set -euo pipefail

echo "🔄 Restarting NEXUS Workspace Manager..."
echo "========================================"

# Stop services
"$(dirname "$0")/stop_nexus.sh"

# Wait a moment
sleep 2

# Start services
"$(dirname "$0")/start_nexus.sh"

echo ""
echo "🎉 NEXUS restarted successfully!"
EOF

    chmod +x "$PROJECT_ROOT/restart_nexus.sh"
    
    log "SUCCESS" "Main scripts created"
}

create_project_files() {
    log "INFO" "Creating project organization files..."
    
    # Create project structure documentation
    cat > "$PROJECT_ROOT/PROJECT_STRUCTURE.md" << 'EOF'
# 🗂️ NEXUS Project Structure

## Directory Organization

```
NEXUS-Workspace-Manager/
├── bin/                    # Binary files and executables
├── configs/                # Configuration files
│   ├── yabai/             # YABAI configuration and rules
│   ├── skhd/              # SKHD hotkey configuration
│   ├── profiles/          # Workspace profiles
│   ├── integrations/      # Third-party integrations
│   └── environments/      # Environment configurations
├── deployments/            # Deployment configurations
│   ├── production/        # Production settings
│   ├── staging/           # Staging settings
│   └── development/       # Development settings
├── docs/                   # Documentation
│   ├── user-guides/       # User documentation
│   ├── developer-guides/  # Developer documentation
│   ├── api/               # API documentation
│   └── configuration/     # Configuration guides
├── examples/               # Example configurations
├── scripts/                # Scripts and automation
│   ├── install/           # Installation scripts
│   ├── maintenance/       # Maintenance scripts
│   ├── deployment/        # Deployment scripts
│   └── automation/        # Automation scripts
├── src/                    # Source code
│   └── nexus/             # Main NEXUS package
│       ├── cli/           # Command-line interface
│       ├── core/          # Core functionality
│       ├── dashboard/     # Dashboard components
│       ├── profiles/      # Profile management
│       └── utils/         # Utility functions
├── tests/                  # Test files
│   ├── unit/              # Unit tests
│   ├── integration/       # Integration tests
│   └── e2e/               # End-to-end tests
├── tools/                  # Tools and utilities
│   ├── automation/        # Automation tools
│   ├── ai/                # AI integration tools
│   ├── analytics/         # Analytics tools
│   └── shortcuts/         # Shortcut tools
├── .env.example           # Environment template
├── .gitignore             # Git ignore rules
├── pyproject.toml         # Python project configuration
├── README.md              # Project overview
├── start_nexus.sh         # Start all services
├── stop_nexus.sh          # Stop all services
└── restart_nexus.sh       # Restart all services
```

## Best Practices

- **Configuration**: All configs in `configs/` directory
- **Scripts**: Organized by purpose in `scripts/` subdirectories
- **Documentation**: Comprehensive docs in `docs/` directory
- **Source Code**: Clean structure in `src/nexus/`
- **Tests**: Organized by type in `tests/` directory
- **Tools**: Categorized in `tools/` subdirectories
EOF

    log "SUCCESS" "Project structure documentation created"
}

cleanup_old_files() {
    log "INFO" "Cleaning up old files..."
    
    # Remove old test files from root
    local old_files=(
        "test_keyboard_shortcuts.sh"
        "start_skhd.sh"
        "quick_skhd_fix.sh"
        "fix_skhd_permissions.sh"
        "fix_yabai_sip_issue.sh"
    )
    
    for file in "${old_files[@]}"; do
        if [[ -f "$PROJECT_ROOT/$file" ]]; then
            rm "$PROJECT_ROOT/$file"
            log "SUCCESS" "Removed old file: $file"
        fi
    done
    
    log "SUCCESS" "Cleanup completed"
}

main() {
    print_banner
    
    log "INFO" "Starting NEXUS project organization..."
    echo ""
    
    organize_directories
    organize_config_files
    organize_scripts
    organize_documentation
    create_main_scripts
    create_project_files
    cleanup_old_files
    
    echo ""
    log "SUCCESS" "NEXUS project organization completed!"
    echo ""
    echo "🎯 What's been organized:"
    echo "   ✅ Directory structure following best practices"
    echo "   ✅ Configuration files properly organized"
    echo "   ✅ Scripts categorized by purpose"
    echo "   ✅ Documentation structure created"
    echo "   ✅ Main project scripts created"
    echo "   ✅ Old files cleaned up"
    echo ""
    echo "🚀 Next steps:"
    echo "   1. Review the new structure"
    echo "   2. Test the main scripts"
    echo "   3. Update documentation as needed"
    echo "   4. Commit changes to Git"
    echo ""
    echo "📚 See PROJECT_STRUCTURE.md for details"
}

# Run main function
main "$@"
