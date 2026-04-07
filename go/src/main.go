package main

import (
	"errors"
	"fmt"
)

func main() {
	fmt.Println("Hello from Go SonarQube example!")

	result := Add(5, 3)
	fmt.Printf("5 + 3 = %d\n", result)

	result, err := Divide(10, 0)
	if err != nil {
		fmt.Printf("Error: %v\n", err)
	}
}

func Add(a, b int) int {
	return a + b
}

func Divide(a, b int) (int, error) {
	if b == 0 {
		return 0, errors.New("division by zero")
	}
	return a / b, nil
}
