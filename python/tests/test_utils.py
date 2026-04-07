"""Unit tests for utility functions."""
import pytest
from utils import (
    validate_email,
    validate_password,
    hash_password,
    sanitize_input,
)


class TestValidateEmail:
    def test_valid_emails(self):
        assert validate_email("user@example.com") is True
        assert validate_email("user.name@example.com") is True
        assert validate_email("user+tag@example.co.uk") is True

    def test_invalid_emails(self):
        assert validate_email("invalid") is False
        assert validate_email("user@") is False
        assert validate_email("@example.com") is False
        assert validate_email("user@.com") is False


class TestValidatePassword:
    def test_valid_password(self):
        is_valid, error = validate_password("Password123")
        assert is_valid is True
        assert error is None

    def test_short_password(self):
        is_valid, error = validate_password("Pass1")
        assert is_valid is False
        assert "at least 8 characters" in error

    def test_no_uppercase(self):
        is_valid, error = validate_password("password123")
        assert is_valid is False
        assert "uppercase" in error

    def test_no_lowercase(self):
        is_valid, error = validate_password("PASSWORD123")
        assert is_valid is False
        assert "lowercase" in error

    def test_no_digit(self):
        is_valid, error = validate_password("PasswordABC")
        assert is_valid is False
        assert "digit" in error


class TestHashPassword:
    def test_hash_password(self):
        hashed = hash_password("testpassword")
        assert hashed is not None
        assert len(hashed) == 64  # SHA-256 produces 64 hex characters
        assert hash_password("testpassword") == hashed


class TestSanitizeInput:
    def test_sanitize_normal_text(self):
        assert sanitize_input("Hello World") == "Hello World"

    def test_sanitize_removes_dangerous(self):
        assert sanitize_input("<script>alert('xss')</script>") == "scriptalert(xss)/script"
        assert sanitize_input("user; rm -rf") == "user rm -rf"