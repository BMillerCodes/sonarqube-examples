"""Unit tests for UserService."""
import pytest
from models import UserRepository
from service import UserService
from utils import hash_password


class TestUserService:
    def setup_method(self):
        self.repo = UserRepository()
        self.service = UserService()
        self.repo.clear()

    def test_create_user_success(self):
        user = self.service.create_user(
            username="johndoe",
            email="john@example.com",
            password="Password123"
        )
        assert user is not None
        assert user.username == "johndoe"
        assert user.email == "john@example.com"
        assert user.password == hash_password("Password123")

    def test_create_user_duplicate_username(self):
        self.service.create_user(
            username="johndoe",
            email="john@example.com",
            password="Password123"
        )
        with pytest.raises(ValueError, match="Username already exists"):
            self.service.create_user(
                username="johndoe",
                email="jane@example.com",
                password="Password123"
            )

    def test_create_user_invalid_email(self):
        with pytest.raises(ValueError, match="Invalid email format"):
            self.service.create_user(
                username="johndoe",
                email="invalid-email",
                password="Password123"
            )

    def test_create_user_short_password(self):
        with pytest.raises(ValueError, match="Password must be at least 6 characters"):
            self.service.create_user(
                username="johndoe",
                email="john@example.com",
                password="123"
            )

    def test_get_user_by_id(self):
        created = self.service.create_user(
            username="johndoe",
            email="john@example.com",
            password="Password123"
        )
        found = self.service.get_user_by_id(created.id)
        assert found is not None
        assert found.username == "johndoe"

    def test_authenticate_success(self):
        self.service.create_user(
            username="johndoe",
            email="john@example.com",
            password="Password123"
        )
        authenticated = self.service.authenticate("johndoe", "Password123")
        assert authenticated is not None
        assert authenticated.last_login is not None

    def test_authenticate_wrong_password(self):
        self.service.create_user(
            username="johndoe",
            email="john@example.com",
            password="Password123"
        )
        authenticated = self.service.authenticate("johndoe", "WrongPassword")
        assert authenticated is None

    def test_update_user(self):
        created = self.service.create_user(
            username="johndoe",
            email="john@example.com",
            password="Password123"
        )
        updated = self.service.update_user(created.id, email="newemail@example.com")
        assert updated.email == "newemail@example.com"

    def test_delete_user(self):
        created = self.service.create_user(
            username="johndoe",
            email="john@example.com",
            password="Password123"
        )
        assert self.service.delete_user(created.id) is True
        assert self.service.get_user_by_id(created.id) is None

    def test_count_users(self):
        self.service.create_user(
            username="user1",
            email="user1@example.com",
            password="Password123"
        )
        self.service.create_user(
            username="user2",
            email="user2@example.com",
            password="Password123"
        )
        assert self.service.count_users() == 2