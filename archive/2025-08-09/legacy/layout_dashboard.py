#!/usr/bin/env python3
"""
Dynamic Layout Dashboard for YABAI + N8N Workflows v2
Streamlit-based visual interface for layout management
"""

import streamlit as st
import json
import yaml
import subprocess
from pathlib import Path
from datetime import datetime
import time
import threading

# Import the dynamic layout manager
from dynamic_layout_manager import DynamicLayoutManager, LayoutCLI


class LayoutDashboard:
    """Streamlit dashboard for dynamic layout management"""
    
    def __init__(self):
        self.manager = DynamicLayoutManager()
        self.setup_page()
    
    def setup_page(self):
        """Setup Streamlit page configuration"""
        st.set_page_config(
            page_title="Dynamic Layout Manager",
            page_icon="🔄",
            layout="wide",
            initial_sidebar_state="expanded"
        )
        
        st.title("🔄 Dynamic Layout Manager")
        st.markdown("**YABAI + N8N Workflows v2 Layout Control**")
    
    def run(self):
        """Run the dashboard"""
        # Sidebar for controls
        self.sidebar_controls()
        
        # Main content
        col1, col2 = st.columns([2, 1])
        
        with col1:
            self.display_status()
            self.quick_actions()
        
        with col2:
            self.layout_history()
            self.system_info()
    
    def sidebar_controls(self):
        """Sidebar controls for layout management"""
        st.sidebar.header("🎛️ Layout Controls")
        
        # Profile switching
        st.sidebar.subheader("👥 Profile Management")
        profile = st.sidebar.selectbox(
            "Current Profile",
            ["work", "personal", "ai_research"],
            index=0
        )
        
        if st.sidebar.button("🔄 Switch Profile"):
            self.manager.swap_by_profile(profile)
            st.sidebar.success(f"✅ Switched to {profile} profile")
            st.rerun()
        
        # Individual tool swapping
        st.sidebar.subheader("🛠️ Tool Swapping")
        
        # Display selection
        display = st.sidebar.selectbox(
            "Select Display",
            list(self.manager.displays.keys()),
            format_func=lambda x: f"{self.manager.displays[x].name} ({x})"
        )
        
        # Tool selection for selected display
        suggestions = self.manager.get_layout_suggestions(display)
        tool_names = [tool.name for tool in suggestions]
        
        if tool_names:
            tool = st.sidebar.selectbox(
                "Select Tool",
                tool_names,
                format_func=lambda x: next(t.description for t in suggestions if t.name == x)
            )
            
            if st.sidebar.button("🔄 Swap Tool"):
                success = self.manager.swap_tool(display, tool)
                if success:
                    st.sidebar.success(f"✅ Swapped {tool} to {display}")
                else:
                    st.sidebar.error(f"❌ Failed to swap {tool}")
                st.rerun()
        else:
            st.sidebar.warning("⚠️ No tools available for this display")
        
        # Quick actions
        st.sidebar.subheader("⚡ Quick Actions")
        
        if st.sidebar.button("🔄 Refresh Status"):
            st.rerun()
        
        if st.sidebar.button("💾 Save Layout"):
            self.manager._save_layout_state()
            st.sidebar.success("✅ Layout saved")
        
        if st.sidebar.button("📂 Load Layout"):
            self.manager.load_layout_state()
            st.sidebar.success("✅ Layout loaded")
            st.rerun()
    
    def display_status(self):
        """Display current layout status"""
        st.header("📺 Current Layout Status")
        
        # Create display cards
        cols = st.columns(3)
        
        for i, (display_name, display) in enumerate(self.manager.displays.items()):
            with cols[i]:
                st.subheader(f"{display.name}")
                
                # Display info
                st.write(f"**ID:** {display.id}")
                st.write(f"**Purpose:** {display.purpose}")
                st.write(f"**Layout:** {display.layout}")
                
                # Current tool
                current_tool = display.current_tool or "None"
                if current_tool != "None":
                    st.success(f"**Current Tool:** {current_tool}")
                else:
                    st.info(f"**Current Tool:** {current_tool}")
                
                # Tool suggestions
                suggestions = self.manager.get_layout_suggestions(display_name)
                if suggestions:
                    st.write("**Suggested Tools:**")
                    for tool in suggestions[:3]:
                        st.write(f"• {tool.name}")
                
                # Quick swap buttons
                if suggestions:
                    selected_tool = st.selectbox(
                        f"Quick swap for {display_name}",
                        [""] + [tool.name for tool in suggestions],
                        key=f"quick_swap_{display_name}"
                    )
                    
                    if selected_tool and st.button(f"Swap to {selected_tool}", key=f"swap_{display_name}"):
                        success = self.manager.swap_tool(display_name, selected_tool)
                        if success:
                            st.success(f"✅ Swapped to {selected_tool}")
                        else:
                            st.error(f"❌ Failed to swap to {selected_tool}")
                        st.rerun()
    
    def quick_actions(self):
        """Quick action buttons"""
        st.header("⚡ Quick Actions")
        
        col1, col2, col3 = st.columns(3)
        
        with col1:
            if st.button("🖥️ Work Mode", use_container_width=True):
                self.manager.swap_by_profile("work")
                st.success("✅ Switched to Work Mode")
                st.rerun()
        
        with col2:
            if st.button("👤 Personal Mode", use_container_width=True):
                self.manager.swap_by_profile("personal")
                st.success("✅ Switched to Personal Mode")
                st.rerun()
        
        with col3:
            if st.button("🤖 AI Research Mode", use_container_width=True):
                self.manager.swap_by_profile("ai_research")
                st.success("✅ Switched to AI Research Mode")
                st.rerun()
        
        # N8N Workflows v2 specific actions
        st.subheader("🔧 N8N Workflows v2 Actions")
        
        col1, col2 = st.columns(2)
        
        with col1:
            if st.button("📊 Launch N8N Dashboard", use_container_width=True):
                # Launch N8N dashboard
                try:
                    subprocess.Popen([
                        "streamlit", "run", 
                        "/Volumes/MICRO/Documents/Projects/N8N_Workflows_v2/src/integrations/streamlit/dashboard.py"
                    ])
                    st.success("✅ N8N Dashboard launched")
                except Exception as e:
                    st.error(f"❌ Failed to launch dashboard: {e}")
        
        with col2:
            if st.button("📈 Launch Performance Monitor", use_container_width=True):
                # Launch performance monitor
                try:
                    subprocess.Popen([
                        "streamlit", "run",
                        "/Volumes/MICRO/Documents/Projects/N8N_Workflows_v2/src/integrations/monitoring/performance_monitor.py"
                    ])
                    st.success("✅ Performance Monitor launched")
                except Exception as e:
                    st.error(f"❌ Failed to launch monitor: {e}")
    
    def layout_history(self):
        """Display layout history"""
        st.header("📜 Layout History")
        
        if self.manager.layout_history:
            # Create a dataframe for history
            import pandas as pd
            
            history_data = []
            for entry in self.manager.layout_history[-10:]:  # Last 10 entries
                timestamp = datetime.fromisoformat(entry["timestamp"])
                history_data.append({
                    "Time": timestamp.strftime("%H:%M:%S"),
                    "Display": entry["display"],
                    "From": entry["old_tool"] or "None",
                    "To": entry["new_tool"],
                    "Profile": entry["profile"]
                })
            
            df = pd.DataFrame(history_data)
            st.dataframe(df, use_container_width=True)
        else:
            st.info("No layout history available")
    
    def system_info(self):
        """Display system information"""
        st.header("💻 System Information")
        
        # YABAI status
        st.subheader("🪟 YABAI Status")
        try:
            result = subprocess.run(["yabai", "-m", "query", "--spaces"], 
                                  capture_output=True, text=True)
            if result.returncode == 0:
                spaces = json.loads(result.stdout)
                st.write(f"**Active Spaces:** {len(spaces)}")
                
                # Display space info
                for space in spaces:
                    st.write(f"• Space {space['index']}: {space['label']}")
            else:
                st.error("❌ YABAI not running")
        except Exception as e:
            st.error(f"❌ Error checking YABAI: {e}")
        
        # Display information
        st.subheader("🖥️ Display Information")
        for display_name, display in self.manager.displays.items():
            st.write(f"**{display.name}:** {display.purpose}")
        
        # N8N Workflows v2 status
        st.subheader("🤖 N8N Workflows v2")
        try:
            n8n_config_path = Path("/Volumes/MICRO/Documents/Projects/N8N_Workflows_v2/config/environments/.env")
            if n8n_config_path.exists():
                st.success("✅ N8N Workflows v2 configured")
            else:
                st.warning("⚠️ N8N Workflows v2 not configured")
        except Exception as e:
            st.error(f"❌ Error checking N8N config: {e}")
    
    def auto_refresh(self):
        """Auto-refresh the dashboard"""
        if st.button("🔄 Auto Refresh (30s)"):
            time.sleep(30)
            st.rerun()


def main():
    """Main entry point for the dashboard"""
    dashboard = LayoutDashboard()
    dashboard.run()


if __name__ == "__main__":
    main() 