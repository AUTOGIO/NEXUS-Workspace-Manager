#!/usr/bin/env python3
"""
NEXUS Logger Utility
Centralized logging configuration for NEXUS
"""

import logging
import sys
from pathlib import Path
from typing import Optional

def setup_logging(
    level: str = "INFO",
    log_file: Optional[str] = None,
    log_format: str = "%(asctime)s - %(name)s - %(levelname)s - %(message)s"
) -> None:
    """
    Setup logging configuration for NEXUS.
    
    Args:
        level: Logging level (DEBUG, INFO, WARNING, ERROR, CRITICAL)
        log_file: Optional log file path
        log_format: Log message format
    """
    try:
        # Get project root
        project_root = Path(__file__).parent.parent.parent.parent
        
        # Create logs directory if it doesn't exist
        logs_dir = project_root / "data" / "logs"
        logs_dir.mkdir(parents=True, exist_ok=True)
        
        # Set default log file if none specified
        if log_file is None:
            log_file = logs_dir / "nexus.log"
        
        # Configure logging
        logging.basicConfig(
            level=getattr(logging, level.upper()),
            format=log_format,
            handlers=[
                logging.StreamHandler(sys.stdout),
                logging.FileHandler(log_file)
            ]
        )
        
        # Set specific logger levels
        logging.getLogger("nexus").setLevel(getattr(logging, level.upper()))
        
        # Reduce noise from external libraries
        logging.getLogger("urllib3").setLevel(logging.WARNING)
        logging.getLogger("requests").setLevel(logging.WARNING)
        
    except Exception as e:
        # Fallback to basic logging if setup fails
        logging.basicConfig(
            level=getattr(logging, level.upper()),
            format=log_format
        )
        logging.warning(f"Could not setup advanced logging: {e}")

def get_logger(name: str) -> logging.Logger:
    """
    Get a logger instance for the specified name.
    
    Args:
        name: Logger name (usually __name__)
        
    Returns:
        Configured logger instance
    """
    return logging.getLogger(name)

def set_log_level(level: str) -> None:
    """
    Set the logging level for all NEXUS loggers.
    
    Args:
        level: Logging level (DEBUG, INFO, WARNING, ERROR, CRITICAL)
    """
    try:
        log_level = getattr(logging, level.upper())
        logging.getLogger("nexus").setLevel(log_level)
        logging.getLogger().setLevel(log_level)
    except AttributeError:
        logging.warning(f"Invalid log level: {level}")

def log_to_file(message: str, level: str = "INFO", log_file: Optional[str] = None) -> None:
    """
    Log a message to a specific file.
    
    Args:
        message: Message to log
        level: Logging level
        log_file: Optional log file path
    """
    try:
        if log_file is None:
            project_root = Path(__file__).parent.parent.parent.parent
            log_file = project_root / "data" / "logs" / "nexus.log"
        
        # Ensure directory exists
        log_file.parent.mkdir(parents=True, exist_ok=True)
        
        # Create file handler
        file_handler = logging.FileHandler(log_file)
        file_handler.setLevel(getattr(logging, level.upper()))
        
        # Create formatter
        formatter = logging.Formatter(
            "%(asctime)s - %(name)s - %(levelname)s - %(message)s"
        )
        file_handler.setFormatter(formatter)
        
        # Get logger and add handler
        logger = logging.getLogger("nexus.file")
        logger.addHandler(file_handler)
        logger.setLevel(getattr(logging, level.upper()))
        
        # Log message
        log_method = getattr(logger, level.lower())
        log_method(message)
        
        # Remove handler to avoid duplicates
        logger.removeHandler(file_handler)
        
    except Exception as e:
        logging.error(f"Could not log to file: {e}")
        # Fallback to console logging
        logging.log(getattr(logging, level.upper()), message)

