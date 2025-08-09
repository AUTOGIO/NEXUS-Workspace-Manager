import streamlit as st
import subprocess
import json
import os
import time
from pathlib import Path

# Page configuration
st.set_page_config(
    page_title="YABAI Workspace Manager",
    page_icon="🎯",
    layout="wide",
    initial_sidebar_state="expanded"
)

# Custom CSS for better styling
st.markdown("""
<style>
    .main-header {
        font-size: 2.5rem;
        font-weight: bold;
        color: #1f77b4;
        text-align: center;
        margin-bottom: 2rem;
    }
    .profile-card {
        background-color: #f0f2f6;
        padding: 1rem;
        border-radius: 10px;
        margin: 1rem 0;
        border-left: 4px solid #1f77b4;
    }
    .status-indicator {
        display: inline-block;
        width: 12px;
        height: 12px;
        border-radius: 50%;
        margin-right: 8px;
    }
    .status-active { background-color: #28a745; }
    .status-inactive { background-color: #dc3545; }
</style>
""", unsafe_allow_html=True)

def run_command(command):
    """Run a shell command and return the output"""
    try:
        result = subprocess.run(command, shell=True, capture_output=True, text=True)
        return result.stdout, result.stderr, result.returncode
    except Exception as e:
        return "", str(e), 1

def get_yabai_status():
    """Get YABAI service status"""
    stdout, stderr, code = run_command("yabai -m query --displays")
    return code == 0

def get_display_info():
    """Get display information from YABAI"""
    stdout, stderr, code = run_command("yabai -m query --displays")
    if code == 0:
        try:
            return json.loads(stdout)
        except:
            return []
    return []

def get_window_info():
    """Get window information from YABAI"""
    stdout, stderr, code = run_command("yabai -m query --windows")
    if code == 0:
        try:
            return json.loads(stdout)
        except:
            return []
    return []

def load_profile(profile_name):
    """Load a workspace profile"""
    profile_scripts = {
        "Work": "configs/profiles/work_profile.sh",
        "Personal": "configs/profiles/personal_profile.sh", 
        "AI Research": "configs/profiles/ai_research_profile.sh",
        "Daily Routine": "daily_routine.sh"
    }
    
    if profile_name in profile_scripts:
        script_path = profile_scripts[profile_name]
        if os.path.exists(script_path):
            stdout, stderr, code = run_command(f"source {script_path}")
            return code == 0
    return False

# Main dashboard
st.markdown('<h1 class="main-header">🎯 YABAI Workspace Manager</h1>', unsafe_allow_html=True)

# Sidebar
with st.sidebar:
    st.header("🛠️ Controls")
    
    # YABAI Status
    yabai_status = get_yabai_status()
    status_color = "status-active" if yabai_status else "status-inactive"
    status_text = "Active" if yabai_status else "Inactive"
    
    st.markdown(f"""
    <div class="profile-card">
        <h4>YABAI Status</h4>
        <span class="status-indicator {status_color}"></span>{status_text}
    </div>
    """, unsafe_allow_html=True)
    
    # YABAI Controls
    if st.button("🔄 Restart YABAI"):
        run_command("yabai --restart-service")
        st.success("YABAI restarted!")
        time.sleep(1)
        st.rerun()
    
    if st.button("🛑 Stop YABAI"):
        run_command("yabai --stop-service")
        st.success("YABAI stopped!")
        time.sleep(1)
        st.rerun()
    
    if st.button("▶️ Start YABAI"):
        run_command("yabai --start-service")
        st.success("YABAI started!")
        time.sleep(1)
        st.rerun()
    
    st.divider()
    
    # Profile Selection
    st.header("📋 Workspace Profiles")
    selected_profile = st.selectbox(
        "Choose a profile to load:",
        ["Work", "Personal", "AI Research", "Daily Routine"]
    )
    
    if st.button(f"🚀 Load {selected_profile} Profile"):
        with st.spinner(f"Loading {selected_profile} profile..."):
            success = load_profile(selected_profile)
            if success:
                st.success(f"{selected_profile} profile loaded successfully!")
            else:
                st.error(f"Failed to load {selected_profile} profile")
    
    st.divider()
    
    # Quick Actions
    st.header("⚡ Quick Actions")
    if st.button("🔍 Detect Displays"):
        stdout, stderr, code = run_command("./scripts/display_detector.sh")
        if code == 0:
            st.success("Display detection completed!")
            st.text(stdout)
        else:
            st.error("Display detection failed!")
    
    if st.button("📊 Refresh Status"):
        st.rerun()

# Main content area
col1, col2 = st.columns([2, 1])

with col1:
    st.header("📺 Display Layout")
    
    displays = get_display_info()
    if displays:
        for i, display in enumerate(displays):
            with st.expander(f"Display {display['index']} ({display['frame']['width']}x{display['frame']['height']})"):
                st.json(display)
    else:
        st.warning("No display information available")
    
    st.header("🪟 Active Windows")
    windows = get_window_info()
    if windows:
        window_data = []
        for window in windows:
            window_data.append({
                "App": window.get("app", "Unknown"),
                "Display": window.get("display", "Unknown"),
                "Space": window.get("space", "Unknown"),
                "Focused": "✅" if window.get("focused", False) else "❌"
            })
        st.dataframe(window_data, use_container_width=True)
    else:
        st.info("No active windows found")

with col2:
    st.header("📈 System Info")
    
    # Display configuration
    st.subheader("🖥️ Displays")
    display_count = len(displays) if displays else 0
    st.metric("Active Displays", display_count)
    
    # Window count
    st.subheader("🪟 Windows")
    window_count = len(windows) if windows else 0
    st.metric("Active Windows", window_count)
    
    # YABAI rules
    st.subheader("📋 Rules")
    stdout, stderr, code = run_command("yabai -m rule --list")
    if code == 0 and stdout.strip():
        st.text(stdout)
    else:
        st.info("No YABAI rules configured")

# Footer
st.divider()
st.markdown("""
<div style="text-align: center; color: #666;">
    <p>🎯 YABAI Workspace Manager - Optimized for your 3-display setup</p>
    <p>HZ30GAMER 30" | LG ULTRAWIDE 34" | iMac 24"</p>
</div>
""", unsafe_allow_html=True) 