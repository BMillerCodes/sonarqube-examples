package main

import (
	"testing"
)

func TestMultiply(t *testing.T) {
	if Multiply(3, 4) != 12 {
		t.Error("Expected 12")
	}
}
