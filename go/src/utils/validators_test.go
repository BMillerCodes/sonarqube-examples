package utils

import (
	"testing"
)

func TestValidateEmail(t *testing.T) {
	tests := []struct {
		email   string
		isValid bool
	}{
		{"test@example.com", true},
		{"user@domain.org", true},
		{"", false},
		{"invalid", false},
		{"@example.com", false},
		{"user@", false},
	}

	for _, tt := range tests {
		t.Run(tt.email, func(t *testing.T) {
			result := ValidateEmail(tt.email)
			if result != tt.isValid {
				t.Errorf("ValidateEmail(%s) = %v, want %v", tt.email, result, tt.isValid)
			}
		})
	}
}

func TestValidateEmailRegex(t *testing.T) {
	if !ValidateEmailRegex("valid@test.com") {
		t.Error("Expected valid email to pass")
	}
	if ValidateEmailRegex("invalid") {
		t.Error("Expected invalid email to fail")
	}
}

func TestSanitizeInput(t *testing.T) {
	input := "  <script>alert('xss')</script>  "
	result := SanitizeInput(input)
	if result == input {
		t.Error("SanitizeInput should modify input")
	}
}

func TestProcessData(t *testing.T) {
	err := ProcessData("some data")
	if err != nil {
		t.Errorf("ProcessData failed: %v", err)
	}
}

func TestProcessDataEmpty(t *testing.T) {
	err := ProcessData("")
	if err == nil {
		t.Error("Expected error for empty data")
	}
}

func TestFormatPhoneNumber(t *testing.T) {
	phone, err := FormatPhoneNumber("1234567890")
	if err != nil {
		t.Errorf("FormatPhoneNumber failed: %v", err)
	}
	if phone != "1234567890" {
		t.Errorf("Expected phone unchanged, got %s", phone)
	}
}

func TestFormatPhoneNumberTooShort(t *testing.T) {
	_, err := FormatPhoneNumber("123")
	if err == nil {
		t.Error("Expected error for short phone")
	}
}

func TestTruncateString(t *testing.T) {
	result := TruncateString("Hello World", 5)
	if result != "Hello" {
		t.Errorf("Expected 'Hello', got '%s'", result)
	}
}

func TestValidateLength(t *testing.T) {
	err := ValidateLength("short")
	if err != nil {
		t.Errorf("ValidateLength failed: %v", err)
	}
}

func TestValidateLengthTooLong(t *testing.T) {
	longString := ""
	for i := 0; i < 300; i++ {
		longString += "x"
	}
	err := ValidateLength(longString)
	if err == nil {
		t.Error("Expected error for too long string")
	}
}
