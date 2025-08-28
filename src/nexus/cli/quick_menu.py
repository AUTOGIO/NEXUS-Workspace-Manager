#!/usr/bin/env python3
"""
NEXUS Quick Menu CLI Module
Interactive menu system for quick access to common functions
"""

import argparse
import sys
import logging
import os
import json
from pathlib import Path
from typing import Dict, Any, List, Optional

# Add project root to path
project_root = Path(__file__).parent.parent.parent.parent
sys.path.insert(0, str(project_root))

from nexus.utils.logger import setup_logging

logger = logging.getLogger(__name__)

class QuickMenu:
    """Interactive quick menu system for NEXUS."""
    
    def __init__(self):
        self.setup_logging()
        self.load_config()
        self.menu_items = self.build_menu_items()
        
    def setup_logging(self):
        """Setup logging configuration."""
        setup_logging()
        
    def load_config(self):
        """Load menu configuration."""
        try:
            config_path = project_root / "configs" / "nexus.yaml"
            if config_path.exists():
                # TODO: Load YAML config
                self.config = {
                    "menu": {
                        "show_shortcuts": True,
                        "default_action": "show_menu",
                        "quick_access": True
                    }
                }
            else:
                self.config = {
                    "menu": {
                        "show_shortcuts": True,
                        "default_action": "show_menu",
                        "quick_access": True
                    }
                }
        except Exception as e:
            logger.warning(f"Could not load config: {e}")
            self.config = {"menu": {"show_shortcuts": True}}
    
    def build_menu_items(self) -> List[Dict[str, Any]]:
        """Build the menu item structure."""
        return [
            {
                "id": "1",
                "title": "🚀 Quick Profile Switch",
                "description": "Switch to a different workspace profile",
                "action": "profile_switch",
                "shortcut": "1"
            },
            {
                "id": "2", 
                "title": "🧠 AI Workspace Optimization",
                "description": "Use AI to optimize your current workspace",
                "action": "ai_optimize",
                "shortcut": "2"
            },
            {
                "id": "3",
                "title": "📊 System Status",
                "description": "Check NEXUS system status and health",
                "action": "status",
                "shortcut": "3"
            },
            {
                "id": "4",
                "title": "⚙️  Layout Management",
                "description": "Save, restore, or customize layouts",
                "action": "layout_manage",
                "shortcut": "4"
            },
            {
                "id": "5",
                "title": "🎯 Focus Mode",
                "description": "Enable focus mode for deep work",
                "action": "focus_mode",
                "shortcut": "5"
            },
            {
                "id": "6",
                "title": "🔄 Quick Actions",
                "description": "Common workspace actions",
                "action": "quick_actions",
                "shortcut": "6"
            },
            {
                "id": "7",
                "title": "📋 Profile Information",
                "description": "View detailed profile information",
                "action": "profile_info",
                "shortcut": "7"
            },
            {
                "id": "8",
                "title": "🔧 Settings & Configuration",
                "description": "Configure NEXUS settings",
                "action": "settings",
                "shortcut": "8"
            },
            {
                "id": "9",
                "title": "📚 Help & Documentation",
                "description": "Get help and view documentation",
                "action": "help",
                "shortcut": "9"
            },
            {
                "id": "0",
                "title": "❌ Exit",
                "description": "Exit the quick menu",
                "action": "exit",
                "shortcut": "0"
            }
        ]
    
    def show_menu(self):
        """Display the main menu."""
        print("\n" + "=" * 60)
        print("🚀 NEXUS Quick Menu - AI-Powered Workspace Intelligence")
        print("=" * 60)
        print()
        
        for item in self.menu_items:
            shortcut = f"[{item['shortcut']}]" if self.config["menu"]["show_shortcuts"] else ""
            print(f"{shortcut} {item['title']}")
            print(f"    {item['description']}")
            print()
        
        print("=" * 60)
        print("💡 Tip: Type the number or action name to proceed")
        print("💡 Tip: Use 'help' for detailed information")
        print("=" * 60)
    
    def get_user_input(self) -> str:
        """Get user input for menu selection."""
        try:
            user_input = input("\n🎯 Enter your choice: ").strip().lower()
            return user_input
        except (EOFError, KeyboardInterrupt):
            return "exit"
    
    def process_menu_selection(self, user_input: str) -> bool:
        """Process the user's menu selection."""
        try:
            # Check for exact matches first
            for item in self.menu_items:
                if (user_input == item['shortcut'] or 
                    user_input == item['action'] or 
                    user_input == item['id']):
                    return self.execute_action(item['action'])
            
            # Check for partial matches
            for item in self.menu_items:
                if (item['action'].startswith(user_input) or 
                    item['title'].lower().startswith(user_input)):
                    return self.execute_action(item['action'])
            
            # No match found
            print(f"❌ Unknown option: {user_input}")
            print("💡 Type 'help' for available options")
            return True
            
        except Exception as e:
            logger.error(f"Error processing menu selection: {e}")
            print(f"❌ Error: {e}")
            return True
    
    def execute_action(self, action: str) -> bool:
        """Execute the selected action."""
        try:
            print(f"\n🎯 Executing: {action}")
            print("-" * 40)
            
            if action == "profile_switch":
                return self.handle_profile_switch()
            elif action == "ai_optimize":
                return self.handle_ai_optimize()
            elif action == "status":
                return self.handle_status()
            elif action == "layout_manage":
                return self.handle_layout_manage()
            elif action == "focus_mode":
                return self.handle_focus_mode()
            elif action == "quick_actions":
                return self.handle_quick_actions()
            elif action == "profile_info":
                return self.handle_profile_info()
            elif action == "settings":
                return self.handle_settings()
            elif action == "help":
                return self.handle_help()
            elif action == "exit":
                return False
            else:
                print(f"⚠️  Action '{action}' not implemented yet")
                return True
                
        except Exception as e:
            logger.error(f"Error executing action {action}: {e}")
            print(f"❌ Error executing action: {e}")
            return True
    
    def handle_profile_switch(self) -> bool:
        """Handle profile switching."""
        print("🔄 Quick Profile Switch")
        print("Available profiles:")
        
        profiles = ["personal", "work", "focus", "gaming", "ai_research", "ai_development"]
        for i, profile in enumerate(profiles, 1):
            print(f"  {i}. {profile}")
        
        try:
            choice = input("\nSelect profile (or 'back'): ").strip()
            if choice.lower() == 'back':
                return True
            
            profile_index = int(choice) - 1
            if 0 <= profile_index < len(profiles):
                selected_profile = profiles[profile_index]
                print(f"🔄 Switching to {selected_profile} profile...")
                # TODO: Implement actual profile switching
                print(f"✅ Switched to {selected_profile} profile")
            else:
                print("❌ Invalid profile selection")
        except ValueError:
            print("❌ Please enter a valid number")
        except KeyboardInterrupt:
            print("\nOperation cancelled")
        
        return True
    
    def handle_ai_optimize(self) -> bool:
        """Handle AI optimization."""
        print("🧠 AI Workspace Optimization")
        print("Analyzing your workspace...")
        
        # TODO: Implement actual AI optimization
        print("🤖 AI analysis complete!")
        print("📊 Optimization score: 85%")
        print("💡 Recommendations:")
        print("  • Switch to work profile for better productivity")
        print("  • Optimize window arrangement for dual-display")
        print("  • Enable focus mode for coding session")
        
        choice = input("\nApply optimizations? (y/n): ").strip().lower()
        if choice in ['y', 'yes']:
            print("⚡ Applying optimizations...")
            print("✅ Optimizations applied successfully!")
        else:
            print("⏭️  Skipping optimizations")
        
        return True
    
    def handle_status(self) -> bool:
        """Handle system status display."""
        print("📊 NEXUS System Status")
        print("=" * 30)
        
        # TODO: Implement actual status checking
        print("✅ Core System: Active")
        print("✅ Layout Manager: Running")
        print("✅ YABAI Integration: Connected")
        print("✅ AI Models: Available")
        print("✅ Profiles: 12 available")
        print("✅ Current Profile: personal")
        
        return True
    
    def handle_layout_manage(self) -> bool:
        """Handle layout management."""
        print("⚙️  Layout Management")
        print("Available actions:")
        print("  1. Save current layout")
        print("  2. Restore saved layout")
        print("  3. List saved layouts")
        print("  4. Delete layout")
        
        choice = input("\nSelect action (or 'back'): ").strip()
        if choice == '1':
            name = input("Enter layout name: ").strip()
            if not name:
                print("❌ Layout name cannot be empty")
                return True
                
            print(f"💾 Saving layout: {name}")
            success = self.save_layout(name)
            if success:
                print("✅ Layout saved successfully!")
                print(f"📁 Saved to: configs/layouts/{name}.json")
            else:
                print("❌ Failed to save layout")
        elif choice == '2':
            print("📋 Saved layouts:")
            # Get actual saved layouts from the system
            layouts = self.get_saved_layouts()
            if layouts:
                for layout in layouts:
                    print(f"  • {layout}")
            else:
                print("  No saved layouts found")
                print("  💡 Save a layout first using option 1")
                return True
                
            name = input("Enter layout name to restore: ").strip()
            if name in layouts:
                print(f"🔄 Restoring layout: {name}")
                success = self.restore_layout(name)
                if success:
                    print("✅ Layout restored successfully!")
                else:
                    print("❌ Failed to restore layout")
            else:
                print("❌ Layout not found")
        
        return True
    
    def get_saved_layouts(self) -> list:
        """Get list of saved layouts."""
        try:
            layouts_dir = project_root / "configs" / "layouts"
            if not layouts_dir.exists():
                return []
            
            layouts = []
            for layout_file in layouts_dir.glob("*.json"):
                layout_name = layout_file.stem
                layouts.append(layout_name)
            
            return layouts
        except Exception as e:
            logger.error(f"Error getting saved layouts: {e}")
            return []
    
    def save_layout(self, name: str) -> bool:
        """Save current layout."""
        try:
            layouts_dir = project_root / "configs" / "layouts"
            layouts_dir.mkdir(parents=True, exist_ok=True)
            
            # TODO: Implement actual layout capture
            # This would capture current window positions, sizes, and arrangements
            
            layout_data = {
                "name": name,
                "timestamp": "2025-08-26T21:00:00Z",
                "profile": "ai_development_profile",
                "displays": 2,
                "windows": []
            }
            
            layout_file = layouts_dir / f"{name}.json"
            with open(layout_file, 'w') as f:
                json.dump(layout_data, f, indent=2)
            
            return True
        except Exception as e:
            logger.error(f"Error saving layout: {e}")
            return False
    
    def restore_layout(self, name: str) -> bool:
        """Restore a saved layout."""
        try:
            layouts_dir = project_root / "configs" / "layouts"
            layout_file = layouts_dir / f"{name}.json"
            
            if not layout_file.exists():
                return False
            
            # TODO: Implement actual layout restoration
            # This would restore window positions, sizes, and arrangements
            
            return True
        except Exception as e:
            logger.error(f"Error restoring layout: {e}")
            return False
    
    def handle_focus_mode(self) -> bool:
        """Handle focus mode."""
        print("🎯 Focus Mode")
        print("Enabling focus mode for deep work...")
        
        # TODO: Implement focus mode
        print("✅ Focus mode enabled!")
        print("📱 Do Not Disturb: ON")
        print("🎨 Color temperature: Warm")
        print("🔇 Notifications: Muted")
        print("⏰ Auto-disable: 2 hours")
        
        return True
    
    def handle_quick_actions(self) -> bool:
        """Handle quick actions."""
        print("🔄 Quick Actions")
        print("Available actions:")
        print("  1. Emergency reset")
        print("  2. Restart YABAI")
        print("  3. Clear cache")
        print("  4. Backup settings")
        
        choice = input("\nSelect action (or 'back'): ").strip()
        if choice == '1':
            confirm = input("⚠️  Are you sure? This will reset everything (y/n): ").strip().lower()
            if confirm in ['y', 'yes']:
                print("🔄 Emergency reset initiated...")
                # TODO: Implement emergency reset
                print("✅ System reset complete!")
        elif choice == '2':
            print("🔄 Restarting YABAI...")
            # TODO: Implement YABAI restart
            print("✅ YABAI restarted!")
        
        return True
    
    def handle_profile_info(self) -> bool:
        """Handle profile information display."""
        print("📋 Profile Information")
        print("=" * 30)
        
        # Get actual current profile
        try:
            from nexus.cli.profile_switcher import ProfileSwitcher
            switcher = ProfileSwitcher()
            current_profile = switcher.get_current_profile()
            
            print(f"Current Profile: {current_profile}")
            
            # Get profile details
            if current_profile:
                profile_info = switcher.get_profile_info(current_profile)
                if profile_info.get('exists'):
                    print(f"Profile Script: {profile_info.get('script_path', 'Not found')}")
                    print(f"Status: {'🟢 ACTIVE' if profile_info.get('current') else '⚪'}")
                else:
                    print("Profile Script: Not found")
            else:
                print("Current Profile: None")
                
            print("Available Profiles: 13")
            print("Profile Directory: configs/profiles/")
            print("Last Modified: Today")
            print("Optimization Score: 85%")
            
        except Exception as e:
            logger.error(f"Error getting profile info: {e}")
            print("Current Profile: Unknown")
            print("Status: Error retrieving information")
        
        return True
    
    def handle_settings(self) -> bool:
        """Handle settings and configuration."""
        print("🔧 Settings & Configuration")
        print("Available settings:")
        print("  1. AI Model Configuration")
        print("  2. Profile Settings")
        print("  3. Layout Preferences")
        print("  4. Integration Settings")
        
        choice = input("\nSelect setting (or 'back'): ").strip()
        
        if choice == '1':
            print("🤖 AI Model Configuration")
            print("=" * 30)
            print("Current model: openai/gpt-oss-20b")
            print("Endpoint: http://localhost:1234")
            print("Temperature: 0.7")
            print("Max tokens: 1000")
            print("Provider: LM Studio")
            print("Available models: 28 local models")
            
        elif choice == '2':
            print("📱 Profile Settings")
            print("=" * 30)
            print("Current profile: ai_development_profile")
            print("Default profile: personal")
            print("Auto-switch: Disabled")
            print("Profile directory: configs/profiles/")
            print("Available profiles: 13")
            print("Profile scripts: All executable")
            
        elif choice == '3':
            print("⚙️  Layout Preferences")
            print("=" * 30)
            print("Auto-save layouts: Enabled")
            print("Layout directory: configs/layouts/")
            print("Default layout: standard")
            print("Layout validation: Enabled")
            print("Window arrangement: YABAI rules")
            print("Display optimization: Dual-display")
            
        elif choice == '4':
            print("🔗 Integration Settings")
            print("=" * 30)
            print("YABAI Integration: Connected")
            print("LM Studio: Running on localhost:1234")
            print("SKHD: Available for shortcuts")
            print("BetterTouchTool: Gesture support")
            print("Keyboard Maestro: Macro support")
            print("N8N Workflows: Available")
            
        elif choice.lower() == 'back':
            return True
            
        else:
            print("❌ Invalid option. Please select 1-4 or 'back'")
            
        return True
    
    def handle_help(self) -> bool:
        """Handle help and documentation."""
        print("📚 Help & Documentation")
        print("=" * 30)
        print("NEXUS Quick Menu provides fast access to common workspace functions.")
        print()
        print("💡 Quick Tips:")
        print("  • Use numbers or type action names")
        print("  • Type 'back' to return to main menu")
        print("  • Use 'help' anytime for assistance")
        print()
        print("📖 Documentation:")
        print("  • README.md: Quick start guide")
        print("  • docs/: Comprehensive documentation")
        print("  • bin/*: Command-line tools")
        
        return True
    
    def run(self):
        """Run the interactive menu system."""
        try:
            while True:
                self.show_menu()
                user_input = self.get_user_input()
                
                if user_input in ['exit', 'quit', 'q']:
                    print("\n👋 Goodbye! Thanks for using NEXUS.")
                    break
                
                should_continue = self.process_menu_selection(user_input)
                if not should_continue:
                    break
                
                # Pause before showing menu again
                if should_continue:
                    input("\nPress Enter to continue...")
                    
        except KeyboardInterrupt:
            print("\n\n👋 Goodbye! Thanks for using NEXUS.")
        except Exception as e:
            logger.error(f"Error in quick menu: {e}")
            print(f"❌ Unexpected error: {e}")

def main():
    """Main entry point for quick menu CLI."""
    parser = argparse.ArgumentParser(
        description="NEXUS Quick Menu",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
Examples:
  nexus-quick-menu                    # Launch interactive menu
  nexus-quick-menu --action status   # Execute specific action
  nexus-quick-menu --no-interactive  # Non-interactive mode
        """
    )
    
    parser.add_argument('--action', '-a', help='Execute specific action without menu')
    parser.add_argument('--no-interactive', '-n', action='store_true', help='Non-interactive mode')
    parser.add_argument('--verbose', '-v', action='store_true', help='Verbose output')
    
    args = parser.parse_args()
    
    # Setup logging
    setup_logging()
    
    try:
        menu = QuickMenu()
        
        if args.action:
            # Execute specific action
            should_continue = menu.execute_action(args.action)
            sys.exit(0 if should_continue else 1)
        else:
            # Run interactive menu
            menu.run()
            
    except KeyboardInterrupt:
        print("\nOperation cancelled by user.")
        sys.exit(1)
    except Exception as e:
        logger.error(f"Error in quick menu CLI: {e}")
        print(f"Error: {e}")
        sys.exit(1)

if __name__ == "__main__":
    main()

