package services

import (
	"testing"

	"github.com/example/myapp/src/models"
)

func TestCalculatorAdd(t *testing.T) {
	c := Calculator{}
	result, err := c.Add(3, 5)
	if err != nil {
		t.Errorf("Add failed: %v", err)
	}
	if result != 8 {
		t.Errorf("Expected 8, got %d", result)
	}
}

func TestCalculatorSubtract(t *testing.T) {
	c := Calculator{}
	result, err := c.Subtract(10, 4)
	if err != nil {
		t.Errorf("Subtract failed: %v", err)
	}
	if result != 6 {
		t.Errorf("Expected 6, got %d", result)
	}
}

func TestCalculatorMultiply(t *testing.T) {
	c := Calculator{}
	result, err := c.Multiply(3, 5)
	if err != nil {
		t.Errorf("Multiply failed: %v", err)
	}
	if result != 15 {
		t.Errorf("Expected 15, got %d", result)
	}
}

func TestCalculatorMultiplyOverflow(t *testing.T) {
	c := Calculator{}
	_, err := c.Multiply(1001, 5)
	if err == nil {
		t.Error("Expected overflow error")
	}
}

func TestCalculatorDivide(t *testing.T) {
	c := Calculator{}
	result, err := c.Divide(10, 2)
	if err != nil {
		t.Errorf("Divide failed: %v", err)
	}
	if result != 5 {
		t.Errorf("Expected 5, got %d", result)
	}
}

func TestCalculatorDivideByZero(t *testing.T) {
	c := Calculator{}
	_, err := c.Divide(10, 0)
	if err == nil {
		t.Error("Expected division by zero error")
	}
}

func TestSaveUserInvalidDB(t *testing.T) {
	user := &models.User{Name: "Test", Email: "test@test.com"}
	err := SaveUser(user)
	if err == nil {
		t.Error("Expected error with nil db")
	}
}

func TestGetUserByIDInvalidDB(t *testing.T) {
	_, err := GetUserByID(999)
	if err == nil {
		t.Error("Expected error with invalid db")
	}
}
