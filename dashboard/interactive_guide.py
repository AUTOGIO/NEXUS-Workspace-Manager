#!/usr/bin/env python3
"""
🎨 NEXUS Interactive Guide Dashboard
AI-Powered Workspace Intelligence for Apple Silicon

Author: Eduardo Giovannini
Version: 0.1.0
License: MIT

Interactive Streamlit dashboard for NEXUS workspace management
"""

import streamlit as st
import subprocess
import json
import sys
from pathlib import Path
import psutil
import platform
from typing import Dict, List, Any

# Add project root to path for imports
project_root = Path(__file__).parent.parent
sys.path.insert(0, str(project_root))

# Page configuration
st.set_page_config(
    page_title="NEXUS Interactive Guide",
    page_icon="🚀",
    layout="wide",
    initial_sidebar_state="expanded"
)

# Custom CSS for better styling
st.markdown("""
<style>
    .main-header {
        font-size: 3rem;
        font-weight: bold;
        color: #1f77b4;
        text-align: center;
        margin-bottom: 2rem;
    }
    .feature-card {
        background-color: #f0f2f6;
        padding: 1rem;
        border-radius: 0.5rem;
        margin: 0.5rem 0;
        border-left: 4px solid #1f77b4;
    }
    .status-card {
        background-color: #e8f5e8;
        padding: 1rem;
        border-radius: 0.5rem;
        margin: 0.5rem 0;
        border-left: 4px solid #28a745;
    }
    .warning-card {
        background-color: #fff3cd;
        padding: 1rem;
        border-radius: 0.5rem;
        margin: 0.5rem 0;
        border-left: 4px solid #ffc107;
    }
    .error-card {
        background-color: #f8d7da;
        padding: 1rem;
        border-radius: 0.5rem;
        margin: 0.5rem 0;
        border-left: 4px solid #dc3545;
    }
    .metric-card {
        background-color: #ffffff;
        padding: 1rem;
        border-radius: 0.5rem;
        margin: 0.5rem 0;
        border: 1px solid #dee2e6;
        text-align: center;
    }
    .metric-value {
        font-size: 2rem;
        font-weight: bold;
        color: #1f77b4;
    }
    .metric-label {
        font-size: 0.9rem;
        color: #6c757d;
    }
</style>
""", unsafe_allow_html=True)

class NEXUSDashboard:
    """Main dashboard class for NEXUS workspace management."""
    
    def __init__(self):
        self.project_root = Path(__file__).parent.parent
        self.configs_dir = self.project_root / "configs"
        self.scripts_dir = self.project_root / "scripts"
        self.logs_dir = self.project_root / "logs"
        self.tools_dir = self.project_root / "tools"
        
    def run_command(self, command: str) -> tuple[str, int]:
        """Run a shell command and return output and exit code."""
        try:
            result = subprocess.run(
                command, 
                shell=True, 
                capture_output=True, 
                text=True, 
                timeout=30
            )
            return result.stdout, result.returncode
        except subprocess.TimeoutExpired:
            return "Command timed out", 1
        except Exception as e:
            return f"Error: {str(e)}", 1
    
    def get_system_info(self) -> Dict[str, Any]:
        """Get system information."""
        return {
            "platform": platform.system(),
            "platform_version": platform.version(),
            "machine": platform.machine(),
            "processor": platform.processor(),
            "python_version": platform.python_version(),
            "cpu_count": psutil.cpu_count(),
            "memory_total": psutil.virtual_memory().total,
            "memory_available": psutil.virtual_memory().available,
            "disk_usage": psutil.disk_usage('/').percent
        }
    
    def check_yabai_status(self) -> Dict[str, Any]:
        """Check YABAI status."""
        output, exit_code = self.run_command("yabai -m query --spaces")
        if exit_code == 0:
            try:
                spaces = json.loads(output)
                return {
                    "status": "running",
                    "spaces": spaces,
                    "space_count": len(spaces)
                }
            except json.JSONDecodeError:
                return {"status": "running", "spaces": [], "space_count": 0}
        else:
            return {"status": "not_running", "spaces": [], "space_count": 0}
    
    def check_skhd_status(self) -> Dict[str, Any]:
        """Check SKHD status."""
        output, exit_code = self.run_command("pgrep -x skhd")
        if exit_code == 0:
            return {"status": "running", "pid": output.strip()}
        else:
            return {"status": "not_running", "pid": None}
    
    def get_available_profiles(self) -> List[str]:
        """Get available workspace profiles."""
        profiles_dir = self.configs_dir / "profiles"
        if profiles_dir.exists():
            profiles = [f.stem for f in profiles_dir.glob("*.sh")]
            return sorted(profiles)
        return []
    
    def load_profile(self, profile_name: str) -> bool:
        """Load a workspace profile."""
        profile_script = self.scripts_dir / "setup" / "launcher.sh"
        if profile_script.exists():
            output, exit_code = self.run_command(f"{profile_script} {profile_name}")
            return exit_code == 0
        return False
    
    def discover_ai_models(self) -> Dict[str, Any]:
        """Discover AI models using the discovery script."""
        discovery_script = self.tools_dir / "ai" / "discover_models.py"
        if discovery_script.exists():
            output, exit_code = self.run_command(f"python {discovery_script}")
            if exit_code == 0:
                # Try to read the generated catalog
                catalog_file = self.configs_dir / "models" / "model_catalog.json"
                if catalog_file.exists():
                    try:
                        with open(catalog_file, 'r') as f:
                            return json.load(f)
                    except (json.JSONDecodeError, FileNotFoundError):
                        pass
            return {"error": "Failed to discover models", "output": output}
        return {"error": "Discovery script not found"}
    
    def get_performance_metrics(self) -> Dict[str, Any]:
        """Get real-time performance metrics."""
        cpu_percent = psutil.cpu_percent(interval=1)
        memory = psutil.virtual_memory()
        disk = psutil.disk_usage('/')
        
        return {
            "cpu_percent": cpu_percent,
            "memory_percent": memory.percent,
            "memory_used_gb": memory.used / (1024**3),
            "memory_total_gb": memory.total / (1024**3),
            "disk_percent": disk.percent,
            "disk_free_gb": disk.free / (1024**3)
        }
    
    def get_logs(self, log_file: str = "nexus.log", lines: int = 50) -> str:
        """Get recent log entries."""
        log_path = self.logs_dir / log_file
        if log_path.exists():
            try:
                with open(log_path, 'r') as f:
                    lines_list = f.readlines()
                    return ''.join(lines_list[-lines:])
            except Exception as e:
                return f"Error reading logs: {str(e)}"
        return "Log file not found"

def main():
    """Main dashboard function."""
    
    # Initialize dashboard
    dashboard = NEXUSDashboard()
    
    # Header
    st.markdown('<h1 class="main-header">🚀 NEXUS Interactive Guide</h1>', unsafe_allow_html=True)
    st.markdown('<p style="text-align: center; font-size: 1.2rem; color: #6c757d;">AI-Powered Workspace Intelligence for Apple Silicon</p>', unsafe_allow_html=True)
    
    # Sidebar navigation
    st.sidebar.title("🎯 Navigation")
    page = st.sidebar.selectbox(
        "Choose a section:",
        [
            "🏠 Dashboard Overview",
            "🤖 AI Integration",
            "🖥️ YABAI Management",
            "⚙️ Workspace Profiles",
            "📊 Performance Monitoring",
            "🔧 System Configuration",
            "📚 Documentation",
            "🛠️ Tools & Utilities"
        ]
    )
    
    # Dashboard Overview
    if page == "🏠 Dashboard Overview":
        show_dashboard_overview(dashboard)
    
    # AI Integration
    elif page == "🤖 AI Integration":
        show_ai_integration(dashboard)
    
    # YABAI Management
    elif page == "🖥️ YABAI Management":
        show_yabai_management(dashboard)
    
    # Workspace Profiles
    elif page == "⚙️ Workspace Profiles":
        show_workspace_profiles(dashboard)
    
    # Performance Monitoring
    elif page == "📊 Performance Monitoring":
        show_performance_monitoring(dashboard)
    
    # System Configuration
    elif page == "🔧 System Configuration":
        show_system_configuration(dashboard)
    
    # Documentation
    elif page == "📚 Documentation":
        show_documentation(dashboard)
    
    # Tools & Utilities
    elif page == "🛠️ Tools & Utilities":
        show_tools_utilities(dashboard)

def show_dashboard_overview(dashboard: NEXUSDashboard):
    """Show dashboard overview."""
    st.header("🏠 Dashboard Overview")
    
    # System status
    col1, col2, col3 = st.columns(3)
    
    with col1:
        st.subheader("🖥️ System Status")
        system_info = dashboard.get_system_info()
        
        st.markdown(f"""
        <div class="status-card">
            <strong>Platform:</strong> {system_info['platform']} {system_info['platform_version']}<br>
            <strong>Machine:</strong> {system_info['machine']}<br>
            <strong>Python:</strong> {system_info['python_version']}<br>
            <strong>CPU Cores:</strong> {system_info['cpu_count']}
        </div>
        """, unsafe_allow_html=True)
    
    with col2:
        st.subheader("🚀 NEXUS Status")
        yabai_status = dashboard.check_yabai_status()
        skhd_status = dashboard.check_skhd_status()
        
        yabai_color = "🟢" if yabai_status["status"] == "running" else "🔴"
        skhd_color = "🟢" if skhd_status["status"] == "running" else "🔴"
        
        st.markdown(f"""
        <div class="status-card">
            <strong>YABAI:</strong> {yabai_color} {yabai_status["status"]}<br>
            <strong>Spaces:</strong> {yabai_status["space_count"]}<br>
            <strong>SKHD:</strong> {skhd_color} {skhd_status["status"]}
        </div>
        """, unsafe_allow_html=True)
    
    with col3:
        st.subheader("📊 Quick Actions")
        
        if st.button("🔄 Refresh Status", use_container_width=True):
            st.rerun()
        
        if st.button("📊 Launch Dashboard", use_container_width=True):
            st.info("Dashboard launched!")
        
        if st.button("🔍 System Check", use_container_width=True):
            st.info("Running system check...")
    
    # Performance metrics
    st.subheader("📈 Performance Metrics")
    metrics = dashboard.get_performance_metrics()
    
    col1, col2, col3, col4 = st.columns(4)
    
    with col1:
        st.markdown(f"""
        <div class="metric-card">
            <div class="metric-value">{metrics['cpu_percent']:.1f}%</div>
            <div class="metric-label">CPU Usage</div>
        </div>
        """, unsafe_allow_html=True)
    
    with col2:
        st.markdown(f"""
        <div class="metric-card">
            <div class="metric-value">{metrics['memory_percent']:.1f}%</div>
            <div class="metric-label">Memory Usage</div>
        </div>
        """, unsafe_allow_html=True)
    
    with col3:
        st.markdown(f"""
        <div class="metric-card">
            <div class="metric-value">{metrics['memory_used_gb']:.1f}GB</div>
            <div class="metric-label">Memory Used</div>
        </div>
        """, unsafe_allow_html=True)
    
    with col4:
        st.markdown(f"""
        <div class="metric-card">
            <div class="metric-value">{metrics['disk_percent']:.1f}%</div>
            <div class="metric-label">Disk Usage</div>
        </div>
        """, unsafe_allow_html=True)
    
    # Recent activity
    st.subheader("📝 Recent Activity")
    
    col1, col2 = st.columns([2, 1])
    
    with col1:
        st.subheader("📋 Recent Logs")
        logs = dashboard.get_logs()
        if logs:
            st.text_area("Logs", logs, height=200, disabled=True)
        else:
            st.info("No logs available")
    
    with col2:
        st.subheader("⚡ Quick Commands")
        
        if st.button("🔍 Check YABAI", use_container_width=True):
            status = dashboard.check_yabai_status()
            st.json(status)
        
        if st.button("📱 Check SKHD", use_container_width=True):
            status = dashboard.check_skhd_status()
            st.json(status)
        
        if st.button("💾 Check Disk", use_container_width=True):
            disk = psutil.disk_usage('/')
            st.write(f"Free: {disk.free / (1024**3):.1f} GB")
            st.write(f"Used: {disk.used / (1024**3):.1f} GB")

def show_ai_integration(dashboard: NEXUSDashboard):
    """Show AI integration section."""
    st.header("🤖 AI Integration")
    
    st.markdown("""
    <div class="feature-card">
        <h4>🚀 AI Model Discovery</h4>
        <p>NEXUS automatically discovers and manages AI models from your LM Studio directory.</p>
        <strong>Command:</strong> <code>python tools/ai/discover_models.py</strong>
    </div>
    """, unsafe_allow_html=True)
    
    if st.button("🔍 Discover AI Models", use_container_width=True):
        st.info("AI model discovery feature coming soon!")
    
    st.markdown("""
    <div class="feature-card">
        <h4>🧠 Intelligent Workspace Optimization</h4>
        <ul>
            <li>Context-aware model selection</li>
            <li>Performance optimization</li>
            <li>Predictive loading</li>
            <li>Fallback systems</li>
        </ul>
    </div>
    """, unsafe_allow_html=True)

def show_yabai_management(dashboard: NEXUSDashboard):
    """Show YABAI management section."""
    st.header("🖥️ YABAI Management")
    
    # YABAI Status
    st.subheader("📊 YABAI Status")
    
    col1, col2 = st.columns(2)
    
    with col1:
        if st.button("🔄 Check YABAI Status", use_container_width=True):
            status = dashboard.check_yabai_status()
            st.json(status)
    
    with col2:
        if st.button("🔄 Check SKHD Status", use_container_width=True):
            status = dashboard.check_skhd_status()
            st.json(status)
    
    # YABAI Control
    st.subheader("🎮 YABAI Control")
    
    col1, col2, col3 = st.columns(3)
    
    with col1:
        if st.button("▶️ Start YABAI", use_container_width=True):
            output, exit_code = dashboard.run_command("yabai --start-service")
            if exit_code == 0:
                st.success("YABAI started successfully!")
            else:
                st.error(f"Failed to start YABAI: {output}")
    
    with col2:
        if st.button("⏸️ Stop YABAI", use_container_width=True):
            output, exit_code = dashboard.run_command("yabai --stop-service")
            if exit_code == 0:
                st.success("YABAI stopped successfully!")
            else:
                st.error(f"Failed to stop YABAI: {output}")
    
    with col3:
        if st.button("🔄 Restart YABAI", use_container_width=True):
            output, exit_code = dashboard.run_command("yabai --restart-service")
            if exit_code == 0:
                st.success("YABAI restarted successfully!")
            else:
                st.error(f"Failed to restart YABAI: {output}")

def show_workspace_profiles(dashboard: NEXUSDashboard):
    """Show workspace profiles section."""
    st.header("⚙️ Workspace Profiles")
    
    # Available Profiles
    st.subheader("📋 Available Profiles")
    
    profiles = dashboard.get_available_profiles()
    
    if profiles:
        st.write(f"Found {len(profiles)} workspace profiles:")
        
        # Display profiles in columns
        cols = st.columns(3)
        for i, profile in enumerate(profiles):
            col = cols[i % 3]
            if col.button(f"🚀 {profile}", key=f"profile_{profile}", use_container_width=True):
                if dashboard.load_profile(profile):
                    st.success(f"Profile '{profile}' loaded successfully!")
                else:
                    st.error(f"Failed to load profile '{profile}'")
    else:
        st.warning("No workspace profiles found")

def show_performance_monitoring(dashboard: NEXUSDashboard):
    """Show performance monitoring section."""
    st.header("📊 Performance Monitoring")
    
    # Real-time metrics
    st.subheader("📈 Real-time Metrics")
    
    metrics = dashboard.get_performance_metrics()
    
    col1, col2, col3, col4 = st.columns(4)
    
    with col1:
        st.markdown(f"""
        <div class="metric-card">
            <div class="metric-value">{metrics['cpu_percent']:.1f}%</div>
            <div class="metric-label">CPU Usage</div>
        </div>
        """, unsafe_allow_html=True)
    
    with col2:
        st.markdown(f"""
        <div class="metric-card">
            <div class="metric-value">{metrics['memory_percent']:.1f}%</div>
            <div class="metric-label">Memory Usage</div>
        </div>
        """, unsafe_allow_html=True)
    
    with col3:
        st.markdown(f"""
        <div class="metric-card">
            <div class="metric-value">{metrics['disk_percent']:.1f}%</div>
            <div class="metric-label">Disk Usage</div>
        </div>
        """, unsafe_allow_html=True)
    
    with col4:
        memory_efficiency = 100 - metrics['memory_percent']
        st.markdown(f"""
        <div class="metric-card">
            <div class="metric-value">{memory_efficiency:.1f}%</div>
            <div class="metric-label">Memory Free</div>
        </div>
        """, unsafe_allow_html=True)

def show_system_configuration(dashboard: NEXUSDashboard):
    """Show system configuration section."""
    st.header("🔧 System Configuration")
    
    st.subheader("💻 System Information")
    
    system_info = dashboard.get_system_info()
    
    col1, col2 = st.columns(2)
    
    with col1:
        st.markdown(f"""
        <div class="status-card">
            <h4>System Details</h4>
            <strong>Platform:</strong> {system_info['platform']}<br>
            <strong>Version:</strong> {system_info['platform_version']}<br>
            <strong>Machine:</strong> {system_info['machine']}<br>
            <strong>Processor:</strong> {system_info['processor']}
        </div>
        """, unsafe_allow_html=True)
    
    with col2:
        st.markdown(f"""
        <div class="status-card">
            <h4>Python Environment</h4>
            <strong>Python Version:</strong> {system_info['python_version']}<br>
            <strong>CPU Cores:</strong> {system_info['cpu_count']}<br>
            <strong>Memory Total:</strong> {system_info['memory_total'] / (1024**3):.1f} GB<br>
            <strong>Disk Usage:</strong> {system_info['disk_usage']:.1f}%
        </div>
        """, unsafe_allow_html=True)

def show_documentation(dashboard: NEXUSDashboard):
    """Show documentation section."""
    st.header("📚 Documentation")
    
    st.markdown("""
    <div class="feature-card">
        <h4>📖 Available Documentation</h4>
        <ul>
            <li><strong>User Guide:</strong> Complete user guide with examples</li>
            <li><strong>Developer Guide:</strong> Development setup and contribution</li>
            <li><strong>API Reference:</strong> Technical API documentation</li>
            <li><strong>Project Structure:</strong> Project organization guide</li>
        </ul>
    </div>
    """, unsafe_allow_html=True)
    
    st.subheader("📋 Quick Reference")
    
    col1, col2 = st.columns(2)
    
    with col1:
        st.markdown("""
        <div class="feature-card">
            <h4>🚀 Essential Commands</h4>
            <ul>
                <li><code>./scripts/setup/launcher.sh</code> - Main launcher</li>
                <li><code>./scripts/setup/launcher.sh status</code> - System status</li>
                <li><code>./scripts/setup/launcher.sh dashboard</code> - Launch dashboard</li>
                <li><code>python tools/ai/discover_models.py</code> - Discover AI models</li>
            </ul>
        </div>
        """, unsafe_allow_html=True)
    
    with col2:
        st.markdown("""
        <div class="feature-card">
            <h4>🎮 YABAI Commands</h4>
            <ul>
                <li><code>yabai-focus-north</code> - Focus window north</li>
                <li><code>yabai-switch-space 2</code> - Switch to space 2</li>
                <li><code>yabai-toggle-float</code> - Toggle window float</li>
                <li><code>yabai --restart-service</code> - Restart YABAI</li>
            </ul>
        </div>
        """, unsafe_allow_html=True)

def show_tools_utilities(dashboard: NEXUSDashboard):
    """Show tools and utilities section."""
    st.header("🛠️ Tools & Utilities")
    
    st.markdown("""
    <div class="feature-card">
        <h4>🤖 AI Tools</h4>
        <ul>
            <li><strong>Model Discovery:</strong> <code>python tools/ai/discover_models.py</code></li>
            <li><strong>AI Model Manager:</strong> <code>src/nexus/core/ai_model_manager.py</code></li>
        </ul>
    </div>
    """, unsafe_allow_html=True)
    
    st.markdown("""
    <div class="feature-card">
        <h4>⚙️ Automation Tools</h4>
        <ul>
            <li><strong>YABAI Bridge:</strong> <code>tools/ai/yabai_automation_bridge.py</code></li>
            <li><strong>Bridge Installer:</strong> <code>tools/automation/install_yabai_bridge.sh</code></li>
        </ul>
    </div>
    """, unsafe_allow_html=True)
    
    st.markdown("""
    <div class="feature-card">
        <h4>🔨 Makefile Targets</h4>
        <ul>
            <li><code>make setup</code> - Initial project setup</li>
            <li><code>make test</code> - Run test suite</li>
            <li><code>make lint</code> - Run code quality checks</li>
            <code>make clean</code> - Clean build artifacts</li>
        </ul>
    </div>
    """, unsafe_allow_html=True)

if __name__ == "__main__":
    main() 