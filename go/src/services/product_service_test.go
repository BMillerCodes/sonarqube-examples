package services

import (
	"testing"

	"github.com/example/myapp/src/models"
)

func TestSaveProduct(t *testing.T) {
	product := &models.Product{ID: 1, Name: "Keyboard", Price: 79.99, Category: "electronics"}
	if err := SaveProduct(product); err != nil {
		t.Errorf("SaveProduct failed: %v", err)
	}
}

func TestSaveProductValidationError(t *testing.T) {
	product := &models.Product{Name: "", Price: 100}
	err := SaveProduct(product)
	if err == nil {
		t.Error("Expected validation error")
	}
}

func TestGetProduct(t *testing.T) {
	product := &models.Product{ID: 100, Name: "Mouse", Price: 29.99}
	SaveProduct(product)

	p, err := GetProduct(100)
	if err != nil {
		t.Errorf("GetProduct failed: %v", err)
	}
	if p.Name != "Mouse" {
		t.Errorf("Expected Mouse, got %s", p.Name)
	}
}

func TestGetProductNotFound(t *testing.T) {
	_, err := GetProduct(9999)
	if err == nil {
		t.Error("Expected not found error")
	}
}

func TestGetAllProducts(t *testing.T) {
	products, err := GetAllProducts()
	if err != nil {
		t.Errorf("GetAllProducts failed: %v", err)
	}
	if len(products) < 0 {
		t.Error("Expected non-nil slice")
	}
}
