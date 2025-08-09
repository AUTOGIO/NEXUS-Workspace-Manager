#!/usr/bin/env python3
"""
Dynamic Layout Manager for YABAI + N8N Workflows v2
Allows swapping tools/displays based on configuration
"""

import os
import sys
import json
import yaml
import subprocess
import asyncio
from pathlib import Path
from typing import Dict, List, Any, Optional
from dataclasses import dataclass
from datetime import datetime, time
import logging

# Add N8N Workflows v2 to path
sys.path.append('/Volumes/MICRO/Documents/Projects/N8N_Workflows_v2/src')

try:
    from utils.config import Config
    from utils.logger import setup_logger
except ImportError:
    # Fallback if N8N Workflows v2 not available
    Config = None
    setup_logger = lambda name="DynamicLayout": logging.getLogger(name)


@dataclass
class Display:
    """Display configuration"""
    id: int
    name: str
    purpose: str
    apps: List[str]
    current_tool: Optional[str] = None
    layout: str = "bsp"


@dataclass
class Tool:
    """Tool/Application configuration"""
    name: str
    category: str
    apps: List[str]
    description: str
    workspace_profile: str
    display_preference: List[int]  # Display IDs where this tool can run


class DynamicLayoutManager:
    """
    Manages dynamic layout switching for YABAI + N8N Workflows v2
    """
    
    def __init__(self, yabai_config_path: str = "configs/yabai_config.yaml"):
        self.logger = setup_logger("DynamicLayout") if setup_logger else logging.getLogger("DynamicLayout")
        self.yabai_config_path = Path(yabai_config_path)
        self.n8n_config = None
        
        # Load configurations
        self.load_yabai_config()
        self.load_n8n_config()
        
        # Get display count early
        self.display_count = self._get_current_display_count()
        
        # Initialize displays and tools
        self.displays = self._create_displays()
        self.tools = self._create_tools()
        
        # Current state
        self.current_profile = "work"
        self.layout_history = []
        
    def load_yabai_config(self):
        """Load YABAI configuration"""
        try:
            with open(self.yabai_config_path, 'r') as f:
                self.yabai_config = yaml.safe_load(f)
            self.logger.info("✅ YABAI configuration loaded")
        except Exception as e:
            self.logger.error(f"❌ Failed to load YABAI config: {e}")
            self.yabai_config = {}
    
    def load_n8n_config(self):
        """Load N8N Workflows v2 configuration"""
        try:
            n8n_config_path = Path("/Volumes/MICRO/Documents/Projects/N8N_Workflows_v2/config/environments/.env")
            if n8n_config_path.exists():
                self.n8n_config = Config() if Config else {}
                self.logger.info("✅ N8N Workflows v2 configuration loaded")
            else:
                self.n8n_config = {}
                self.logger.warning("⚠️ N8N Workflows v2 configuration not found")
        except Exception as e:
            self.logger.error(f"❌ Failed to load N8N config: {e}")
            self.n8n_config = {}
    
    def _get_current_display_count(self) -> int:
        """Get current display count from various sources"""
        try:
            # Try reading from adaptive display config
            config_file = Path("configs/current_display_count.txt")
            if config_file.exists():
                with open(config_file, 'r') as f:
                    count = int(f.read().strip())
                    if 1 <= count <= 3:
                        return count
            
            # Try YABAI query
            result = subprocess.run(
                ["yabai", "-m", "query", "--displays"], 
                capture_output=True, text=True
            )
            if result.returncode == 0:
                import json
                displays = json.loads(result.stdout)
                count = len(displays)
                if 1 <= count <= 3:
                    return count
            
            # Fallback: assume 2 displays (common dual setup)
            self.logger.warning("⚠️ Could not detect display count, defaulting to 2")
            return 2
            
        except Exception as e:
            self.logger.error(f"❌ Error detecting display count: {e}")
            return 2
    
    def _get_display_preference(self, preference_type: str) -> List[int]:
        """Get display preferences based on current display count"""
        if self.display_count == 1:
            return [1]  # Single display - everything goes to main
        elif self.display_count == 2:
            if preference_type == "primary":
                return [2, 1]  # Prefer right (main), fallback left
            elif preference_type == "secondary":
                return [1, 2]  # Prefer left, fallback right
            else:
                return [1, 2]  # Default
        else:  # 3 displays
            if preference_type == "primary":
                return [2, 1, 3]  # Center, Left, Right
            elif preference_type == "secondary":
                return [1, 3, 2]  # Left, Right, Center
            elif preference_type == "communication":
                return [3, 1, 2]  # Right, Left, Center
            else:
                return [2, 1, 3]  # Default to primary
    
    def _create_displays(self) -> Dict[str, Display]:
        """Create display objects from configuration with adaptive support"""
        displays = {}
        
        # Load current display count
        current_display_count = self._get_current_display_count()
        
        if current_display_count == 1:
            # Single display configuration
            displays["main"] = Display(
                id=1,
                name="Primary Display",
                purpose="Unified Workspace",
                apps=["All Applications"]
            )
        elif current_display_count == 2:
            # Dual display configuration
            displays["left"] = Display(
                id=1,
                name="Secondary Display", 
                purpose="Reference & Communication",
                apps=["Safari", "Chrome", "WhatsApp", "Slack", "Obsidian"]
            )
            displays["right"] = Display(
                id=2,
                name="Primary Display",
                purpose="Main Work & AI Tools", 
                apps=["Visual Studio Code", "Terminal", "ChatGPT", "Grok", "LM Studio"]
            )
        else:
            # Triple display configuration (original)
            if 'displays' in self.yabai_config:
                for display_name, config in self.yabai_config['displays'].items():
                    displays[display_name] = Display(
                        id=config['id'],
                        name=config['name'],
                        purpose=config['purpose'],
                        apps=config['apps']
                    )
            else:
                # Default triple display fallback
                displays["left"] = Display(
                    id=1,
                    name="Left Display",
                    purpose="Browsers & Web Tools",
                    apps=["Safari", "Vivaldi", "Chrome", "Firefox"]
                )
                displays["center"] = Display(
                    id=2,
                    name="Center Display", 
                    purpose="AI & Development Tools",
                    apps=["ChatGPT", "Grok", "VS Code", "Terminal"]
                )
                displays["right"] = Display(
                    id=3,
                    name="Right Display",
                    purpose="Productivity & Communication",
                    apps=["Obsidian", "WhatsApp", "X", "Slack"]
                )
        
        return displays
    
    def _create_tools(self) -> Dict[str, Tool]:
        """Create tool objects from configuration"""
        tools = {
            # Development Tools
            "code_editor": Tool(
                name="Code Editor",
                category="development", 
                apps=["Visual Studio Code", "Xcode", "PyCharm", "IntelliJ IDEA"],
                description="Code editing and development",
                workspace_profile="work",
                display_preference=self._get_display_preference("primary")
            ),
            
            "terminal": Tool(
                name="Terminal",
                category="development",
                apps=["Terminal", "iTerm2", "Alacritty"],
                description="Command line interface", 
                workspace_profile="work",
                display_preference=self._get_display_preference("primary")
            ),
            
            # AI Tools
            "ai_chat": Tool(
                name="AI Chat",
                category="ai",
                apps=["ChatGPT", "Grok", "Claude", "Perplexity"],
                description="AI chat and assistance",
                workspace_profile="ai_research",
                display_preference=self._get_display_preference("primary")
            ),
            
            "ai_development": Tool(
                name="AI Development",
                category="ai",
                apps=["Ollama", "LM Studio", "MLX", "Jupyter Notebook"],
                description="AI model development and testing",
                workspace_profile="ai_research",
                display_preference=self._get_display_preference("primary")
            ),
            
            # Productivity Tools
            "productivity": Tool(
                name="Productivity",
                category="productivity",
                apps=["Notion", "Obsidian", "Calendar", "Reminders"],
                description="Note-taking and productivity",
                workspace_profile="personal",
                display_preference=self._get_display_preference("communication")
            ),
            
            "communication": Tool(
                name="Communication",
                category="communication",
                apps=["WhatsApp", "Slack", "Teams", "X", "Telegram"],
                description="Communication and messaging",
                workspace_profile="personal",
                display_preference=self._get_display_preference("communication")
            ),
            
            # Web Tools
            "web_browser": Tool(
                name="Web Browser",
                category="web",
                apps=["Safari", "Chrome", "Firefox", "Vivaldi"],
                description="Web browsing and research",
                workspace_profile="work",
                display_preference=self._get_display_preference("secondary")
            ),
            
            # N8N Workflows v2 Tools
            "n8n_dashboard": Tool(
                name="N8N Dashboard",
                category="automation",
                apps=["Streamlit", "N8N"],
                description="N8N Workflows v2 dashboard",
                workspace_profile="work",
                display_preference=[2, 3]  # Center, Right
            ),
            
            "n8n_monitoring": Tool(
                name="N8N Monitoring",
                category="automation",
                apps=["Performance Monitor", "Agent Status"],
                description="N8N Workflows v2 monitoring",
                workspace_profile="work",
                display_preference=[3, 2]  # Right, Center
            ),
            
            # Entertainment Tools
            "entertainment": Tool(
                name="Entertainment",
                category="entertainment",
                apps=["Spotify", "Netflix", "YouTube", "Twitch"],
                description="Entertainment and media",
                workspace_profile="personal",
                display_preference=[1, 3]  # Left, Right
            )
        }
        
        return tools
    
    def get_available_tools(self, profile: str = None) -> List[Tool]:
        """Get available tools for current profile"""
        if profile is None:
            profile = self.current_profile
        
        available_tools = []
        for tool in self.tools.values():
            if tool.workspace_profile == profile:
                available_tools.append(tool)
        
        return available_tools
    
    def get_display_status(self) -> Dict[str, Any]:
        """Get current display status"""
        status = {}
        
        for display_name, display in self.displays.items():
            status[display_name] = {
                "id": display.id,
                "name": display.name,
                "purpose": display.purpose,
                "current_tool": display.current_tool,
                "layout": display.layout
            }
        
        return status
    
    def swap_tool(self, display_name: str, tool_name: str) -> bool:
        """
        Swap a tool on a specific display
        
        Args:
            display_name: Name of the display (left, center, right)
            tool_name: Name of the tool to swap to
            
        Returns:
            bool: True if successful, False otherwise
        """
        try:
            # Validate display
            if display_name not in self.displays:
                self.logger.error(f"❌ Invalid display: {display_name}")
                return False
            
            # Validate tool
            if tool_name not in self.tools:
                self.logger.error(f"❌ Invalid tool: {tool_name}")
                return False
            
            display = self.displays[display_name]
            tool = self.tools[tool_name]
            
            # Check if tool can run on this display
            if display.id not in tool.display_preference:
                self.logger.warning(f"⚠️ Tool {tool_name} not preferred for display {display_name}")
            
            # Record the swap
            old_tool = display.current_tool
            display.current_tool = tool_name
            
            # Update layout history
            self.layout_history.append({
                "timestamp": datetime.now().isoformat(),
                "display": display_name,
                "old_tool": old_tool,
                "new_tool": tool_name,
                "profile": self.current_profile
            })
            
            # Execute the swap
            success = self._execute_tool_swap(display, tool)
            
            if success:
                self.logger.info(f"✅ Swapped {tool_name} to {display_name} display")
                self._save_layout_state()
            else:
                # Revert on failure
                display.current_tool = old_tool
                self.logger.error(f"❌ Failed to swap {tool_name} to {display_name}")
            
            return success
            
        except Exception as e:
            self.logger.error(f"❌ Error during tool swap: {e}")
            return False
    
    def _execute_tool_swap(self, display: Display, tool: Tool) -> bool:
        """Execute the actual tool swap"""
        try:
            # 1. Close current apps on display (if any)
            if display.current_tool:
                self._close_display_apps(display)
            
            # 2. Launch new tool apps
            self._launch_tool_apps(tool, display.id)
            
            # 3. Update YABAI workspace
            self._update_yabai_workspace(display.id, tool)
            
            # 4. Update display layout
            display.layout = self._get_optimal_layout(tool)
            
            return True
            
        except Exception as e:
            self.logger.error(f"❌ Error executing tool swap: {e}")
            return False
    
    def _close_display_apps(self, display: Display):
        """Close apps on a specific display"""
        try:
            # Get current apps on display
            cmd = f"yabai -m query --displays --display {display.id}"
            result = subprocess.run(cmd.split(), capture_output=True, text=True)
            
            if result.returncode == 0:
                # Close windows on this display
                cmd = f"yabai -m query --windows --display {display.id} | jq '.[].id' | xargs -I {{}} yabai -m window {{}} --close"
                subprocess.run(cmd, shell=True)
                
        except Exception as e:
            self.logger.warning(f"⚠️ Error closing display apps: {e}")
    
    def _launch_tool_apps(self, tool: Tool, display_id: int):
        """Launch apps for a specific tool"""
        try:
            for app in tool.apps:
                # Check if app is already running
                cmd = f"pgrep -x '{app}'"
                result = subprocess.run(cmd, shell=True, capture_output=True)
                
                if result.returncode != 0:
                    # Launch app
                    cmd = f"open -a '{app}'"
                    subprocess.run(cmd, shell=True)
                    
                    # Move to correct display
                    self._move_app_to_display(app, display_id)
                    
        except Exception as e:
            self.logger.warning(f"⚠️ Error launching tool apps: {e}")
    
    def _move_app_to_display(self, app_name: str, display_id: int):
        """Move app to specific display"""
        try:
            # Wait a moment for app to launch
            asyncio.sleep(1)
            
            # Move app to display
            cmd = f"yabai -m query --windows | jq '.[] | select(.app == \"{app_name}\") | .id' | xargs -I {{}} yabai -m window {{}} --display {display_id}"
            subprocess.run(cmd, shell=True)
            
        except Exception as e:
            self.logger.warning(f"⚠️ Error moving app to display: {e}")
    
    def _update_yabai_workspace(self, display_id: int, tool: Tool):
        """Update YABAI workspace for the tool"""
        try:
            # Set workspace layout based on tool
            layout = self._get_optimal_layout(tool)
            
            cmd = f"yabai -m space --layout {layout}"
            subprocess.run(cmd, shell=True)
            
        except Exception as e:
            self.logger.warning(f"⚠️ Error updating YABAI workspace: {e}")
    
    def _get_optimal_layout(self, tool: Tool) -> str:
        """Get optimal layout for a tool"""
        layout_map = {
            "development": "bsp",
            "ai": "bsp",
            "productivity": "stack",
            "communication": "stack",
            "web": "bsp",
            "automation": "bsp",
            "entertainment": "float"
        }
        
        return layout_map.get(tool.category, "bsp")
    
    def _save_layout_state(self):
        """Save current layout state"""
        try:
            state = {
                "timestamp": datetime.now().isoformat(),
                "current_profile": self.current_profile,
                "displays": {
                    name: {
                        "current_tool": display.current_tool,
                        "layout": display.layout
                    }
                    for name, display in self.displays.items()
                },
                "layout_history": self.layout_history[-10:]  # Keep last 10 entries
            }
            
            state_file = Path("configs/layout_state.json")
            with open(state_file, 'w') as f:
                json.dump(state, f, indent=2)
                
        except Exception as e:
            self.logger.error(f"❌ Error saving layout state: {e}")
    
    def load_layout_state(self):
        """Load saved layout state"""
        try:
            state_file = Path("configs/layout_state.json")
            if state_file.exists():
                with open(state_file, 'r') as f:
                    state = json.load(f)
                
                # Restore display states
                for display_name, display_state in state.get("displays", {}).items():
                    if display_name in self.displays:
                        self.displays[display_name].current_tool = display_state.get("current_tool")
                        self.displays[display_name].layout = display_state.get("layout", "bsp")
                
                # Restore profile
                self.current_profile = state.get("current_profile", "work")
                
                # Restore history
                self.layout_history = state.get("layout_history", [])
                
                self.logger.info("✅ Layout state restored")
                
        except Exception as e:
            self.logger.error(f"❌ Error loading layout state: {e}")
    
    def get_layout_suggestions(self, display_name: str) -> List[Tool]:
        """Get tool suggestions for a display"""
        if display_name not in self.displays:
            return []
        
        display = self.displays[display_name]
        available_tools = self.get_available_tools()
        
        # Filter tools that can run on this display
        suggestions = []
        for tool in available_tools:
            if display.id in tool.display_preference:
                suggestions.append(tool)
        
        # Sort by preference (display_id index in preference list)
        suggestions.sort(key=lambda t: tool.display_preference.index(display.id))
        
        return suggestions
    
    def create_quick_swap_menu(self):
        """Create a quick swap menu for all displays"""
        menu_items = []
        
        for display_name, display in self.displays.items():
            suggestions = self.get_layout_suggestions(display_name)
            
            menu_items.append(f"\n{display.name} ({display_name}):")
            menu_items.append(f"  Current: {display.current_tool or 'None'}")
            menu_items.append("  Suggestions:")
            
            for tool in suggestions[:3]:  # Top 3 suggestions
                menu_items.append(f"    - {tool.name}: {tool.description}")
        
        return "\n".join(menu_items)
    
    def swap_by_profile(self, profile: str):
        """Swap all displays to tools for a specific profile"""
        self.current_profile = profile
        available_tools = self.get_available_tools(profile)
        
        # Distribute tools across displays
        for i, (display_name, display) in enumerate(self.displays.items()):
            if i < len(available_tools):
                tool = available_tools[i]
                self.swap_tool(display_name, tool.name)
        
        self.logger.info(f"✅ Swapped to {profile} profile")


class LayoutCLI:
    """Command-line interface for layout management"""
    
    def __init__(self):
        self.manager = DynamicLayoutManager()
    
    def run(self):
        """Run the CLI"""
        print("🔄 Dynamic Layout Manager for YABAI + N8N Workflows v2")
        print("=" * 60)
        
        while True:
            print("\nOptions:")
            print("1. Show current layout")
            print("2. Swap tool on display")
            print("3. Quick swap suggestions")
            print("4. Swap to profile")
            print("5. Show layout history")
            print("6. Exit")
            
            choice = input("\nEnter choice (1-6): ").strip()
            
            if choice == "1":
                self.show_current_layout()
            elif choice == "2":
                self.swap_tool()
            elif choice == "3":
                self.show_suggestions()
            elif choice == "4":
                self.swap_profile()
            elif choice == "5":
                self.show_history()
            elif choice == "6":
                print("👋 Goodbye!")
                break
            else:
                print("❌ Invalid choice")
    
    def show_current_layout(self):
        """Show current layout status"""
        print("\n📺 Current Layout:")
        print("-" * 40)
        
        for display_name, display in self.manager.displays.items():
            print(f"{display.name} ({display_name}):")
            print(f"  Tool: {display.current_tool or 'None'}")
            print(f"  Layout: {display.layout}")
            print(f"  Purpose: {display.purpose}")
            print()
    
    def swap_tool(self):
        """Interactive tool swap"""
        print("\n🔄 Tool Swap:")
        print("-" * 40)
        
        # Show displays
        print("Available displays:")
        for i, (display_name, display) in enumerate(self.manager.displays.items(), 1):
            print(f"{i}. {display.name} ({display_name})")
        
        try:
            display_choice = int(input("Select display (1-3): ")) - 1
            display_names = list(self.manager.displays.keys())
            display_name = display_names[display_choice]
            
            # Show available tools
            suggestions = self.manager.get_layout_suggestions(display_name)
            print(f"\nAvailable tools for {display_name}:")
            for i, tool in enumerate(suggestions, 1):
                print(f"{i}. {tool.name} - {tool.description}")
            
            tool_choice = int(input("Select tool: ")) - 1
            tool = suggestions[tool_choice]
            
            # Execute swap
            success = self.manager.swap_tool(display_name, tool.name)
            if success:
                print(f"✅ Swapped {tool.name} to {display_name}")
            else:
                print(f"❌ Failed to swap {tool.name}")
                
        except (ValueError, IndexError):
            print("❌ Invalid selection")
    
    def show_suggestions(self):
        """Show quick swap suggestions"""
        print("\n💡 Quick Swap Suggestions:")
        print(self.manager.create_quick_swap_menu())
    
    def swap_profile(self):
        """Swap to a specific profile"""
        print("\n👥 Profile Swap:")
        print("-" * 40)
        print("1. Work Profile")
        print("2. Personal Profile")
        print("3. AI Research Profile")
        
        try:
            choice = int(input("Select profile (1-3): "))
            profiles = ["work", "personal", "ai_research"]
            profile = profiles[choice - 1]
            
            self.manager.swap_by_profile(profile)
            print(f"✅ Swapped to {profile} profile")
            
        except (ValueError, IndexError):
            print("❌ Invalid selection")
    
    def show_history(self):
        """Show layout history"""
        print("\n📜 Layout History:")
        print("-" * 40)
        
        for entry in self.manager.layout_history[-5:]:  # Last 5 entries
            timestamp = entry["timestamp"][:19]  # Remove microseconds
            print(f"{timestamp}: {entry['display']} - {entry['old_tool']} → {entry['new_tool']}")


def main():
    """Main entry point"""
    if len(sys.argv) > 1:
        # Command line mode
        manager = DynamicLayoutManager()
        
        if sys.argv[1] == "swap":
            if len(sys.argv) >= 4:
                display = sys.argv[2]
                tool = sys.argv[3]
                success = manager.swap_tool(display, tool)
                print("✅ Success" if success else "❌ Failed")
            else:
                print("Usage: python dynamic_layout_manager.py swap <display> <tool>")
        
        elif sys.argv[1] == "profile":
            if len(sys.argv) >= 3:
                profile = sys.argv[2]
                manager.swap_by_profile(profile)
                print(f"✅ Swapped to {profile} profile")
            else:
                print("Usage: python dynamic_layout_manager.py profile <profile_name>")
        
        elif sys.argv[1] == "status":
            status = manager.get_display_status()
            print(json.dumps(status, indent=2))
        
        else:
            print("Usage:")
            print("  python dynamic_layout_manager.py swap <display> <tool>")
            print("  python dynamic_layout_manager.py profile <profile_name>")
            print("  python dynamic_layout_manager.py status")
            print("  python dynamic_layout_manager.py (interactive mode)")
    
    else:
        # Interactive mode
        cli = LayoutCLI()
        cli.run()


if __name__ == "__main__":
    main() 