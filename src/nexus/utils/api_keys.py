import yaml
from pathlib import Path

CONFIG_PATH = Path("configs/settings/api_keys.yaml")

def load_api_keys() -> dict:
    """Load API keys and related settings from YAML.
    Returns a dict or empty dict if not configured yet."""
    if not CONFIG_PATH.exists():
        return {}
    with open(CONFIG_PATH, "r", encoding="utf-8") as f:
        data = yaml.safe_load(f) or {}
    return data

def save_api_keys(data: dict) -> None:
    """Persist API keys/settings to YAML file."""
    CONFIG_PATH.parent.mkdir(parents=True, exist_ok=True)
    with open(CONFIG_PATH, "w", encoding="utf-8") as f:
        yaml.safe_dump(data, f, sort_keys=False)


