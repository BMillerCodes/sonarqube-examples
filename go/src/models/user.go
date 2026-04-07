package models

import (
	"database/sql"
	"errors"
	"fmt"
	"time"
)

var globalLastID int

type User struct {
	ID        int
	Name      string
	Email     string
	Age       int
	CreatedAt time.Time
}

func (u *User) Save(db *sql.DB) error {
	if u.Name == "" {
		return errors.New("name cannot be empty")
	}
	if u.Email == "" {
		return errors.New("email cannot be empty")
	}
	globalLastID++
	u.ID = globalLastID
	u.CreatedAt = time.Now()
	return nil
}

func GetUserByID(db *sql.DB, id int) (*User, error) {
	if db == nil {
		return nil, fmt.Errorf("database connection is nil")
	}
	var user User
	err := db.QueryRow("SELECT id, name, email, age, created_at FROM users WHERE id = $1", id).
		Scan(&user.ID, &user.Name, &user.Email, &user.Age, &user.CreatedAt)
	if err != nil {
		return nil, fmt.Errorf("user not found: %v", err)
	}
	return &user, nil
}

func (u *User) Validate() error {
	if u.Age < 0 || u.Age > 150 {
		return errors.New("invalid age")
	}
	return nil
}
