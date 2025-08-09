#!/usr/bin/env python3
"""
NEXUS Interactive Web Dashboard
Revolutionary AI-Powered Workspace Intelligence Interface

Designer: Manus AI (Web Designer)
Project: NEXUS Workspace Intelligence Dashboard
Design Philosophy: Modern, Intuitive, Intelligent, Responsive
"""

import streamlit as st
import plotly.graph_objects as go
import plotly.express as px
import pandas as pd
import numpy as np
import json
import os
import time
from datetime import datetime, timedelta
import subprocess
from pathlib import Path

# Page configuration with modern theme
st.set_page_config(
    page_title="NEXUS - Workspace Intelligence",
    page_icon="🧠",
    layout="wide",
    initial_sidebar_state="expanded",
    menu_items={
        'Get Help': None,
        'Report a bug': None,
        'About': "NEXUS - Neural EXperience Unified System\nAI-Powered Workspace Intelligence for Apple Silicon"
    }
)

# Modern CSS with Neural Workspace design language
st.markdown("""
<style>
    /* Neural Workspace Design System */
    :root {
        --neural-blue: #1a237e;
        --synaptic-cyan: #00bcd4;
        --quantum-green: #4caf50;
        --neural-orange: #ff9800;
        --synaptic-red: #f44336;
        --neural-dark: #0a0a0a;
        --neural-gray: #1e1e1e;
    }
    
    /* Main container styling */
    .main .block-container {
        padding-top: 1rem;
        padding-bottom: 0rem;
        background: linear-gradient(135deg, #0a0a0a 0%, #1e1e1e 100%);
        border-radius: 15px;
        box-shadow: 0 20px 40px rgba(0, 0, 0, 0.3);
    }
    
    /* Header styling */
    .header-container {
        background: linear-gradient(90deg, var(--neural-blue) 0%, var(--synaptic-cyan) 100%);
        padding: 1.5rem;
        border-radius: 15px;
        margin-bottom: 2rem;
        box-shadow: 0 10px 30px rgba(26, 35, 126, 0.3);
        border: 1px solid rgba(0, 188, 212, 0.2);
    }
    
    .header-title {
        color: white;
        font-size: 2.5rem;
        font-weight: 700;
        font-family: 'Inter Display', sans-serif;
        margin: 0;
        text-shadow: 0 2px 10px rgba(0, 0, 0, 0.3);
    }
    
    .header-subtitle {
        color: rgba(255, 255, 255, 0.9);
        font-size: 1.1rem;
        font-weight: 400;
        margin: 0.5rem 0 0 0;
        font-family: 'Inter', sans-serif;
    }
    
    /* Card styling */
    .metric-card {
        background: linear-gradient(135deg, rgba(26, 35, 126, 0.1) 0%, rgba(0, 188, 212, 0.05) 100%);
        padding: 1.5rem;
        border-radius: 12px;
        border: 1px solid rgba(0, 188, 212, 0.2);
        box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15);
        margin-bottom: 1rem;
        transition: all 0.3s ease;
        backdrop-filter: blur(10px);
    }
    
    .metric-card:hover {
        transform: translateY(-2px);
        box-shadow: 0 12px 35px rgba(0, 188, 212, 0.2);
        border-color: var(--synaptic-cyan);
    }
    
    .metric-title {
        color: var(--synaptic-cyan);
        font-size: 0.9rem;
        font-weight: 600;
        text-transform: uppercase;
        letter-spacing: 1px;
        margin-bottom: 0.5rem;
    }
    
    .metric-value {
        color: white;
        font-size: 2rem;
        font-weight: 700;
        font-family: 'JetBrains Mono', monospace;
    }
    
    .metric-change {
        font-size: 0.8rem;
        font-weight: 500;
        margin-top: 0.3rem;
    }
    
    .metric-change.positive {
        color: var(--quantum-green);
    }
    
    .metric-change.negative {
        color: var(--synaptic-red);
    }
    
    /* Profile cards */
    .profile-card {
        background: linear-gradient(135deg, rgba(76, 175, 80, 0.1) 0%, rgba(255, 152, 0, 0.05) 100%);
        border: 1px solid rgba(76, 175, 80, 0.3);
        border-radius: 12px;
        padding: 1.2rem;
        margin: 0.8rem 0;
        transition: all 0.3s ease;
        cursor: pointer;
    }
    
    .profile-card:hover {
        transform: translateX(5px);
        border-color: var(--quantum-green);
        box-shadow: 0 8px 25px rgba(76, 175, 80, 0.2);
    }
    
    .profile-card.active {
        border-color: var(--quantum-green);
        background: linear-gradient(135deg, rgba(76, 175, 80, 0.2) 0%, rgba(255, 152, 0, 0.1) 100%);
        box-shadow: 0 8px 25px rgba(76, 175, 80, 0.3);
    }
    
    /* Status indicators */
    .status-indicator {
        display: inline-block;
        width: 10px;
        height: 10px;
        border-radius: 50%;
        margin-right: 8px;
        animation: pulse 2s infinite;
    }
    
    .status-active {
        background-color: var(--quantum-green);
        box-shadow: 0 0 10px var(--quantum-green);
    }
    
    .status-warning {
        background-color: var(--neural-orange);
        box-shadow: 0 0 10px var(--neural-orange);
    }
    
    .status-error {
        background-color: var(--synaptic-red);
        box-shadow: 0 0 10px var(--synaptic-red);
    }
    
    @keyframes pulse {
        0% { box-shadow: 0 0 0 0 rgba(76, 175, 80, 0.7); }
        70% { box-shadow: 0 0 0 10px rgba(76, 175, 80, 0); }
        100% { box-shadow: 0 0 0 0 rgba(76, 175, 80, 0); }
    }
    
    /* Sidebar styling */
    .css-1d391kg {
        background: linear-gradient(180deg, var(--neural-dark) 0%, var(--neural-gray) 100%);
        border-right: 1px solid rgba(0, 188, 212, 0.2);
    }
    
    /* Button styling */
    .stButton > button {
        background: linear-gradient(90deg, var(--neural-blue) 0%, var(--synaptic-cyan) 100%);
        color: white;
        border: none;
        border-radius: 8px;
        padding: 0.5rem 1rem;
        font-weight: 600;
        transition: all 0.3s ease;
        box-shadow: 0 4px 15px rgba(26, 35, 126, 0.3);
    }
    
    .stButton > button:hover {
        transform: translateY(-2px);
        box-shadow: 0 6px 20px rgba(0, 188, 212, 0.4);
    }
    
    /* Chart container */
    .chart-container {
        background: rgba(30, 30, 30, 0.7);
        border-radius: 12px;
        padding: 1rem;
        border: 1px solid rgba(0, 188, 212, 0.1);
        backdrop-filter: blur(10px);
    }
    
    /* AI insights panel */
    .ai-insight {
        background: linear-gradient(135deg, rgba(255, 152, 0, 0.1) 0%, rgba(244, 67, 54, 0.05) 100%);
        border: 1px solid rgba(255, 152, 0, 0.3);
        border-radius: 10px;
        padding: 1rem;
        margin: 0.5rem 0;
        border-left: 4px solid var(--neural-orange);
    }
    
    /* Neural network animation */
    .neural-animation {
        position: relative;
        overflow: hidden;
    }
    
    .neural-animation::before {
        content: '';
        position: absolute;
        top: 0;
        left: -100%;
        width: 100%;
        height: 100%;
        background: linear-gradient(90deg, transparent, rgba(0, 188, 212, 0.1), transparent);
        animation: neuralFlow 3s infinite;
    }
    
    @keyframes neuralFlow {
        0% { left: -100%; }
        100% { left: 100%; }
    }
    
    /* Responsive design */
    @media (max-width: 768px) {
        .header-title { font-size: 1.8rem; }
        .metric-value { font-size: 1.5rem; }
        .metric-card { padding: 1rem; }
    }
</style>
""", unsafe_allow_html=True)

# Utility functions
def get_display_count():
    """Get current display count from adaptive detection"""
    try:
        with open('configs/current_display_count.txt', 'r') as f:
            return int(f.read().strip())
    except:
        return 2  # Default to dual display

def get_system_status():
    """Get comprehensive system status"""
    try:
        # Try to get YABAI status
        yabai_status = subprocess.run(['yabai', '-m', 'query', '--displays'], 
                                    capture_output=True, text=True)
        yabai_running = yabai_status.returncode == 0
    except:
        yabai_running = False
    
    # Check external models
    models_available = os.path.exists('/Volumes/MICRO/models')
    
    # Check Ollama
    try:
        ollama_status = subprocess.run(['which', 'ollama'], 
                                     capture_output=True, text=True)
        ollama_installed = ollama_status.returncode == 0
    except:
        ollama_installed = False
    
    return {
        'yabai': yabai_running,
        'models': models_available,
        'ollama': ollama_installed,
        'display_count': get_display_count()
    }

def generate_sample_data():
    """Generate realistic sample data for dashboard"""
    # Productivity data
    dates = pd.date_range(start='2024-01-01', end='2024-01-30', freq='D')
    productivity_data = {
        'date': dates,
        'focus_score': np.random.normal(85, 10, len(dates)).clip(60, 100),
        'deep_work_hours': np.random.normal(4.5, 1.2, len(dates)).clip(2, 8),
        'interruptions': np.random.poisson(8, len(dates)),
        'efficiency': np.random.normal(78, 12, len(dates)).clip(50, 95)
    }
    
    # AI model performance
    models_data = {
        'model': ['Llama-3.1-8B', 'DeepSeek-R1-8B', 'Phi-4-Mini', 'Qwen3-4B', 'TinyLlama-1.1B'],
        'response_time': [1.2, 0.8, 0.5, 0.9, 0.3],
        'memory_usage': [6.2, 4.1, 2.3, 3.8, 1.1],
        'accuracy': [94, 91, 87, 89, 82],
        'status': ['active', 'standby', 'active', 'standby', 'active']
    }
    
    # Application usage
    app_data = {
        'app': ['VS Code', 'Chrome', 'Terminal', 'Slack', 'Obsidian', 'ChatGPT', 'LM Studio'],
        'hours': [6.2, 3.8, 4.1, 2.3, 1.9, 2.7, 1.5],
        'category': ['Development', 'Web', 'Development', 'Communication', 'Productivity', 'AI', 'AI']
    }
    
    return productivity_data, models_data, app_data

def create_modern_chart(data, chart_type, title, **kwargs):
    """Create modern, styled charts with Neural Workspace theme"""
    
    if chart_type == 'line':
        fig = go.Figure()
        fig.add_trace(go.Scatter(
            x=data['x'], y=data['y'],
            mode='lines+markers',
            line=dict(color='#00bcd4', width=3),
            marker=dict(size=8, color='#00bcd4', line=dict(width=2, color='white')),
            fill='tonexty' if kwargs.get('fill') else None,
            fillcolor='rgba(0, 188, 212, 0.1)'
        ))
    
    elif chart_type == 'bar':
        fig = go.Figure()
        fig.add_trace(go.Bar(
            x=data['x'], y=data['y'],
            marker=dict(
                color=data['y'],
                colorscale='Viridis',
                line=dict(color='white', width=1)
            ),
            text=data['y'],
            textposition='auto'
        ))
    
    elif chart_type == 'gauge':
        fig = go.Figure(go.Indicator(
            mode = "gauge+number+delta",
            value = data['value'],
            domain = {'x': [0, 1], 'y': [0, 1]},
            title = {'text': title},
            delta = {'reference': 80},
            gauge = {
                'axis': {'range': [None, 100]},
                'bar': {'color': "#00bcd4"},
                'steps': [
                    {'range': [0, 50], 'color': "rgba(244, 67, 54, 0.2)"},
                    {'range': [50, 80], 'color': "rgba(255, 152, 0, 0.2)"},
                    {'range': [80, 100], 'color': "rgba(76, 175, 80, 0.2)"}
                ],
                'threshold': {
                    'line': {'color': "red", 'width': 4},
                    'thickness': 0.75,
                    'value': 90
                }
            }
        ))
    
    # Apply modern styling
    fig.update_layout(
        title=dict(
            text=title,
            x=0.5,
            font=dict(size=18, color='white', family='Inter')
        ),
        paper_bgcolor='rgba(0,0,0,0)',
        plot_bgcolor='rgba(30,30,30,0.7)',
        font=dict(color='white', family='Inter'),
        xaxis=dict(
            gridcolor='rgba(255,255,255,0.1)',
            zerolinecolor='rgba(255,255,255,0.2)'
        ),
        yaxis=dict(
            gridcolor='rgba(255,255,255,0.1)',
            zerolinecolor='rgba(255,255,255,0.2)'
        ),
        showlegend=False,
        margin=dict(l=20, r=20, t=60, b=20)
    )
    
    return fig

# Main Dashboard Function
def main():
    # Header
    st.markdown("""
    <div class="header-container neural-animation">
        <h1 class="header-title">🧠 NEXUS Intelligence Hub</h1>
        <p class="header-subtitle">AI-Powered Workspace Intelligence • Neural EXperience Unified System</p>
    </div>
    """, unsafe_allow_html=True)
    
    # Get system status and data
    system_status = get_system_status()
    productivity_data, models_data, app_data = generate_sample_data()
    
    # Main layout
    col1, col2, col3 = st.columns([1, 2, 1])
    
    # LEFT SIDEBAR - Workspace Control Center
    with col1:
        st.markdown("### 🎛️ Workspace Control Center")
        
        # Display adaptive configuration
        display_count = system_status['display_count']
        st.markdown(f"""
        <div class="metric-card">
            <div class="metric-title">Display Configuration</div>
            <div class="metric-value">{display_count} Displays</div>
            <div class="metric-change positive">
                {"✅ Adaptive Mode Active" if display_count > 1 else "📱 Single Display Mode"}
            </div>
        </div>
        """, unsafe_allow_html=True)
        
        # Workspace Profiles
        st.markdown("#### 📋 Workspace Profiles")
        
        profiles = [
            {"name": "💼 Work Profile", "status": "active", "apps": 8, "efficiency": 94},
            {"name": "🏠 Personal Profile", "status": "inactive", "apps": 5, "efficiency": 78},
            {"name": "🔬 AI Research Profile", "status": "inactive", "apps": 12, "efficiency": 89}
        ]
        
        for profile in profiles:
            status_class = "active" if profile["status"] == "active" else ""
            st.markdown(f"""
            <div class="profile-card {status_class}">
                <strong>{profile["name"]}</strong><br>
                <span class="status-indicator status-{'active' if profile['status'] == 'active' else 'warning'}"></span>
                {profile["apps"]} apps • {profile["efficiency"]}% efficiency
            </div>
            """, unsafe_allow_html=True)
        
        # Quick Actions
        st.markdown("#### ⚡ Quick Actions")
        if st.button("🔄 Switch Profile"):
            st.success("Profile switching activated!")
        if st.button("🤖 Optimize AI Models"):
            st.success("AI optimization in progress...")
        if st.button("📊 Generate Report"):
            st.success("Report generation started!")
        
        # System Status
        st.markdown("#### 🔍 System Status")
        
        status_items = [
            ("YABAI", system_status['yabai']),
            ("AI Models", system_status['models']),
            ("Ollama", system_status['ollama'])
        ]
        
        for name, status in status_items:
            status_icon = "🟢" if status else "🔴"
            status_text = "Active" if status else "Inactive"
            st.markdown(f"{status_icon} **{name}**: {status_text}")
    
    # CENTER - Main Content Area
    with col2:
        st.markdown("### 🖥️ Live Workspace Visualization")
        
        # Display visualization based on detected count
        if display_count == 1:
            st.markdown("""
            <div style="text-align: center; padding: 2rem; background: rgba(30,30,30,0.7); border-radius: 12px; border: 1px solid rgba(0,188,212,0.2);">
                <h4 style="color: #00bcd4;">📱 Single Display Configuration</h4>
                <div style="width: 300px; height: 200px; background: linear-gradient(135deg, #1a237e, #00bcd4); 
                           margin: 0 auto; border-radius: 8px; display: flex; align-items: center; justify-content: center; color: white;">
                    <div>
                        <strong>Primary Display</strong><br>
                        Unified Workspace<br>
                        <small>All apps in organized spaces</small>
                    </div>
                </div>
            </div>
            """, unsafe_allow_html=True)
        
        elif display_count == 2:
            st.markdown("""
            <div style="text-align: center; padding: 2rem; background: rgba(30,30,30,0.7); border-radius: 12px; border: 1px solid rgba(0,188,212,0.2);">
                <h4 style="color: #00bcd4;">🖥️ Dual Display Configuration</h4>
                <div style="display: flex; justify-content: center; gap: 20px; margin: 1rem 0;">
                    <div style="width: 200px; height: 150px; background: linear-gradient(135deg, #4caf50, #00bcd4); 
                               border-radius: 8px; display: flex; align-items: center; justify-content: center; color: white;">
                        <div>
                            <strong>Left Display</strong><br>
                            Reference & Comm<br>
                            <small>Safari, Slack, Docs</small>
                        </div>
                    </div>
                    <div style="width: 200px; height: 150px; background: linear-gradient(135deg, #1a237e, #00bcd4); 
                               border-radius: 8px; display: flex; align-items: center; justify-content: center; color: white;">
                        <div>
                            <strong>Right Display</strong><br>
                            Main Work & AI<br>
                            <small>VS Code, Terminal, AI</small>
                        </div>
                    </div>
                </div>
            </div>
            """, unsafe_allow_html=True)
        
        else:  # 3 displays
            st.markdown("""
            <div style="text-align: center; padding: 2rem; background: rgba(30,30,30,0.7); border-radius: 12px; border: 1px solid rgba(0,188,212,0.2);">
                <h4 style="color: #00bcd4;">🖥️🖥️🖥️ Triple Display Excellence</h4>
                <div style="display: flex; justify-content: center; gap: 15px; margin: 1rem 0;">
                    <div style="width: 150px; height: 120px; background: linear-gradient(135deg, #ff9800, #4caf50); 
                               border-radius: 8px; display: flex; align-items: center; justify-content: center; color: white; font-size: 0.85rem;">
                        <div>
                            <strong>Left</strong><br>
                            Browsers<br>
                            <small>Web Tools</small>
                        </div>
                    </div>
                    <div style="width: 150px; height: 120px; background: linear-gradient(135deg, #1a237e, #00bcd4); 
                               border-radius: 8px; display: flex; align-items: center; justify-content: center; color: white; font-size: 0.85rem;">
                        <div>
                            <strong>Center</strong><br>
                            AI & Dev<br>
                            <small>Primary Work</small>
                        </div>
                    </div>
                    <div style="width: 150px; height: 120px; background: linear-gradient(135deg, #4caf50, #00bcd4); 
                               border-radius: 8px; display: flex; align-items: center; justify-content: center; color: white; font-size: 0.85rem;">
                        <div>
                            <strong>Right</strong><br>
                            Productivity<br>
                            <small>Communication</small>
                        </div>
                    </div>
                </div>
            </div>
            """, unsafe_allow_html=True)
        
        # Performance Metrics
        st.markdown("#### 📊 Performance Analytics")
        
        # Create sample time series data
        df = pd.DataFrame(productivity_data)
        
        # Focus Score Chart
        focus_fig = create_modern_chart(
            {'x': df['date'], 'y': df['focus_score']},
            'line',
            'Focus Score Trend (30 Days)',
            fill=True
        )
        st.plotly_chart(focus_fig, use_container_width=True)
        
        # Application Usage
        app_df = pd.DataFrame(app_data)
        app_fig = create_modern_chart(
            {'x': app_df['app'], 'y': app_df['hours']},
            'bar',
            'Application Usage (Hours Today)'
        )
        st.plotly_chart(app_fig, use_container_width=True)
    
    # RIGHT SIDEBAR - AI Intelligence Panel
    with col3:
        st.markdown("### 🤖 AI Intelligence Panel")
        
        # AI Assistant Interface
        st.markdown("#### 💬 AI Assistant")
        st.markdown("""
        <div class="ai-insight">
            <strong>🧠 Ready to optimize your workspace!</strong><br><br>
            <em>"I've detected you're in a productive flow. Consider switching to focus mode to minimize distractions."</em><br><br>
            💡 <strong>Suggestion:</strong> Load DeepSeek-R1 for your current coding session.
        </div>
        """, unsafe_allow_html=True)
        
        # AI Model Status
        st.markdown("#### 🔬 AI Model Status")
        models_df = pd.DataFrame(models_data)
        
        for _, model in models_df.iterrows():
            status_color = "#4caf50" if model['status'] == 'active' else "#ff9800"
            st.markdown(f"""
            <div class="metric-card">
                <div class="metric-title">{model['model']}</div>
                <div style="color: {status_color}; font-weight: 600; font-size: 0.9rem;">
                    ● {model['status'].upper()}
                </div>
                <div style="font-size: 0.8rem; color: rgba(255,255,255,0.7); margin-top: 0.3rem;">
                    Response: {model['response_time']}s • RAM: {model['memory_usage']}GB<br>
                    Accuracy: {model['accuracy']}%
                </div>
            </div>
            """, unsafe_allow_html=True)
        
        # Efficiency Gauge
        st.markdown("#### 📈 Workspace Efficiency")
        efficiency_fig = create_modern_chart(
            {'value': 87},
            'gauge',
            'Current Efficiency Score'
        )
        st.plotly_chart(efficiency_fig, use_container_width=True)
        
        # Optimization Suggestions
        st.markdown("#### 💡 Smart Suggestions")
        suggestions = [
            "🎯 Switch to Research profile at 5 PM",
            "🔕 Enable focus mode - high productivity detected",
            "🤖 Consider upgrading to Qwen3-14B for current task",
            "📊 Your efficiency is 12% above average today!"
        ]
        
        for suggestion in suggestions:
            st.markdown(f"""
            <div style="padding: 0.5rem; margin: 0.3rem 0; background: rgba(0,188,212,0.1); 
                        border-left: 3px solid #00bcd4; border-radius: 5px; font-size: 0.85rem;">
                {suggestion}
            </div>
            """, unsafe_allow_html=True)
        
        # Quick Stats
        st.markdown("#### 📊 Today's Metrics")
        st.markdown("""
        <div class="metric-card">
            <div class="metric-title">Deep Work</div>
            <div class="metric-value">4.2h</div>
            <div class="metric-change positive">↗ +18% vs yesterday</div>
        </div>
        
        <div class="metric-card">
            <div class="metric-title">Interruptions</div>
            <div class="metric-value">7</div>
            <div class="metric-change positive">↘ -23% vs average</div>
        </div>
        
        <div class="metric-card">
            <div class="metric-title">AI Queries</div>
            <div class="metric-value">23</div>
            <div class="metric-change positive">↗ Active usage</div>
        </div>
        """, unsafe_allow_html=True)

    # Footer
    st.markdown("---")
    col1, col2, col3 = st.columns(3)
    
    with col1:
        st.markdown("🚀 **NEXUS** - Neural Workspace Intelligence")
    with col2:
        st.markdown(f"🖥️ **{display_count} Display Mode** - Adaptive Configuration")
    with col3:
        current_time = datetime.now().strftime("%H:%M")
        st.markdown(f"⏰ **{current_time}** - Real-time Monitoring")

if __name__ == "__main__":
    main()
