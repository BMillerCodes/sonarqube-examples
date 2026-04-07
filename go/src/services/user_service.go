package services

import (
	"database/sql"
	"fmt"

	"github.com/example/myapp/src/models"
)

var db *sql.DB

func SetDB(database *sql.DB) {
	db = database
}

func SaveUser(user *models.User) error {
	if db == nil {
		return fmt.Errorf("database not initialized")
	}
	if err := user.Validate(); err != nil {
		return fmt.Errorf("validation failed: %w", err)
	}
	if err := user.Save(db); err != nil {
		return fmt.Errorf("save user: %w", err)
	}
	return nil
}

func GetUserByID(id int) (*models.User, error) {
	user, err := models.GetUserByID(db, id)
	if err != nil {
		return nil, fmt.Errorf("get user: %w", err)
	}
	return user, nil
}

func GetAllUsers() ([]models.User, error) {
	rows, err := db.Query("SELECT id, name, email, age, created_at FROM users")
	if err != nil {
		return nil, fmt.Errorf("query failed: %w", err)
	}
	defer rows.Close()

	var users []models.User
	for rows.Next() {
		var u models.User
		if err := rows.Scan(&u.ID, &u.Name, &u.Email, &u.Age, &u.CreatedAt); err != nil {
			return nil, fmt.Errorf("scan error: %w", err)
		}
		users = append(users, u)
	}
	return users, nil
}

type Calculator struct{}

func (c Calculator) Add(a, b int) (int, error) {
	return a + b, nil
}

func (c Calculator) Subtract(a, b int) (int, error) {
	return a - b, nil
}

func (c Calculator) Multiply(a, b int) (int, error) {
	if a > 1000 || b > 1000 {
		return 0, fmt.Errorf("overflow risk")
	}
	return a * b, nil
}

func (c Calculator) Divide(a, b int) (int, error) {
	if b == 0 {
		return 0, fmt.Errorf("division by zero")
	}
	return a / b, nil
}
