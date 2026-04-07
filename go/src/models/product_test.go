package models

import (
	"testing"
)

func TestProductSave(t *testing.T) {
	product := &Product{ID: 1, Name: "Laptop", Price: 999.99, Category: "electronics"}
	if err := product.Save(); err != nil {
		t.Errorf("Save failed: %v", err)
	}
}

func TestProductValidate(t *testing.T) {
	tests := []struct {
		name    string
		product Product
		wantErr bool
	}{
		{"valid product", Product{Name: "Phone", Price: 500}, false},
		{"empty name", Product{Name: "", Price: 100}, true},
		{"negative price", Product{Name: "Bad", Price: -10}, true},
		{"zero price", Product{Name: "Free", Price: 0}, true},
	}

	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			err := tt.product.Validate()
			if (err != nil) != tt.wantErr {
				t.Errorf("Validate() error = %v, wantErr %v", err, tt.wantErr)
			}
		})
	}
}

func TestGetProductByName(t *testing.T) {
	p, err := GetProductByName("Tablet")
	if err != nil {
		t.Errorf("GetProductByName failed: %v", err)
	}
	if p.Name != "Tablet" {
		t.Errorf("Expected name Tablet, got %s", p.Name)
	}
}
