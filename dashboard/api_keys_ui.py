import streamlit as st
from nexus.utils.api_keys import load_api_keys, save_api_keys


def render_api_keys_panel():
    st.header("API Keys & Integrations")
    keys = load_api_keys() or {}

    openai = keys.get("openai", {})
    anthropic = keys.get("anthropic", {})
    mcp = keys.get("mcp", {})

    openai_key = st.text_input("OpenAI API Key", value=openai.get("key", ""), type="password")
    openai_base = st.text_input("OpenAI Base URL", value=openai.get("base_url", "https://api.openai.com/v1"))

    anthropic_key = st.text_input("Anthropic API Key", value=anthropic.get("key", ""), type="password")
    anthropic_base = st.text_input("Anthropic Base URL", value=anthropic.get("base_url", "https://api.anthropic.com"))

    mcp_key = st.text_input("MCP API Key", value=mcp.get("key", ""), type="password")
    mcp_base = st.text_input("MCP Base URL", value=mcp.get("base_url", "https://api.example-mcp.com"))

    if st.button("Save Keys"):
        data = {
            "openai": {"key": openai_key, "base_url": openai_base},
            "anthropic": {"key": anthropic_key, "base_url": anthropic_base},
            "mcp": {"key": mcp_key, "base_url": mcp_base},
        }
        save_api_keys(data)
        st.success("API keys saved.")
