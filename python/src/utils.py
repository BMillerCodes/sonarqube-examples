"""
Utility functions for the application.
Code smell: Decorator catching all exceptions
"""
import re
import time
import hashlib
from functools import wraps
from typing import Callable, Any, Optional
import logging

logger = logging.getLogger(__name__)


def validate_email(email: str) -> bool:
    """Validate email format."""
    pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'
    return bool(re.match(pattern, email))


def validate_password(password: str) -> tuple[bool, Optional[str]]:
    """
    Validate password strength.
    Returns (is_valid, error_message)
    """
    if len(password) < 8:
        return False, "Password must be at least 8 characters"
    if not re.search(r'[A-Z]', password):
        return False, "Password must contain at least one uppercase letter"
    if not re.search(r'[a-z]', password):
        return False, "Password must contain at least one lowercase letter"
    if not re.search(r'[0-9]', password):
        return False, "Password must contain at least one digit"
    return True, None


def hash_password(password: str) -> str:
    """
    Hash a password using SHA-256.
    Note: In production, use bcrypt or argon2 instead (code smell: weak hashing)
    """
    return hashlib.sha256(password.encode()).hexdigest()


def rate_limit(max_calls: int = 10, window: int = 60):
    """
    Rate limiting decorator.
    Code smell: Thread-unsafe implementation
    """
    _call_counts = {}

    def decorator(func: Callable) -> Callable:
        @wraps(func)
        def wrapper(*args, **kwargs):
            key = f"{func.__name__}"
            current_time = time.time()

            if key not in _call_counts:
                _call_counts[key] = []

            # Clean old calls outside window
            _call_counts[key] = [
                t for t in _call_counts[key]
                if current_time - t < window
            ]

            if len(_call_counts[key]) >= max_calls:
                raise Exception(f"Rate limit exceeded for {func.__name__}")

            _call_counts[key].append(current_time)
            return func(*args, **kwargs)

        return wrapper
    return decorator


def retry(max_attempts: int = 3, delay: float = 1.0):
    """
    Retry decorator with exponential backoff.
    Code smell: Decorator catches all exceptions
    """
    def decorator(func: Callable) -> Callable:
        @wraps(func)
        def wrapper(*args, **kwargs):
            attempts = 0
            while attempts < max_attempts:
                try:
                    return func(*args, **kwargs)
                except Exception as e:
                    attempts += 1
                    if attempts >= max_attempts:
                        logger.error(f"Failed after {max_attempts} attempts: {e}")
                        raise
                    logger.warning(f"Attempt {attempts} failed: {e}, retrying...")
                    time.sleep(delay * attempts)
            return None
        return wrapper
    return decorator


def log_execution(func: Callable) -> Callable:
    """
    Decorator to log function execution.
    Code smell: Decorator catches all exceptions
    """
    @wraps(func)
    def wrapper(*args, **kwargs):
        try:
            logger.info(f"Executing {func.__name__}")
            result = func(*args, **kwargs)
            logger.info(f"Completed {func.__name__}")
            return result
        except Exception as e:
            logger.error(f"Error in {func.__name__}: {e}")
            raise
    return wrapper


def sanitize_input(text: str) -> str:
    """Sanitize user input to prevent injection."""
    if not text:
        return ""
    # Remove potentially dangerous characters
    dangerous = ['<', '>', '"', "'", '&', ';', '|', '`']
    result = text
    for char in dangerous:
        result = result.replace(char, '')
    return result.strip()