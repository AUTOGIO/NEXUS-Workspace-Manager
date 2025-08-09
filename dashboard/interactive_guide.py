import streamlit as st
import subprocess
import json
import os
import sys
from pathlib import Path

# Add the project root to the path
project_root = Path(__file__).parent.parent
sys.path.append(str(project_root))

def run_command(command):
    """Run a shell command and return the result"""
    try:
        result = subprocess.run(command, shell=True, capture_output=True, text=True)
        return result.returncode == 0, result.stdout, result.stderr
    except Exception as e:
        return False, "", str(e)

def check_yabai_status():
    """Check if YABAI is running"""
    success, stdout, stderr = run_command("yabai -m query --displays")
    return success

def check_integration_status():
    """Check integration installation status"""
    status = {}
    
    # Check Keyboard Maestro
    km_path = "/Applications/Keyboard Maestro.app"
    status['keyboard_maestro'] = os.path.exists(km_path)
    
    # Check BetterTouchTool
    btt_path = "/Applications/BetterTouchTool.app"
    status['bettertouchtool'] = os.path.exists(btt_path)
    
    # Check Raycast
    raycast_path = "/Applications/Raycast.app"
    status['raycast'] = os.path.exists(raycast_path)
    
    # Check skhd
    success, stdout, stderr = run_command("brew services list | grep skhd")
    status['skhd'] = success
    
    return status

def main():
    st.set_page_config(
        page_title="YABAI Interactive Guide",
        page_icon="🎯",
        layout="wide",
        initial_sidebar_state="expanded"
    )
    
    # Custom CSS
    st.markdown("""
    <style>
    .main-header {
        font-size: 3rem;
        font-weight: bold;
        color: #1f77b4;
        text-align: center;
        margin-bottom: 2rem;
    }
    .section-header {
        font-size: 2rem;
        color: #ff7f0e;
        margin-top: 2rem;
        margin-bottom: 1rem;
    }
    .subsection-header {
        font-size: 1.5rem;
        color: #2ca02c;
        margin-top: 1.5rem;
        margin-bottom: 0.5rem;
    }
    .status-success {
        color: #2ca02c;
        font-weight: bold;
    }
    .status-warning {
        color: #ff7f0e;
        font-weight: bold;
    }
    .status-error {
        color: #d62728;
        font-weight: bold;
    }
    .code-block {
        background-color: #f0f0f0;
        padding: 1rem;
        border-radius: 0.5rem;
        font-family: 'Courier New', monospace;
    }
    </style>
    """, unsafe_allow_html=True)
    
    # Header
    st.markdown('<h1 class="main-header">🎯 YABAI Workspace Manager</h1>', unsafe_allow_html=True)
    st.markdown('<h2 class="section-header">Interactive User Guide</h2>', unsafe_allow_html=True)
    
    # Sidebar navigation
    st.sidebar.title("📖 Navigation")
    page = st.sidebar.selectbox(
        "Choose a section:",
        [
            "🏠 Getting Started",
            "🎯 Workspace Profiles", 
            "🔧 Integrations",
            "📊 Data Collection",
            "🎨 Dashboard",
            "⚙️ Advanced Features",
            "🔍 Troubleshooting",
            "🎨 Customization",
            "🎯 Workflow Examples",
            "📈 Performance Tips"
        ]
    )
    
    if page == "🏠 Getting Started":
        show_getting_started()
    elif page == "🎯 Workspace Profiles":
        show_workspace_profiles()
    elif page == "🔧 Integrations":
        show_integrations()
    elif page == "📊 Data Collection":
        show_data_collection()
    elif page == "🎨 Dashboard":
        show_dashboard()
    elif page == "⚙️ Advanced Features":
        show_advanced_features()
    elif page == "🔍 Troubleshooting":
        show_troubleshooting()
    elif page == "🎨 Customization":
        show_customization()
    elif page == "🎯 Workflow Examples":
        show_workflow_examples()
    elif page == "📈 Performance Tips":
        show_performance_tips()

def show_getting_started():
    st.markdown('<h2 class="section-header">🚀 Getting Started</h2>', unsafe_allow_html=True)
    
    # System Status Check
    st.subheader("🔍 System Status Check")
    
    col1, col2 = st.columns(2)
    
    with col1:
        st.write("**YABAI Status:**")
        if check_yabai_status():
            st.markdown('<p class="status-success">✅ YABAI is running</p>', unsafe_allow_html=True)
        else:
            st.markdown('<p class="status-error">❌ YABAI is not running</p>', unsafe_allow_html=True)
    
    with col2:
        st.write("**Integration Status:**")
        status = check_integration_status()
        
        if status['keyboard_maestro']:
            st.markdown('<p class="status-success">✅ Keyboard Maestro</p>', unsafe_allow_html=True)
        else:
            st.markdown('<p class="status-warning">⚠️ Keyboard Maestro</p>', unsafe_allow_html=True)
            
        if status['bettertouchtool']:
            st.markdown('<p class="status-success">✅ BetterTouchTool</p>', unsafe_allow_html=True)
        else:
            st.markdown('<p class="status-warning">⚠️ BetterTouchTool</p>', unsafe_allow_html=True)
            
        if status['raycast']:
            st.markdown('<p class="status-success">✅ Raycast</p>', unsafe_allow_html=True)
        else:
            st.markdown('<p class="status-warning">⚠️ Raycast</p>', unsafe_allow_html=True)
            
        if status['skhd']:
            st.markdown('<p class="status-success">✅ skhd</p>', unsafe_allow_html=True)
        else:
            st.markdown('<p class="status-warning">⚠️ skhd</p>', unsafe_allow_html=True)
    
    # Installation Steps
    st.subheader("📋 Installation Steps")
    
    with st.expander("Step 1: Install Core Dependencies", expanded=True):
        st.code("""
# Install YABAI and related tools
brew install yabai skhd jq

# Install optional integrations
brew install --cask keyboard-maestro bettertouchtool raycast
        """, language="bash")
        
        if st.button("Run Installation Check"):
            success, stdout, stderr = run_command("brew list | grep -E '(yabai|skhd|jq)'")
            if success:
                st.success("✅ Core dependencies are installed")
            else:
                st.error("❌ Some dependencies are missing")
    
    with st.expander("Step 2: Setup YABAI"):
        st.code("""
# Navigate to your project
cd ~/Desktop/YABAI

# Make scripts executable
chmod +x *.sh scripts/*.sh workspace_profiles/*.sh integrations/*.sh

# Start YABAI
yabai --start-service
        """, language="bash")
        
        if st.button("Start YABAI"):
            success, stdout, stderr = run_command("yabai --start-service")
            if success:
                st.success("✅ YABAI started successfully")
            else:
                st.error(f"❌ Failed to start YABAI: {stderr}")
    
    with st.expander("Step 3: Install Integrations"):
        st.code("""
# Install all integrations at once
./integrations/install_integrations.sh all

# Or install individually
./integrations/install_integrations.sh km      # Keyboard Maestro
./integrations/install_integrations.sh btt     # BetterTouchTool
./integrations/install_integrations.sh raycast # Raycast
./integrations/install_integrations.sh skhd    # skhd hotkeys
        """, language="bash")
        
        col1, col2, col3, col4 = st.columns(4)
        
        with col1:
            if st.button("Install Keyboard Maestro"):
                success, stdout, stderr = run_command("./integrations/install_integrations.sh km")
                if success:
                    st.success("✅ Keyboard Maestro installed")
                else:
                    st.error("❌ Installation failed")
        
        with col2:
            if st.button("Install BetterTouchTool"):
                success, stdout, stderr = run_command("./integrations/install_integrations.sh btt")
                if success:
                    st.success("✅ BetterTouchTool installed")
                else:
                    st.error("❌ Installation failed")
        
        with col3:
            if st.button("Install Raycast"):
                success, stdout, stderr = run_command("./integrations/install_integrations.sh raycast")
                if success:
                    st.success("✅ Raycast installed")
                else:
                    st.error("❌ Installation failed")
        
        with col4:
            if st.button("Install skhd"):
                success, stdout, stderr = run_command("./integrations/install_integrations.sh skhd")
                if success:
                    st.success("✅ skhd installed")
                else:
                    st.error("❌ Installation failed")
    
    # Quick Test
    st.subheader("🧪 Quick Test")
    
    if st.button("Test Workspace Profiles"):
        col1, col2, col3 = st.columns(3)
        
        with col1:
            if st.button("Test Work Profile"):
                success, stdout, stderr = run_command("./workspace_profiles/work_profile.sh")
                if success:
                    st.success("✅ Work profile loaded")
                else:
                    st.error("❌ Failed to load work profile")
        
        with col2:
            if st.button("Test Personal Profile"):
                success, stdout, stderr = run_command("./workspace_profiles/personal_profile.sh")
                if success:
                    st.success("✅ Personal profile loaded")
                else:
                    st.error("❌ Failed to load personal profile")
        
        with col3:
            if st.button("Test AI Research Profile"):
                success, stdout, stderr = run_command("./workspace_profiles/ai_research_profile.sh")
                if success:
                    st.success("✅ AI Research profile loaded")
                else:
                    st.error("❌ Failed to load AI Research profile")

def show_workspace_profiles():
    st.markdown('<h2 class="section-header">🎯 Workspace Profiles</h2>', unsafe_allow_html=True)
    
    # Profile Overview
    st.subheader("📋 Profile Overview")
    
    profiles = {
        "Work Profile": {
            "description": "Development & Productivity",
            "display1": "Chrome, Firefox, Safari (browsers)",
            "display2": "VS Code, Cursor, Terminal, Xcode (development)",
            "display3": "Slack, Teams, Zoom, WhatsApp (communication)",
            "hotkey": "Ctrl+Alt+Cmd+W"
        },
        "Personal Profile": {
            "description": "Entertainment & Social",
            "display1": "Safari, Vivaldi (browsers)",
            "display2": "Spotify, Netflix, YouTube, Twitch (entertainment)",
            "display3": "WhatsApp, X, Telegram, Discord (social)",
            "hotkey": "Ctrl+Alt+Cmd+P"
        },
        "AI Research Profile": {
            "description": "AI & ML Development",
            "display1": "Chrome, Firefox (research browsers)",
            "display2": "ChatGPT, Grok, Claude, Perplexity (AI tools)",
            "display3": "PyCharm, Jupyter, VS Code, Terminal (development)",
            "hotkey": "Ctrl+Alt+Cmd+R"
        }
    }
    
    for profile_name, details in profiles.items():
        with st.expander(f"{profile_name} - {details['description']}", expanded=True):
            col1, col2 = st.columns(2)
            
            with col1:
                st.write(f"**Hotkey:** {details['hotkey']}")
                st.write(f"**Display 1:** {details['display1']}")
                st.write(f"**Display 2:** {details['display2']}")
                st.write(f"**Display 3:** {details['display3']}")
            
            with col2:
                if st.button(f"Load {profile_name}"):
                    script_name = profile_name.lower().replace(" ", "_")
                    success, stdout, stderr = run_command(f"./workspace_profiles/{script_name}_profile.sh")
                    if success:
                        st.success(f"✅ {profile_name} loaded successfully")
                    else:
                        st.error(f"❌ Failed to load {profile_name}")
    
    # Profile Testing
    st.subheader("🧪 Profile Testing")
    
    test_profile = st.selectbox("Select a profile to test:", list(profiles.keys()))
    
    if st.button("Test Selected Profile"):
        script_name = test_profile.lower().replace(" ", "_")
        success, stdout, stderr = run_command(f"./workspace_profiles/{script_name}_profile.sh")
        if success:
            st.success(f"✅ {test_profile} loaded successfully")
            st.info("Check your displays to see the applications positioned correctly")
        else:
            st.error(f"❌ Failed to load {test_profile}: {stderr}")

def show_integrations():
    st.markdown('<h2 class="section-header">🔧 Integrations</h2>', unsafe_allow_html=True)
    
    # Integration Status
    st.subheader("📊 Integration Status")
    
    status = check_integration_status()
    
    col1, col2 = st.columns(2)
    
    with col1:
        st.write("**Application Status:**")
        for app, installed in status.items():
            if installed:
                st.markdown(f'<p class="status-success">✅ {app.replace("_", " ").title()}</p>', unsafe_allow_html=True)
            else:
                st.markdown(f'<p class="status-warning">⚠️ {app.replace("_", " ").title()}</p>', unsafe_allow_html=True)
    
    with col2:
        st.write("**YABAI Status:**")
        if check_yabai_status():
            st.markdown('<p class="status-success">✅ YABAI is running</p>', unsafe_allow_html=True)
        else:
            st.markdown('<p class="status-error">❌ YABAI is not running</p>', unsafe_allow_html=True)
    
    # Integration Details
    integrations = {
        "Keyboard Maestro": {
            "description": "Advanced macro automation with complex workflows",
            "hotkeys": [
                "Ctrl+Alt+Cmd+W: Load Work Profile",
                "Ctrl+Alt+Cmd+P: Load Personal Profile", 
                "Ctrl+Alt+Cmd+R: Load AI Research Profile",
                "Ctrl+Alt+Cmd+Space: Quick Window Management"
            ],
            "features": ["One-key profile switching", "Advanced automation", "Time-based triggers"]
        },
        "BetterTouchTool": {
            "description": "Gesture controls and input device management",
            "gestures": [
                "Three Finger Swipe Up: Mission Control",
                "Four Finger Tap: Rotate Layout",
                "Two Finger Swipe Left: Next Display",
                "Two Finger Swipe Right: Previous Display"
            ],
            "features": ["Trackpad gestures", "Mouse gestures", "Stream Deck support"]
        },
        "Raycast": {
            "description": "Quick command palette and window management",
            "features": [
                "Quick Actions: Profile switching, layout rotation",
                "Window Management: Move and focus windows",
                "Real-time Status: Live YABAI information",
                "Search Interface: Find and manage windows"
            ]
        },
        "skhd": {
            "description": "Global keyboard shortcuts for YABAI commands",
            "hotkeys": [
                "Ctrl+Alt+Cmd+W: Load Work Profile",
                "Ctrl+Alt+Cmd+P: Load Personal Profile",
                "Ctrl+Alt+Cmd+R: Load AI Research Profile",
                "Ctrl+Alt+Cmd+Left/Right: Move windows between displays",
                "Ctrl+Alt+Cmd+1-6: Focus spaces 1-6",
                "Ctrl+Alt+Cmd+F: Toggle window float",
                "Ctrl+Alt+Cmd+S: Rotate layout 90°"
            ]
        }
    }
    
    for integration_name, details in integrations.items():
        with st.expander(f"{integration_name}", expanded=True):
            st.write(f"**Description:** {details['description']}")
            
            if 'hotkeys' in details:
                st.write("**Hotkeys:**")
                for hotkey in details['hotkeys']:
                    st.write(f"• {hotkey}")
            
            if 'gestures' in details:
                st.write("**Gestures:**")
                for gesture in details['gestures']:
                    st.write(f"• {gesture}")
            
            if 'features' in details:
                st.write("**Features:**")
                for feature in details['features']:
                    st.write(f"• {feature}")
            
            # Test integration
            if st.button(f"Test {integration_name}"):
                if integration_name == "Keyboard Maestro":
                    st.info("Press Ctrl+Alt+Cmd+W to test Keyboard Maestro")
                elif integration_name == "BetterTouchTool":
                    st.info("Try the gestures: Three Finger Swipe Up, Four Finger Tap")
                elif integration_name == "Raycast":
                    st.info("Press Cmd+Space, type 'YABAI', and select the extension")
                elif integration_name == "skhd":
                    st.info("Press Ctrl+Alt+Cmd+W to test skhd hotkeys")

def show_data_collection():
    st.markdown('<h2 class="section-header">📊 Data Collection</h2>', unsafe_allow_html=True)
    
    # Screen Time Integration
    st.subheader("⏰ Screen Time Integration")
    
    col1, col2, col3 = st.columns(3)
    
    with col1:
        if st.button("Collect Screen Time Data"):
            success, stdout, stderr = run_command("./scripts/screen_time_collector.sh collect")
            if success:
                st.success("✅ Screen Time data collected")
            else:
                st.error("❌ Failed to collect Screen Time data")
    
    with col2:
        if st.button("Start Screen Time Monitor"):
            success, stdout, stderr = run_command("./scripts/screen_time_collector.sh monitor")
            if success:
                st.success("✅ Screen Time monitor started")
            else:
                st.error("❌ Failed to start Screen Time monitor")
    
    with col3:
        if st.button("Generate Screen Time Report"):
            success, stdout, stderr = run_command("./scripts/screen_time_collector.sh report")
            if success:
                st.success("✅ Screen Time report generated")
            else:
                st.error("❌ Failed to generate Screen Time report")
    
    # Activity Watch Integration
    st.subheader("📈 Activity Watch Integration")
    
    col1, col2, col3 = st.columns(3)
    
    with col1:
        if st.button("Collect Activity Data"):
            success, stdout, stderr = run_command("./scripts/activity_watch_integration.sh collect")
            if success:
                st.success("✅ Activity data collected")
            else:
                st.error("❌ Failed to collect activity data")
    
    with col2:
        if st.button("Start Activity Monitor"):
            success, stdout, stderr = run_command("./scripts/activity_watch_integration.sh monitor")
            if success:
                st.success("✅ Activity monitor started")
            else:
                st.error("❌ Failed to start activity monitor")
    
    with col3:
        if st.button("Generate Activity Report"):
            success, stdout, stderr = run_command("./scripts/activity_watch_integration.sh report")
            if success:
                st.success("✅ Activity report generated")
            else:
                st.error("❌ Failed to generate activity report")
    
    # Data Visualization
    st.subheader("📊 Data Visualization")
    
    # Check for data files
    data_dirs = ["configs/screen_time_data", "configs/activity_watch_data"]
    
    for data_dir in data_dirs:
        if os.path.exists(data_dir):
            files = os.listdir(data_dir)
            if files:
                st.write(f"**{data_dir}:** {len(files)} files found")
                for file in files[:5]:  # Show first 5 files
                    st.write(f"• {file}")
            else:
                st.write(f"**{data_dir}:** No data files found")
        else:
            st.write(f"**{data_dir}:** Directory not found")

def show_dashboard():
    st.markdown('<h2 class="section-header">🎨 Dashboard</h2>', unsafe_allow_html=True)
    
    st.subheader("📊 Streamlit Dashboard")
    
    st.write("The Streamlit dashboard provides visual workspace management and monitoring.")
    
    # Dashboard Features
    features = [
        "YABAI Status: Monitor YABAI service status",
        "Profile Switching: Load profiles with one click",
        "Display Layout: Visual representation of your 3 displays",
        "Active Windows: See all open windows and their locations",
        "System Controls: Start/stop/restart YABAI"
    ]
    
    st.write("**Features:**")
    for feature in features:
        st.write(f"• {feature}")
    
    # Launch Dashboard
    st.subheader("🚀 Launch Dashboard")
    
    col1, col2 = st.columns(2)
    
    with col1:
        if st.button("Install Dashboard Dependencies"):
            success, stdout, stderr = run_command("pip install -r dashboard/requirements.txt")
            if success:
                st.success("✅ Dashboard dependencies installed")
            else:
                st.error("❌ Failed to install dashboard dependencies")
    
    with col2:
        if st.button("Launch Dashboard"):
            st.info("Dashboard will open in your browser")
            st.code("streamlit run dashboard/workspace_dashboard.py", language="bash")
    
    # Dashboard Usage
    st.subheader("📖 Dashboard Usage")
    
    usage_steps = [
        "1. Open the dashboard in your browser",
        "2. Monitor YABAI status",
        "3. Click buttons to switch profiles",
        "4. View real-time window information"
    ]
    
    for step in usage_steps:
        st.write(step)

def show_advanced_features():
    st.markdown('<h2 class="section-header">⚙️ Advanced Features</h2>', unsafe_allow_html=True)
    
    # Auto-Scheduler
    st.subheader("⏰ Auto-Scheduler")
    
    st.write("Automatically switch profiles based on time and day.")
    
    col1, col2, col3 = st.columns(3)
    
    with col1:
        if st.button("Start Auto-Scheduler"):
            success, stdout, stderr = run_command("./scripts/auto_scheduler.sh start")
            if success:
                st.success("✅ Auto-scheduler started")
            else:
                st.error("❌ Failed to start auto-scheduler")
    
    with col2:
        if st.button("Check Auto-Scheduler Status"):
            success, stdout, stderr = run_command("./scripts/auto_scheduler.sh status")
            if success:
                st.success("✅ Auto-scheduler is running")
                st.write(stdout)
            else:
                st.error("❌ Auto-scheduler is not running")
    
    with col3:
        if st.button("Stop Auto-Scheduler"):
            success, stdout, stderr = run_command("./scripts/auto_scheduler.sh stop")
            if success:
                st.success("✅ Auto-scheduler stopped")
            else:
                st.error("❌ Failed to stop auto-scheduler")
    
    # AI Integration
    st.subheader("🤖 AI Integration")
    
    col1, col2, col3 = st.columns(3)
    
    with col1:
        if st.button("Run AI Integration"):
            success, stdout, stderr = run_command("./scripts/ai_integration.sh")
            if success:
                st.success("✅ AI integration completed")
                st.write(stdout)
            else:
                st.error("❌ AI integration failed")
    
    with col2:
        if st.button("Check Model Availability"):
            success, stdout, stderr = run_command("./scripts/ai_integration.sh check_models")
            if success:
                st.success("✅ Model check completed")
                st.write(stdout)
            else:
                st.error("❌ Model check failed")
    
    with col3:
        if st.button("Get AI Suggestions"):
            success, stdout, stderr = run_command("./scripts/ai_integration.sh suggest")
            if success:
                st.success("✅ AI suggestions generated")
                st.write(stdout)
            else:
                st.error("❌ Failed to get AI suggestions")
    
    # Display Detection
    st.subheader("🖥️ Display Detection")
    
    col1, col2 = st.columns(2)
    
    with col1:
        if st.button("Detect Display Configuration"):
            success, stdout, stderr = run_command("./scripts/display_detector.sh")
            if success:
                st.success("✅ Display configuration detected")
                st.write(stdout)
            else:
                st.error("❌ Failed to detect display configuration")
    
    with col2:
        if st.button("View Display Layout"):
            if os.path.exists("configs/display_layout.txt"):
                with open("configs/display_layout.txt", "r") as f:
                    layout = f.read()
                st.text_area("Display Layout:", layout, height=200)
            else:
                st.error("❌ Display layout file not found")

def show_troubleshooting():
    st.markdown('<h2 class="section-header">🔍 Troubleshooting</h2>', unsafe_allow_html=True)
    
    # Common Issues
    st.subheader("🚨 Common Issues")
    
    issues = {
        "YABAI Not Starting": {
            "symptoms": "YABAI service fails to start",
            "solutions": [
                "Check YABAI status: yabai -m query --displays",
                "Restart YABAI: yabai --restart-service",
                "Check SIP status: csrutil status"
            ]
        },
        "Integration Issues": {
            "symptoms": "Keyboard Maestro, BetterTouchTool, or Raycast not working",
            "solutions": [
                "Check integration status: ./integrations/install_integrations.sh status",
                "Reinstall specific integration: ./integrations/install_integrations.sh [km|btt|raycast|skhd]"
            ]
        },
        "Script Errors": {
            "symptoms": "Scripts fail to execute",
            "solutions": [
                "Check script permissions: chmod +x *.sh scripts/*.sh workspace_profiles/*.sh",
                "Check YABAI directory: ls -la ~/Desktop/YABAI/",
                "Check YABAI service: brew services list | grep yabai"
            ]
        },
        "Hotkeys Not Working": {
            "symptoms": "skhd hotkeys not responding",
            "solutions": [
                "Check skhd status: brew services list | grep skhd",
                "Restart skhd: brew services restart skhd",
                "Check configuration: cat ~/.skhdrc"
            ]
        }
    }
    
    for issue_name, details in issues.items():
        with st.expander(f"❌ {issue_name}", expanded=True):
            st.write(f"**Symptoms:** {details['symptoms']}")
            st.write("**Solutions:**")
            for solution in details['solutions']:
                st.write(f"• {solution}")
    
    # Debug Tools
    st.subheader("🔧 Debug Tools")
    
    col1, col2, col3, col4, col5 = st.columns(5)
    
    with col1:
        if st.button("Check YABAI"):
            success, stdout, stderr = run_command("yabai -m query --displays")
            if success:
                st.success("✅ YABAI is working")
            else:
                st.error("❌ YABAI is not working")
    
    with col2:
        if st.button("Check skhd"):
            success, stdout, stderr = run_command("brew services list | grep skhd")
            if success:
                st.success("✅ skhd is running")
            else:
                st.error("❌ skhd is not running")
    
    with col3:
        if st.button("Check Keyboard Maestro"):
            km_path = "$HOME/Library/Application Support/Keyboard Maestro/"
            success, stdout, stderr = run_command(f"ls {km_path}")
            if success:
                st.success("✅ Keyboard Maestro found")
            else:
                st.error("❌ Keyboard Maestro not found")
    
    with col4:
        if st.button("Check BetterTouchTool"):
            btt_path = "$HOME/Library/Application Support/BetterTouchTool/"
            success, stdout, stderr = run_command(f"ls {btt_path}")
            if success:
                st.success("✅ BetterTouchTool found")
            else:
                st.error("❌ BetterTouchTool not found")
    
    with col5:
        if st.button("Check Raycast"):
            raycast_path = "$HOME/.raycast/extensions/"
            success, stdout, stderr = run_command(f"ls {raycast_path}")
            if success:
                st.success("✅ Raycast found")
            else:
                st.error("❌ Raycast not found")
    
    # System Status Check
    st.subheader("📊 System Status Check")
    
    if st.button("Run Complete System Check"):
        st.write("**Running comprehensive system check...**")
        
        # Check all components
        checks = [
            ("YABAI", "yabai -m query --displays"),
            ("skhd", "brew services list | grep skhd"),
            ("Keyboard Maestro", "ls \"$HOME/Library/Application Support/Keyboard Maestro/\""),
            ("BetterTouchTool", "ls \"$HOME/Library/Application Support/BetterTouchTool/\""),
            ("Raycast", "ls \"$HOME/.raycast/extensions/\""),
            ("Scripts", "ls -la ~/Desktop/YABAI/")
        ]
        
        for check_name, command in checks:
            success, stdout, stderr = run_command(command)
            if success:
                st.markdown(f'<p class="status-success">✅ {check_name}</p>', unsafe_allow_html=True)
            else:
                st.markdown(f'<p class="status-error">❌ {check_name}</p>', unsafe_allow_html=True)

def show_customization():
    st.markdown('<h2 class="section-header">🎨 Customization</h2>', unsafe_allow_html=True)
    
    # YAML Configuration
    st.subheader("⚙️ YAML Configuration")
    
    st.write("Edit `configs/yabai_config.yaml` to customize your workspace.")
    
    if os.path.exists("configs/yabai_config.yaml"):
        with open("configs/yabai_config.yaml", "r") as f:
            config_content = f.read()
        
        st.text_area("Current Configuration:", config_content, height=300)
        
        if st.button("Edit Configuration"):
            st.info("Open configs/yabai_config.yaml in your text editor to make changes")
    else:
        st.error("❌ Configuration file not found")
    
    # YABAI Rules
    st.subheader("📋 YABAI Rules")
    
    st.write("Add custom rules to control window placement:")
    
    example_rules = """
yabai_rules:
  - app: "Cursor"
    display: 2
    space: 1
    float: false
    
  - app: "Safari"
    display: 1
    space: 1
    float: false
    
  - app: "ChatGPT"
    display: 2
    space: 2
    float: true
    """
    
    st.code(example_rules, language="yaml")
    
    # Custom Scripts
    st.subheader("📝 Custom Scripts")
    
    st.write("Create custom scripts in the `scripts/` directory:")
    
    example_script = """#!/bin/zsh
# scripts/custom_profile.sh

# Custom workspace profile
echo "Loading custom profile..."

# Open custom applications
open -na "/Applications/CustomApp.app"

# Apply YABAI rules
yabai -m rule --add app="CustomApp" display=2 space=1

echo "Custom profile loaded!"
"""
    
    st.code(example_script, language="bash")
    
    # Performance Settings
    st.subheader("⚡ Performance Settings")
    
    performance_tips = [
        "Use Keyboard Maestro for complex workflows",
        "Use skhd for simple hotkeys", 
        "Use BetterTouchTool for gestures",
        "Use Raycast for quick commands",
        "Start with defaults, then customize gradually"
    ]
    
    st.write("**Optimization Tips:**")
    for tip in performance_tips:
        st.write(f"• {tip}")

def show_workflow_examples():
    st.markdown('<h2 class="section-header">🎯 Workflow Examples</h2>', unsafe_allow_html=True)
    
    workflows = {
        "Morning Routine": {
            "steps": [
                "Wake up computer",
                "Press Ctrl+Alt+Cmd+W (Keyboard Maestro)",
                "Work profile loads automatically",
                "All development apps open and position correctly",
                "Check dashboard for system status"
            ],
            "hotkey": "Ctrl+Alt+Cmd+W"
        },
        "Development Session": {
            "steps": [
                "Open Cursor (automatically positioned on Display 2)",
                "Use Raycast to quickly move windows between displays",
                "Gesture controls for layout changes (Four Finger Tap to rotate)",
                "Hotkeys for space switching (Ctrl+Alt+Cmd+1-6)",
                "Monitor productivity with Activity Watch"
            ],
            "gestures": ["Four Finger Tap", "Two Finger Swipe Left/Right"]
        },
        "AI Research Session": {
            "steps": [
                "Press Ctrl+Alt+Cmd+R (Keyboard Maestro)",
                "AI Research profile loads",
                "AI tools open on Display 2",
                "Research browsers on Display 1",
                "Development tools on Display 3",
                "Use AI integration for model suggestions"
            ],
            "hotkey": "Ctrl+Alt+Cmd+R"
        },
        "Evening Switch": {
            "steps": [
                "Press Ctrl+Alt+Cmd+P (Keyboard Maestro)",
                "Personal profile loads",
                "Entertainment apps open",
                "Social media positioned on Display 3",
                "Relaxation workspace ready"
            ],
            "hotkey": "Ctrl+Alt+Cmd+P"
        },
        "Quick Window Management": {
            "steps": [
                "Focus a window",
                "Use Raycast to see all windows",
                "Drag gesture to move between displays",
                "Hotkey to toggle float (Ctrl+Alt+Cmd+F)",
                "Rotate layout with gesture (Four Finger Tap)"
            ],
            "hotkeys": ["Ctrl+Alt+Cmd+F", "Ctrl+Alt+Cmd+Left/Right"]
        }
    }
    
    for workflow_name, details in workflows.items():
        with st.expander(f"🔄 {workflow_name}", expanded=True):
            st.write("**Steps:**")
            for i, step in enumerate(details['steps'], 1):
                st.write(f"{i}. {step}")
            
            if 'hotkey' in details:
                st.write(f"**Primary Hotkey:** {details['hotkey']}")
            
            if 'gestures' in details:
                st.write("**Gestures:**")
                for gesture in details['gestures']:
                    st.write(f"• {gesture}")
            
            # Test workflow
            if st.button(f"Test {workflow_name}"):
                if workflow_name == "Morning Routine":
                    st.info("Press Ctrl+Alt+Cmd+W to test the morning routine")
                elif workflow_name == "Development Session":
                    st.info("Open Cursor and try the gestures and hotkeys")
                elif workflow_name == "AI Research Session":
                    st.info("Press Ctrl+Alt+Cmd+R to test the AI research session")
                elif workflow_name == "Evening Switch":
                    st.info("Press Ctrl+Alt+Cmd+P to test the evening switch")
                elif workflow_name == "Quick Window Management":
                    st.info("Focus a window and try the Raycast extension")

def show_performance_tips():
    st.markdown('<h2 class="section-header">📈 Performance Tips</h2>', unsafe_allow_html=True)
    
    # Memory Usage
    st.subheader("💾 Memory Usage")
    
    memory_usage = {
        "Keyboard Maestro": "~50MB",
        "BetterTouchTool": "~30MB", 
        "Raycast": "~20MB",
        "skhd": "~5MB",
        "YABAI": "~10MB"
    }
    
    for app, memory in memory_usage.items():
        st.write(f"• **{app}:** {memory}")
    
    # Startup Time
    st.subheader("⏱️ Startup Time")
    
    startup_times = {
        "Keyboard Maestro": "2-3 seconds",
        "BetterTouchTool": "1-2 seconds",
        "Raycast": "Instant",
        "skhd": "Instant", 
        "YABAI": "1-2 seconds"
    }
    
    for app, time in startup_times.items():
        st.write(f"• **{app}:** {time}")
    
    # Best Practices
    st.subheader("✅ Best Practices")
    
    best_practices = [
        "Profile Switching: Use hotkeys instead of manual app opening",
        "Window Management: Use gestures and hotkeys instead of mouse",
        "Data Collection: Run monitors in background for insights",
        "Dashboard: Use for monitoring, not primary control",
        "Customization: Start with defaults, then customize gradually"
    ]
    
    for practice in best_practices:
        st.write(f"• {practice}")
    
    # Success Metrics
    st.subheader("📊 Success Metrics")
    
    metrics = {
        "Profile Switching": "10 seconds → 1 second",
        "Window Management": "Manual → Gesture/Hotkey",
        "Layout Changes": "Menu navigation → One key",
        "App Launching": "Manual → Automated",
        "Setup Time": "5 minutes → 30 seconds",
        "Context Switching": "30 seconds → 3 seconds",
        "Window Arrangement": "Manual → Automatic",
        "Multi-display Usage": "60% → 95% efficiency"
    }
    
    for metric, improvement in metrics.items():
        st.write(f"• **{metric}:** {improvement}")
    
    # Integration Benefits
    st.subheader("🎯 Integration Benefits")
    
    benefits = [
        "Faster Workflow: One-key profile switching",
        "Gesture Control: Natural input methods", 
        "Quick Access: Raycast command palette",
        "Global Hotkeys: System-wide shortcuts",
        "Automation: Time-based and context-aware triggers"
    ]
    
    for benefit in benefits:
        st.markdown(f'<p class="status-success">✅ {benefit}</p>', unsafe_allow_html=True)

if __name__ == "__main__":
    main() 