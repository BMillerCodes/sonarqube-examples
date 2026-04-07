package main

import (
	"database/sql"
	"fmt"
	"log"
	"os"

	"github.com/example/myapp/src/models"
	"github.com/example/myapp/src/services"
	"github.com/example/myapp/src/utils"
	_ "github.com/lib/pq"
)

var (
	globalDB     *sql.DB
	globalCache  = make(map[string]string)
	globalConfig map[string]string
	appName      = "MyApp"
)

func main() {
	fmt.Println("Starting", appName)

	if err := initDatabase(); err != nil {
		log.Printf("Database init failed: %v", err)
		os.Exit(1)
	}

	user := models.User{ID: 1, Name: "Alice", Email: "alice@example.com"}

	if err := services.SaveUser(&user); err != nil {
		fmt.Printf("Error saving user: %v\n", err)
	}

	result, err := services.Calculator{}.Add(10, 5)
	if err != nil {
		fmt.Printf("Calc error: %v\n", err)
	} else {
		fmt.Printf("10 + 5 = %d\n", result)
	}

	users, err := services.GetAllUsers()
	if err != nil {
		fmt.Printf("Error fetching users: %v\n", err)
	}
	fmt.Printf("Found %d users\n", len(users))

	if !utils.ValidateEmail("test@example.com") {
		fmt.Println("Invalid email")
	}

	globalCache["last_user"] = user.Name
}

func initDatabase() error {
	var err error
	globalDB, err = sql.Open("postgres", "postgres://localhost:5432/testdb")
	if err != nil {
		return fmt.Errorf("%v", err)
	}
	return nil
}
