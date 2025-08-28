#!/usr/bin/env python3
"""
NEXUS Main CLI Module
Main command-line interface for NEXUS Workspace Manager
"""

import argparse
import sys
import logging
from pathlib import Path
from typing import Optional

# Add project root to path
project_root = Path(__file__).parent.parent.parent.parent
sys.path.insert(0, str(project_root))

from nexus.core import DynamicLayoutManager
from nexus.utils.logger import setup_logging

logger = logging.getLogger(__name__)

def main():
    """Main CLI entry point for NEXUS."""
    parser = argparse.ArgumentParser(
        description="NEXUS - AI-Powered Workspace Intelligence",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
Examples:
  nexus status                    # Show system status
  nexus optimize                  # Optimize current workspace
  nexus profile list             # List available profiles
  nexus profile switch work      # Switch to work profile
  nexus layout save              # Save current layout
  nexus layout restore default   # Restore default layout
        """
    )
    
    subparsers = parser.add_subparsers(dest='command', help='Available commands')
    
    # Status command
    status_parser = subparsers.add_parser('status', help='Show system status')
    status_parser.add_argument('--verbose', '-v', action='store_true', help='Verbose output')
    
    # Profile commands
    profile_parser = subparsers.add_parser('profile', help='Profile management')
    profile_subparsers = profile_parser.add_subparsers(dest='profile_action', help='Profile actions')
    
    list_parser = profile_subparsers.add_parser('list', help='List available profiles')
    list_parser.add_argument('--active', action='store_true', help='Show only active profile')
    
    switch_parser = profile_subparsers.add_parser('switch', help='Switch to a profile')
    switch_parser.add_argument('profile_name', help='Name of profile to switch to')
    switch_parser.add_argument('--force', action='store_true', help='Force switch without confirmation')
    
    # Layout commands
    layout_parser = subparsers.add_parser('layout', help='Layout management')
    layout_subparsers = layout_parser.add_subparsers(dest='layout_action', help='Layout actions')
    
    save_parser = layout_subparsers.add_parser('save', help='Save current layout')
    save_parser.add_argument('name', help='Name for the saved layout')
    
    restore_parser = layout_subparsers.add_parser('restore', help='Restore a saved layout')
    restore_parser.add_argument('name', help='Name of layout to restore')
    
    # Optimize command
    optimize_parser = subparsers.add_parser('optimize', help='Optimize workspace')
    optimize_parser.add_argument('--ai', action='store_true', help='Use AI-powered optimization')
    optimize_parser.add_argument('--profile', help='Target profile for optimization')
    
    # Version command
    version_parser = subparsers.add_parser('version', help='Show version information')
    
    args = parser.parse_args()
    
    # Setup logging
    setup_logging()
    
    try:
        if args.command == 'status':
            show_status(args.verbose)
        elif args.command == 'profile':
            handle_profile_command(args)
        elif args.command == 'layout':
            handle_layout_command(args)
        elif args.command == 'optimize':
            handle_optimize_command(args)
        elif args.command == 'version':
            show_version()
        else:
            parser.print_help()
            
    except KeyboardInterrupt:
        print("\nOperation cancelled by user.")
        sys.exit(1)
    except Exception as e:
        logger.error(f"Error in main CLI: {e}")
        print(f"Error: {e}")
        sys.exit(1)

def show_status(verbose: bool = False):
    """Show system status."""
    print("🚀 NEXUS Workspace Manager Status")
    print("=" * 40)
    
    try:
        # Initialize core components
        layout_manager = DynamicLayoutManager()
        
        print(f"✅ Core System: Active")
        print(f"✅ Layout Manager: {layout_manager.__class__.__name__}")
        
        if verbose:
            print(f"✅ Python Version: {sys.version}")
            print(f"✅ Project Root: {project_root}")
            
    except Exception as e:
        print(f"❌ Core System: Error - {e}")
    
    print("\nUse 'nexus --help' for available commands")

def handle_profile_command(args):
    """Handle profile-related commands."""
    if args.profile_action == 'list':
        print("📋 Available Profiles:")
        print("=" * 20)
        profiles = [
            "personal", "work", "focus", "gaming", "learning",
            "ai_research", "ai_development", "ai_business",
            "ai_content_creation", "ai_gaming", "ai_learning"
        ]
        for profile in profiles:
            print(f"  • {profile}")
            
    elif args.profile_action == 'switch':
        print(f"🔄 Switching to profile: {args.profile_name}")
        # TODO: Implement profile switching logic
        print("Profile switching feature coming soon...")

def handle_layout_command(args):
    """Handle layout-related commands."""
    if args.layout_action == 'save':
        print(f"💾 Saving layout: {args.name}")
        # TODO: Implement layout saving logic
        print("Layout saving feature coming soon...")
        
    elif args.layout_action == 'restore':
        print(f"🔄 Restoring layout: {args.name}")
        # TODO: Implement layout restoration logic
        print("Layout restoration feature coming soon...")

def handle_optimize_command(args):
    """Handle optimization commands."""
    print("🧠 Workspace Optimization")
    print("=" * 30)
    
    if args.ai:
        print("🤖 Using AI-powered optimization...")
        # TODO: Implement AI optimization
        print("AI optimization feature coming soon...")
    else:
        print("⚡ Using standard optimization...")
        # TODO: Implement standard optimization
        print("Standard optimization feature coming soon...")

def show_version():
    """Show version information."""
    from nexus import __version__, __author__
    print(f"NEXUS Workspace Manager v{__version__}")
    print(f"Author: {__author__}")

if __name__ == "__main__":
    main()

