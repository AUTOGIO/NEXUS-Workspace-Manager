import streamlit as st
import yaml
from pathlib import Path

# Direct path to config file
CONFIG_PATH = Path(__file__).parent.parent / "configs" / "settings" / "api_keys.yaml"

def load_api_keys() -> dict:
    """Load API keys and related settings from YAML.
    Returns a dict or empty dict if not configured yet."""
    if not CONFIG_PATH.exists():
        return {}
    try:
        with open(CONFIG_PATH, "r", encoding="utf-8") as f:
            data = yaml.safe_load(f) or {}
        return data
    except Exception as e:
        st.error(f"Error loading API keys: {e}")
        return {}

def save_api_keys(data: dict) -> None:
    """Persist API keys/settings to YAML file."""
    try:
        CONFIG_PATH.parent.mkdir(parents=True, exist_ok=True)
        with open(CONFIG_PATH, "w", encoding="utf-8") as f:
            yaml.safe_dump(data, f, sort_keys=False, default_flow_style=False)
        st.success("API keys saved successfully!")
    except Exception as e:
        st.error(f"Error saving API keys: {e}")

def render_api_keys_panel():
    st.header("🔐 API Keys & Integrations")
    
    # Load existing keys
    keys = load_api_keys()
    
    # Initialize with defaults if empty
    openai = keys.get("openai", {})
    anthropic = keys.get("anthropic", {})
    mcp = keys.get("mcp", {})
    
    # OpenAI Section
    st.subheader("🤖 OpenAI")
    openai_key = st.text_input("API Key", value=openai.get("key", ""), type="password", key="openai_key")
    openai_base = st.text_input("Base URL", value=openai.get("base_url", "https://api.openai.com/v1"), key="openai_base")
    
    # Anthropic Section
    st.subheader("🧠 Anthropic")
    anthropic_key = st.text_input("API Key", value=anthropic.get("key", ""), type="password", key="anthropic_key")
    anthropic_base = st.text_input("Base URL", value=anthropic.get("base_url", "https://api.anthropic.com"), key="anthropic_base")
    
    # MCP Section
    st.subheader("🔗 MCP (Model Context Protocol)")
    mcp_key = st.text_input("API Key", value=mcp.get("key", ""), type="password", key="mcp_key")
    mcp_base = st.text_input("Base URL", value=mcp.get("base_url", "https://api.example-mcp.com"), key="mcp_base")
    
    # Save Button
    if st.button("💾 Save All API Keys", type="primary", use_container_width=True):
        # Prepare data to save
        data_to_save = {
            "openai": {
                "key": openai_key,
                "base_url": openai_base
            },
            "anthropic": {
                "key": anthropic_key,
                "base_url": anthropic_base
            },
            "mcp": {
                "key": mcp_key,
                "base_url": mcp_base
            }
        }
        
        # Save to file
        save_api_keys(data_to_save)
    
    # Display current config file location
    st.info(f"📁 Configuration file: `{CONFIG_PATH}`")
    
    # Show current keys (masked)
    if keys:
        st.subheader("📋 Current Configuration")
        for provider, config in keys.items():
            if config.get("key"):
                masked_key = config["key"][:4] + "..." + config["key"][-4:] if len(config["key"]) > 8 else "***"
                st.write(f"**{provider.title()}**: {masked_key} | Base: {config.get('base_url', 'N/A')}")
            else:
                st.write(f"**{provider.title}**: Not configured")
