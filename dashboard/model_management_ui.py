"""
AI Model Management UI for NEXUS Dashboard

Provides a comprehensive interface for managing local AI models.
"""

import streamlit as st
import sys
from pathlib import Path

# Add project root to path for imports
project_root = Path(__file__).parent.parent
sys.path.insert(0, str(project_root))

from src.nexus.models.scanner import ModelScanner, ModelMetadata


def render_model_management_panel():
    """Render the main AI model management panel."""
    st.header("🤖 Local AI Models")
    st.markdown("Discover and manage your local AI model collection")
    
    # Initialize scanner
    scanner = ModelScanner()
    
    # Scan for models
    with st.spinner("🔍 Scanning for AI models..."):
        models = scanner.scan_models()
    
    if not models:
        st.warning("⚠️ No AI models found in configured directories.")
        st.info("💡 Make sure your models are in one of these locations:")
        for directory in scanner.model_directories:
            st.code(directory)
        return
    
    # Display summary statistics
    stats = scanner.get_summary_stats(models)
    display_summary_stats(stats)
    
    # Display models in organized grid
    display_models_grid(models)
    
    # Display detailed model information
    display_model_details(models)


def display_summary_stats(stats: dict):
    """Display summary statistics for the model collection."""
    st.subheader("📊 Collection Overview")
    
    # Create columns for stats
    col1, col2, col3, col4 = st.columns(4)
    
    with col1:
        st.metric("Total Models", stats['total_models'])
    
    with col2:
        st.metric("Total Size", stats['total_size_human'])
    
    with col3:
        st.metric("File Types", len(stats['file_types']))
    
    with col4:
        st.metric("Architectures", len(stats['architectures']))
    
    # Detailed breakdowns
    st.subheader("🔍 Detailed Breakdown")
    
    # Architecture distribution
    col1, col2 = st.columns(2)
    
    with col1:
        st.write("**🏗️ By Architecture**")
        for arch, count in stats['architectures'].items():
            if arch != 'unknown':
                st.write(f"• {arch.title()}: {count} models")
    
    with col2:
        st.write("**📁 By File Type**")
        for file_type, count in stats['file_types'].items():
            st.write(f"• {file_type.upper()}: {count} models")
    
    # Quantization breakdown
    if stats['quantizations']:
        st.write("**⚡ By Quantization**")
        quant_cols = st.columns(min(4, len(stats['quantizations'])))
        for i, (quant, count) in enumerate(stats['quantizations'].items()):
            if quant != 'unknown':
                with quant_cols[i % len(quant_cols)]:
                    st.write(f"• {quant}: {count}")


def display_models_grid(models: list[ModelMetadata]):
    """Display models in an organized grid with filtering."""
    st.subheader("🎯 Model Collection")
    
    # Filtering options
    col1, col2, col3 = st.columns(3)
    
    with col1:
        # Architecture filter
        architectures = ['All'] + sorted(list(set(m.architecture for m in models if m.architecture)))
        selected_arch = st.selectbox("🏗️ Architecture", architectures)
    
    with col2:
        # File type filter
        file_types = ['All'] + sorted(list(set(m.file_type for m in models)))
        selected_type = st.selectbox("📁 File Type", file_types)
    
    with col3:
        # Search filter
        search_term = st.text_input("🔍 Search Models", placeholder="Search by name, tags...")
    
    # Apply filters
    filtered_models = models
    if selected_arch != 'All':
        filtered_models = [m for m in filtered_models if m.architecture == selected_arch]
    if selected_type != 'All':
        filtered_models = [m for m in filtered_models if m.file_type == selected_type]
    if search_term:
        filtered_models = [m for m in filtered_models if search_term.lower() in m.name.lower() or 
                          any(search_term.lower() in tag.lower() for tag in m.tags)]
    
    # Display filtered results
    st.write(f"**Found {len(filtered_models)} models**")
    
    # Create model cards
    if filtered_models:
        # Group models by architecture for better organization
        arch_groups = {}
        for model in filtered_models:
            arch = model.architecture or 'Unknown'
            if arch not in arch_groups:
                arch_groups[arch] = []
            arch_groups[arch].append(model)
        
        # Display by architecture groups
        for arch, arch_models in arch_groups.items():
            st.write(f"**🏗️ {arch.title()} Models**")
            
            # Create columns for this architecture group
            cols = st.columns(min(3, len(arch_models)))
            
            for i, model in enumerate(arch_models):
                with cols[i % len(cols)]:
                    display_model_card(model)


def display_model_card(model: ModelMetadata):
    """Display a single model in a card format."""
    # Create expandable card
    with st.expander(f"🤖 {model.name}", expanded=False):
        # Model info
        st.write(f"**📁 Path:** `{model.path}`")
        st.write(f"**💾 Size:** {model.size_human}")
        st.write(f"**📅 Modified:** {model.last_modified.strftime('%Y-%m-%d %H:%M')}")
        
        # Architecture and parameters
        if model.architecture:
            st.write(f"**🏗️ Architecture:** {model.architecture.title()}")
        if model.parameters:
            st.write(f"**🔢 Parameters:** {model.parameters}")
        if model.quantization:
            st.write(f"**⚡ Quantization:** {model.quantization}")
        if model.publisher:
            st.write(f"**🏢 Publisher:** {model.publisher}")
        
        # Tags
        if model.tags:
            st.write("**🏷️ Tags:**")
            tag_cols = st.columns(min(4, len(model.tags)))
            for i, tag in enumerate(model.tags):
                with tag_cols[i % len(tag_cols)]:
                    st.write(f"• {tag}")
        
        # Actions
        col1, col2, col3 = st.columns(3)
        
        with col1:
            if st.button("📊 Info", key=f"info_{model.name}", use_container_width=True):
                st.info(f"Detailed information for {model.name}")
        
        with col2:
            if st.button("🚀 Launch", key=f"launch_{model.name}", use_container_width=True):
                st.success(f"Launching {model.name}...")
                # TODO: Implement model launching
        
        with col3:
            if st.button("⚙️ Configure", key=f"config_{model.name}", use_container_width=True):
                st.info(f"Configuring {model.name}...")
                # TODO: Implement model configuration


def display_model_details(models: list[ModelMetadata]):
    """Display detailed model information and analytics."""
    st.subheader("📈 Model Analytics")
    
    # Performance metrics
    col1, col2 = st.columns(2)
    
    with col1:
        st.write("**📊 Size Distribution**")
        # Group by size ranges
        size_ranges = {
            'Small (<1GB)': 0,
            'Medium (1-10GB)': 0,
            'Large (10-50GB)': 0,
            'Huge (>50GB)': 0
        }
        
        for model in models:
            size_gb = model.size_bytes / (1024**3)
            if size_gb < 1:
                size_ranges['Small (<1GB)'] += 1
            elif size_gb < 10:
                size_ranges['Medium (1-10GB)'] += 1
            elif size_gb < 50:
                size_ranges['Large (10-50GB)'] += 1
            else:
                size_ranges['Huge (>50GB)'] += 1
        
        for range_name, count in size_ranges.items():
            if count > 0:
                st.write(f"• {range_name}: {count} models")
    
    with col2:
        st.write("**🕒 Recent Models**")
        # Show recently modified models
        recent_models = sorted(models, key=lambda x: x.last_modified, reverse=True)[:5]
        for model in recent_models:
            st.write(f"• {model.name} ({model.last_modified.strftime('%m/%d')})")
    
    # Storage optimization suggestions
    st.subheader("💡 Storage Optimization")
    
    # Find largest models
    largest_models = sorted(models, key=lambda x: x.size_bytes, reverse=True)[:5]
    
    st.write("**🐘 Largest Models (consider quantization):**")
    for model in largest_models:
        size_gb = model.size_bytes / (1024**3)
        if size_gb > 10:  # Only suggest for very large models
            st.write(f"• {model.name}: {model.size_human}")
            if not model.quantization:
                st.write(f"  💡 Consider quantizing to save space")
    
    # Model recommendations
    st.subheader("🎯 Model Recommendations")
    
    # Find models by use case
    reasoning_models = [m for m in models if 'reasoning' in m.name.lower() or 'phi' in m.name.lower()]
    coding_models = [m for m in models if 'code' in m.name.lower() or 'coding' in m.name.lower()]
    embedding_models = [m for m in models if 'embedding' in m.name.lower()]
    
    if reasoning_models:
        st.write("**🧠 Best for Reasoning:**")
        for model in reasoning_models[:3]:
            st.write(f"• {model.name} ({model.parameters or 'N/A'})")
    
    if coding_models:
        st.write("**💻 Best for Coding:**")
        for model in coding_models[:3]:
            st.write(f"• {model.name} ({model.parameters or 'N/A'})")
    
    if embedding_models:
        st.write("**🔍 Best for Embeddings:**")
        for model in embedding_models[:3]:
            st.write(f"• {model.name} ({model.parameters or 'N/A'})")


def render_quick_actions():
    """Render quick action buttons for model management."""
    st.subheader("⚡ Quick Actions")
    
    col1, col2, col3, col4 = st.columns(4)
    
    with col1:
        if st.button("🔄 Rescan Models", use_container_width=True):
            st.rerun()
    
    with col2:
        if st.button("📊 Export List", use_container_width=True):
            st.info("Exporting model list...")
            # TODO: Implement export functionality
    
    with col3:
        if st.button("🧹 Clean Up", use_container_width=True):
            st.info("Analyzing for cleanup...")
            # TODO: Implement cleanup suggestions
    
    with col4:
        if st.button("⚙️ Settings", use_container_width=True):
            st.info("Opening settings...")
            # TODO: Implement settings panel
