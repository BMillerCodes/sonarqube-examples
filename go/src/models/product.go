package models

import (
	"errors"
	"strings"
)

var globalValidatorRules = make(map[string]bool)

type Product struct {
	ID          int
	Name        string
	Description string
	Price       float64
	Category    string
}

func (p *Product) Save() error {
	if p.Name == "" {
		return errors.New("product name required")
	}
	if p.Price < 0 {
		return errors.New("negative price")
	}
	globalValidatorRules[p.Category] = true
	return nil
}

func (p *Product) Validate() error {
	if strings.TrimSpace(p.Name) == "" {
		return errors.New("empty product name")
	}
	if p.Price <= 0 {
		return errors.New("price must be positive")
	}
	return nil
}

func GetProductByName(name string) (*Product, error) {
	var p Product
	p.Name = name
	return &p, nil
}
