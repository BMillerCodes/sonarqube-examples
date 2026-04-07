"""
Data models for the application.
Contains code smell: God class with too many responsibilities
"""
from dataclasses import dataclass, field
from datetime import datetime
from enum import Enum
from typing import Optional, List, Dict
import json


class UserStatus(Enum):
    ACTIVE = "active"
    INACTIVE = "inactive"
    SUSPENDED = "suspended"


@dataclass
class User:
    """User entity with profile information."""
    username: str
    email: str
    status: UserStatus = UserStatus.ACTIVE
    created_at: datetime = field(default_factory=datetime.now)
    last_login: Optional[datetime] = None
    id: Optional[int] = None
    # Code smell: storing plain text password
    password: Optional[str] = None

    def to_dict(self) -> Dict:
        return {
            'id': self.id,
            'username': self.username,
            'email': self.email,
            'status': self.status.value,
            'created_at': self.created_at.isoformat(),
            'last_login': self.last_login.isoformat() if self.last_login else None,
        }

    def __repr__(self) -> str:
        return f"User(id={self.id}, username='{self.username}', email='{self.email}')"


class UserRepository:
    """
    Repository for user data access.
    Code smell: God class with too many responsibilities
    """
    def __init__(self):
        self._users: Dict[int, User] = {}
        self._next_id = 1
        self._username_index: Dict[str, int] = {}
        self._email_index: Dict[str, int] = {}

    def save(self, user: User) -> User:
        """Save a user to the repository."""
        if user.id is None:
            user.id = self._next_id
            self._next_id += 1
        self._users[user.id] = user
        self._username_index[user.username] = user.id
        self._email_index[user.email] = user.id
        return user

    def find_by_id(self, user_id: int) -> Optional[User]:
        """Find a user by ID."""
        return self._users.get(user_id)

    def find_by_username(self, username: str) -> Optional[User]:
        """Find a user by username."""
        user_id = self._username_index.get(username)
        if user_id is None:
            return None
        return self.find_by_id(user_id)

    def find_by_email(self, email: str) -> Optional[User]:
        """Find a user by email."""
        user_id = self._email_index.get(email)
        if user_id is None:
            return None
        return self.find_by_id(user_id)

    def find_all(self) -> List[User]:
        """Get all users."""
        return list(self._users.values())

    def delete_by_id(self, user_id: int) -> bool:
        """Delete a user by ID."""
        user = self._users.get(user_id)
        if user is None:
            return False
        del self._username_index[user.username]
        del self._email_index[user.email]
        del self._users[user_id]
        return True

    def count(self) -> int:
        """Count total users."""
        return len(self._users)

    def clear(self):
        """Clear all users."""
        self._users.clear()
        self._username_index.clear()
        self._email_index.clear()
        self._next_id = 1


@dataclass
class Order:
    """Order entity."""
    user_id: int
    total_amount: float
    items: str
    status: str = "pending"
    id: Optional[int] = None
    created_at: datetime = field(default_factory=datetime.now)
    shipped_at: Optional[datetime] = None

    # Code smell: using timestamp for order number is not unique under load
    @property
    def order_number(self) -> str:
        return f"ORD-{int(datetime.now().timestamp() * 1000)}"

    def to_dict(self) -> Dict:
        return {
            'id': self.id,
            'order_number': self.order_number,
            'user_id': self.user_id,
            'total_amount': self.total_amount,
            'items': self.items,
            'status': self.status,
            'created_at': self.created_at.isoformat(),
            'shipped_at': self.shipped_at.isoformat() if self.shipped_at else None,
        }


class OrderRepository:
    """Repository for order data access."""
    def __init__(self):
        self._orders: Dict[int, Order] = {}
        self._next_id = 1

    def save(self, order: Order) -> Order:
        if order.id is None:
            order.id = self._next_id
            self._next_id += 1
        self._orders[order.id] = order
        return order

    def find_by_id(self, order_id: int) -> Optional[Order]:
        return self._orders.get(order_id)

    def find_by_user_id(self, user_id: int) -> List[Order]:
        return [o for o in self._orders.values() if o.user_id == user_id]

    def find_all(self) -> List[Order]:
        return list(self._orders.values())

    def count(self) -> int:
        return len(self._orders)

    def clear(self):
        self._orders.clear()
        self._next_id = 1