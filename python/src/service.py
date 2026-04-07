"""
Business logic layer for user operations.
Code smell: Long method with too many responsibilities, duplicate validation
"""
from typing import Optional, List
from datetime import datetime

from models import User, UserRepository, UserStatus
from config import get_config
from utils import validate_email, hash_password, rate_limit, log_execution
import logging

logger = logging.getLogger(__name__)


class UserService:
    """
    User service with business logic.
    Code smell: God class with too many responsibilities
    """

    def __init__(self):
        self.repository = UserRepository()
        self.config = get_config()

    @log_execution
    def create_user(
        self,
        username: str,
        email: str,
        password: str,
        **kwargs
    ) -> User:
        """
        Create a new user.
        Code smell: Long method with too many responsibilities
        """
        # Duplicate validation logic scattered across methods
        if not username or username.strip() == "":
            raise ValueError("Username cannot be empty")

        if len(username) < 3 or len(username) > 50:
            raise ValueError("Username must be between 3 and 50 characters")

        if not email or not validate_email(email):
            raise ValueError("Invalid email format")

        if not password or len(password) < 6:
            raise ValueError("Password must be at least 6 characters")

        # Check for existing user
        existing = self.repository.find_by_username(username)
        if existing is not None:
            raise ValueError("Username already exists")

        existing_email = self.repository.find_by_email(email)
        if existing_email is not None:
            raise ValueError("Email already exists")

        # Create user
        user = User(
            username=username,
            email=email,
            password=hash_password(password),  # Code smell: using weak hashing
            status=kwargs.get('status', UserStatus.ACTIVE),
        )

        return self.repository.save(user)

    def get_user_by_id(self, user_id: int) -> Optional[User]:
        """Get a user by ID."""
        user = self.repository.find_by_id(user_id)
        if user is None:
            logger.warning(f"User not found: {user_id}")
        return user

    @rate_limit(max_calls=5, window=60)
    def authenticate(self, username: str, password: str) -> Optional[User]:
        """
        Authenticate a user.
        Code smell: Using weak password hashing
        """
        if not username or not password:
            return None

        user = self.repository.find_by_username(username)
        if user is None:
            logger.warning(f"Authentication failed: user not found - {username}")
            return None

        hashed = hash_password(password)
        if user.password != hashed:
            logger.warning(f"Authentication failed: wrong password - {username}")
            return None

        user.last_login = datetime.now()
        self.repository.save(user)
        return user

    def update_user(
        self,
        user_id: int,
        email: Optional[str] = None,
        password: Optional[str] = None,
        **kwargs
    ) -> Optional[User]:
        """
        Update a user.
        Code smell: Duplicate validation, nested try-except
        """
        user = self.repository.find_by_id(user_id)
        if user is None:
            return None

        try:
            if email is not None:
                if not validate_email(email):
                    raise ValueError("Invalid email format")
                user.email = email

            if password is not None:
                if len(password) < 6:
                    raise ValueError("Password must be at least 6 characters")
                user.password = hash_password(password)

            # Update additional fields
            if 'status' in kwargs:
                user.status = kwargs['status']

            return self.repository.save(user)
        except Exception as e:
            logger.error(f"Error updating user: {e}")
            raise

    def delete_user(self, user_id: int) -> bool:
        """Delete a user."""
        return self.repository.delete_by_id(user_id)

    def get_all_users(self) -> List[User]:
        """Get all users."""
        return self.repository.find_all()

    def search_users(self, query: str) -> List[User]:
        """
        Search users by username or email.
        Code smell: Simple linear search without indexing
        """
        results = []
        query_lower = query.lower()
        for user in self.repository.find_all():
            if query_lower in user.username.lower() or query_lower in user.email.lower():
                results.append(user)
        return results

    def count_users(self) -> int:
        """Count total users."""
        return self.repository.count()


class OrderService:
    """Order service with business logic."""

    def __init__(self):
        from models import OrderRepository
        self.order_repository = OrderRepository()
        self.user_repository = UserRepository()

    def create_order(
        self,
        user_id: int,
        total_amount: float,
        items: str,
        **kwargs
    ) -> Optional['Order']:
        """Create a new order."""
        from models import Order

        user = self.user_repository.find_by_id(user_id)
        if user is None:
            raise ValueError(f"User not found: {user_id}")

        if total_amount < 0:
            raise ValueError("Total amount cannot be negative")

        order = Order(
            user_id=user_id,
            total_amount=total_amount,
            items=items,
            status='pending',
        )

        return self.order_repository.save(order)

    def get_order_by_id(self, order_id: int) -> Optional['Order']:
        """Get an order by ID."""
        return self.order_repository.find_by_id(order_id)

    def get_orders_by_user(self, user_id: int) -> List['Order']:
        """Get all orders for a user."""
        return self.order_repository.find_by_user_id(user_id)