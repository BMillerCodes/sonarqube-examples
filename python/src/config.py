"""
Configuration management for the application.
Code smell: Feature flags multiplied in config, long method
"""
import os
from dataclasses import dataclass, field
from typing import Dict, Any, Optional


@dataclass
class AppConfig:
    """
    Application configuration.
    Code smell: God class with too many responsibilities
    """
    debug: bool = False
    log_level: str = "INFO"
    max_connections: int = 100
    timeout: int = 30
    cache_enabled: bool = True
    cache_ttl: int = 300

    # Feature flags multiplied (code smell)
    feature_new_ui: bool = False
    feature_beta_api: bool = False
    feature_experimental_search: bool = False
    feature_dark_mode: bool = True
    feature_notifications: bool = True
    feature_analytics: bool = False
    feature_recommendations: bool = False
    feature_social_login: bool = False

    # Database settings
    db_host: str = "localhost"
    db_port: int = 5432
    db_name: str = "appdb"
    db_user: str = "appuser"
    db_password: str = ""

    # Redis settings
    redis_host: str = "localhost"
    redis_port: int = 6379
    redis_password: str = ""

    # Email settings
    smtp_host: str = "smtp.example.com"
    smtp_port: int = 587
    smtp_user: str = ""
    smtp_password: str = ""
    smtp_from: str = "noreply@example.com"

    # External API settings
    api_base_url: str = "https://api.example.com"
    api_key: str = ""
    api_timeout: int = 10

    @classmethod
    def from_env(cls) -> 'AppConfig':
        """Load configuration from environment variables."""
        config = cls()
        config.debug = os.getenv('DEBUG', 'false').lower() == 'true'
        config.log_level = os.getenv('LOG_LEVEL', 'INFO')
        config.db_host = os.getenv('DB_HOST', config.db_host)
        config.db_port = int(os.getenv('DB_PORT', str(config.db_port)))
        config.db_name = os.getenv('DB_NAME', config.db_name)
        config.db_user = os.getenv('DB_USER', config.db_user)
        config.db_password = os.getenv('DB_PASSWORD', config.db_password)
        config.redis_host = os.getenv('REDIS_HOST', config.redis_host)
        config.redis_port = int(os.getenv('REDIS_PORT', str(config.redis_port)))
        config.api_key = os.getenv('API_KEY', config.api_key)
        return config

    def to_dict(self) -> Dict[str, Any]:
        """Convert config to dictionary."""
        result = {}
        for key, value in self.__dict__.items():
            if not key.startswith('_'):
                result[key] = value
        return result

    def get(self, key: str, default: Any = None) -> Any:
        """Get a configuration value."""
        return getattr(self, key, default)

    def is_feature_enabled(self, feature_name: str) -> bool:
        """Check if a feature flag is enabled."""
        return getattr(self, f'feature_{feature_name}', False)


# Global config instance
_config: Optional[AppConfig] = None


def get_config() -> AppConfig:
    """Get the global configuration instance."""
    global _config
    if _config is None:
        _config = AppConfig.from_env()
    return _config


def init_config(**kwargs) -> AppConfig:
    """Initialize configuration with custom values."""
    global _config
    _config = AppConfig(**kwargs)
    return _config