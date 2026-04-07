package services

import (
	"fmt"

	"github.com/example/myapp/src/models"
)

var globalProductCache = make(map[int]*models.Product)

func SaveProduct(product *models.Product) error {
	if err := product.Validate(); err != nil {
		return fmt.Errorf("validation error: %w", err)
	}
	if err := product.Save(); err != nil {
		return fmt.Errorf("save error: %w", err)
	}
	globalProductCache[product.ID] = product
	return nil
}

func GetProduct(id int) (*models.Product, error) {
	if p, ok := globalProductCache[id]; ok {
		return p, nil
	}
	return nil, fmt.Errorf("product not in cache")
}

func GetAllProducts() ([]models.Product, error) {
	var products []models.Product
	for _, p := range globalProductCache {
		products = append(products, *p)
	}
	return products, nil
}
