"""Unit tests for User model and UserRepository."""
import pytest
from datetime import datetime
from models import User, UserRepository, UserStatus


class TestUser:
    def test_create_user(self):
        user = User(username="johndoe", email="john@example.com")
        assert user.username == "johndoe"
        assert user.email == "john@example.com"
        assert user.status == UserStatus.ACTIVE
        assert user.id is None

    def test_user_to_dict(self):
        user = User(username="johndoe", email="john@example.com")
        user.id = 1
        data = user.to_dict()
        assert data['username'] == "johndoe"
        assert data['email'] == "john@example.com"
        assert data['status'] == "active"


class TestUserRepository:
    def setup_method(self):
        self.repo = UserRepository()

    def teardown_method(self):
        self.repo.clear()

    def test_save_user(self):
        user = User(username="johndoe", email="john@example.com")
        saved = self.repo.save(user)
        assert saved.id is not None
        assert saved.id == 1

    def test_find_by_id(self):
        user = User(username="johndoe", email="john@example.com")
        self.repo.save(user)
        found = self.repo.find_by_id(1)
        assert found is not None
        assert found.username == "johndoe"

    def test_find_by_username(self):
        user = User(username="johndoe", email="john@example.com")
        self.repo.save(user)
        found = self.repo.find_by_username("johndoe")
        assert found is not None
        assert found.email == "john@example.com"

    def test_find_by_email(self):
        user = User(username="johndoe", email="john@example.com")
        self.repo.save(user)
        found = self.repo.find_by_email("john@example.com")
        assert found is not None
        assert found.username == "johndoe"

    def test_delete_user(self):
        user = User(username="johndoe", email="john@example.com")
        self.repo.save(user)
        assert self.repo.delete_by_id(1) is True
        assert self.repo.find_by_id(1) is None

    def test_count(self):
        self.repo.save(User(username="user1", email="user1@example.com"))
        self.repo.save(User(username="user2", email="user2@example.com"))
        assert self.repo.count() == 2