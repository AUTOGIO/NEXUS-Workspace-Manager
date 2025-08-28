"""
AI Model Analytics UI for NEXUS Dashboard

Enhanced interface for model performance tracking and analytics.
"""

import streamlit as st
import sys
from pathlib import Path
from datetime import datetime, timedelta

# Add project root to path for imports
project_root = Path(__file__).parent.parent
sys.path.insert(0, str(project_root))

from src.nexus.models.manager import ModelManager, ModelPerformance, ModelUsage


def render_model_analytics_panel():
    """Render the enhanced AI model analytics panel."""
    st.header("📊 AI Model Analytics & Performance")
    st.markdown("Track performance, usage patterns, and get intelligent recommendations")
    
    # Initialize model manager
    try:
        manager = ModelManager()
        st.success("✅ Model Manager initialized successfully")
    except Exception as e:
        st.error(f"❌ Failed to initialize Model Manager: {e}")
        return
    
    # Create tabs for different analytics views
    tab1, tab2, tab3, tab4 = st.tabs([
        "📈 Performance Overview", 
        "🎯 Model Recommendations", 
        "📊 Usage Analytics", 
        "⚡ Quick Actions"
    ])
    
    with tab1:
        render_performance_overview(manager)
    
    with tab2:
        render_model_recommendations(manager)
    
    with tab3:
        render_usage_analytics(manager)
    
    with tab4:
        render_quick_actions(manager)


def render_performance_overview(manager: ModelManager):
    """Render the performance overview tab."""
    st.subheader("📈 Performance Overview")
    
    # Get performance summary
    try:
        summary = manager.get_performance_summary()
        
        # Display key metrics
        col1, col2, col3, col4 = st.columns(4)
        
        with col1:
            st.metric("Models Tracked", summary['total_models_tracked'])
        
        with col2:
            st.metric("Total Sessions", summary['total_usage_sessions'])
        
        with col3:
            if summary['average_user_rating']:
                st.metric("Avg Rating", f"{summary['average_user_rating']}/5")
            else:
                st.metric("Avg Rating", "No ratings yet")
        
        with col4:
            if summary['most_used_model']:
                st.metric("Most Used", summary['most_used_count'])
            else:
                st.metric("Most Used", "No usage yet")
        
        # Top models by usage
        st.subheader("🏆 Top Models by Usage")
        top_models = manager.get_top_models_by_usage(5)
        
        if top_models:
            for i, (model_path, usage_count) in enumerate(top_models):
                model_name = Path(model_path).name
                st.write(f"{i+1}. **{model_name}** - Used {usage_count} times")
        else:
            st.info("No usage data available yet. Start using models to see analytics!")
            
    except Exception as e:
        st.error(f"Error loading performance data: {e}")


def render_model_recommendations(manager: ModelManager):
    """Render the model recommendations tab."""
    st.subheader("🎯 Smart Model Recommendations")
    
    # Task type selection
    task_type = st.selectbox(
        "What type of task are you planning?",
        ["", "reasoning", "coding", "embedding", "general"],
        help="Select a task type to get specialized recommendations"
    )
    
    if st.button("🔍 Get Recommendations", type="primary"):
        with st.spinner("Analyzing your models and performance data..."):
            try:
                recommendations = manager.get_model_recommendations(task_type)
                
                if recommendations:
                    st.success(f"Found {len(recommendations)} recommended models!")
                    
                    # Display recommendations
                    for i, rec in enumerate(recommendations):
                        model = rec['model']
                        performance = rec['performance']
                        score = rec['score']
                        reason = rec['recommendation_reason']
                        
                        with st.expander(f"🥇 {model.name} (Score: {score})", expanded=i < 3):
                            col1, col2 = st.columns([2, 1])
                            
                            with col1:
                                st.write(f"**🏗️ Architecture:** {model.architecture or 'Unknown'}")
                                st.write(f"**🔢 Parameters:** {model.parameters or 'Unknown'}")
                                st.write(f"**💾 Size:** {model.size_human}")
                                st.write(f"**⭐ Reason:** {reason}")
                            
                            with col2:
                                if performance:
                                    if performance.load_time_ms:
                                        st.write(f"**⚡ Load Time:** {performance.load_time_ms}ms")
                                    if performance.memory_usage_mb:
                                        st.write(f"**🧠 Memory:** {performance.memory_usage_mb}MB")
                                    if performance.usage_count > 0:
                                        st.write(f"**📊 Used:** {performance.usage_count} times")
                                else:
                                    st.write("**🆕 New Model**")
                            
                            # Action buttons
                            col1, col2, col3 = st.columns(3)
                            with col1:
                                if st.button("🚀 Launch", key=f"launch_rec_{i}"):
                                    st.success(f"Launching {model.name}...")
                            
                            with col2:
                                if st.button("📊 Rate", key=f"rate_rec_{i}"):
                                    render_rating_form(manager, str(model.path))
                            
                            with col3:
                                if st.button("📝 Notes", key=f"notes_rec_{i}"):
                                    render_notes_form(manager, str(model.path))
                else:
                    st.warning("No recommendations found. Try scanning for models first.")
                    
            except Exception as e:
                st.error(f"Error getting recommendations: {e}")


def render_usage_analytics(manager: ModelManager):
    """Render the usage analytics tab."""
    st.subheader("📊 Usage Analytics")
    
    # Model selection for detailed analytics
    models = manager.scanner.scan_models()
    if not models:
        st.warning("No models found. Scan for models first.")
        return
    
    # Create model selector
    model_paths = [str(m.path) for m in models]
    selected_model = st.selectbox(
        "Select a model for detailed analytics:",
        model_paths,
        format_func=lambda x: Path(x).name
    )
    
    if selected_model:
        # Get performance data
        performance = manager.get_model_performance(selected_model)
        
        if performance:
            st.write(f"**📊 Performance Data for {Path(selected_model).name}**")
            
            col1, col2 = st.columns(2)
            
            with col1:
                if performance.load_time_ms:
                    st.metric("Load Time", f"{performance.load_time_ms}ms")
                if performance.memory_usage_mb:
                    st.metric("Memory Usage", f"{performance.memory_usage_mb}MB")
                if performance.inference_speed_tokens_per_sec:
                    st.metric("Inference Speed", f"{performance.inference_speed_tokens_per_sec:.1f} tokens/sec")
            
            with col2:
                st.metric("Usage Count", performance.usage_count)
                st.metric("Total Tokens", performance.total_tokens_processed)
                if performance.average_response_time_ms:
                    st.metric("Avg Response", f"{performance.average_response_time_ms:.1f}ms")
            
            # Usage history
            st.subheader("📅 Usage History (Last 30 Days)")
            usage_history = manager.get_model_usage_history(selected_model, 30)
            
            if usage_history:
                for session in usage_history[:10]:  # Show last 10 sessions
                    with st.expander(f"Session: {session.session_start.strftime('%Y-%m-%d %H:%M')}"):
                        col1, col2 = st.columns(2)
                        
                        with col1:
                            st.write(f"**Duration:** {session.session_end - session.session_start if session.session_end else 'Active'}")
                            st.write(f"**Tokens:** {session.tokens_processed}")
                        
                        with col2:
                            if session.memory_peak_mb:
                                st.write(f"**Memory Peak:** {session.memory_peak_mb}MB")
                            if session.cpu_usage_percent:
                                st.write(f"**CPU Usage:** {session.cpu_usage_percent:.1f}%")
                            if session.user_rating:
                                st.write(f"**Rating:** {'⭐' * session.user_rating}")
                        
                        if session.notes:
                            st.write(f"**Notes:** {session.notes}")
            else:
                st.info("No usage history available for this model.")
        else:
            st.info("No performance data available for this model yet.")
            
            # Show form to add initial performance data
            st.subheader("➕ Add Initial Performance Data")
            render_performance_form(manager, selected_model)


def render_quick_actions(manager: ModelManager):
    """Render the quick actions tab."""
    st.subheader("⚡ Quick Actions")
    
    col1, col2 = st.columns(2)
    
    with col1:
        st.write("**📊 Performance Tracking**")
        
        if st.button("🔄 Refresh Analytics", use_container_width=True):
            st.rerun()
        
        if st.button("📈 Export Performance Data", use_container_width=True):
            st.info("Exporting performance data...")
            # TODO: Implement export functionality
        
        if st.button("🧹 Clean Old Data", use_container_width=True):
            st.info("Cleaning old performance data...")
            # TODO: Implement cleanup functionality
    
    with col2:
        st.write("**🎯 Model Management**")
        
        if st.button("📝 Add Performance Note", use_container_width=True):
            st.info("Select a model to add performance notes")
            # TODO: Implement note adding
        
        if st.button("⭐ Rate Recent Models", use_container_width=True):
            st.info("Rate your recently used models")
            # TODO: Implement rating interface
        
        if st.button("⚙️ Settings", use_container_width=True):
            st.info("Opening model management settings...")
            # TODO: Implement settings


def render_rating_form(manager: ModelManager, model_path: str):
    """Render a form for rating a model."""
    st.write(f"**Rate: {Path(model_path).name}**")
    
    rating = st.slider("Rating", 1, 5, 3, help="1 = Poor, 5 = Excellent")
    notes = st.text_area("Notes (optional)", placeholder="What did you think of this model?")
    
    if st.button("💾 Save Rating"):
        try:
            # Create usage session with rating
            usage = ModelUsage(
                model_path=model_path,
                session_start=datetime.now(),
                session_end=datetime.now(),
                tokens_processed=0,
                user_rating=rating,
                notes=notes
            )
            
            manager.record_model_usage(usage)
            st.success("Rating saved successfully!")
            
        except Exception as e:
            st.error(f"Error saving rating: {e}")


def render_notes_form(manager: ModelManager, model_path: str):
    """Render a form for adding notes to a model."""
    st.write(f"**Add Notes: {Path(model_path).name}**")
    
    notes = st.text_area("Notes", placeholder="Add your thoughts about this model...")
    
    if st.button("💾 Save Notes"):
        try:
            # Create usage session with notes
            usage = ModelUsage(
                model_path=model_path,
                session_start=datetime.now(),
                session_end=datetime.now(),
                tokens_processed=0,
                notes=notes
            )
            
            manager.record_model_usage(usage)
            st.success("Notes saved successfully!")
            
        except Exception as e:
            st.error(f"Error saving notes: {e}")


def render_performance_form(manager: ModelManager, model_path: str):
    """Render a form for adding performance data."""
    st.write(f"**Add Performance Data: {Path(model_path).name}**")
    
    col1, col2 = st.columns(2)
    
    with col1:
        load_time = st.number_input("Load Time (ms)", min_value=0, value=1000)
        memory_usage = st.number_input("Memory Usage (MB)", min_value=0, value=1000)
    
    with col2:
        inference_speed = st.number_input("Inference Speed (tokens/sec)", min_value=0.0, value=10.0, step=0.1)
        response_time = st.number_input("Average Response Time (ms)", min_value=0, value=500)
    
    if st.button("💾 Save Performance Data"):
        try:
            performance = ModelPerformance(
                model_path=model_path,
                load_time_ms=load_time,
                memory_usage_mb=memory_usage,
                inference_speed_tokens_per_sec=inference_speed,
                average_response_time_ms=response_time,
                last_used=datetime.now(),
                usage_count=1
            )
            
            manager.update_model_performance(performance)
            st.success("Performance data saved successfully!")
            st.rerun()
            
        except Exception as e:
            st.error(f"Error saving performance data: {e}")
