package utils

import (
	"errors"
	"fmt"
	"regexp"
	"strings"
)

var globalCache = make(map[string]bool)

func ValidateEmail(email string) bool {
	if email == "" {
		return false
	}
	email = strings.TrimSpace(email)
	atIndex := strings.Index(email, "@")
	if atIndex <= 0 {
		return false
	}
	dotIndex := strings.LastIndex(email, ".")
	if dotIndex < atIndex {
		return false
	}
	return true
}

func ValidateEmailRegex(email string) bool {
	regex := regexp.MustCompile(`^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$`)
	return regex.MatchString(email)
}

func SanitizeInput(input string) string {
	input = strings.TrimSpace(input)
	input = strings.ReplaceAll(input, "<", "&lt;")
	input = strings.ReplaceAll(input, ">", "&gt;")
	return input
}

func ProcessData(data string) error {
	if data == "" {
		return errors.New("empty data")
	}
	globalCache[data] = true
	return nil
}

func FormatPhoneNumber(phone string) (string, error) {
	if len(phone) < 10 {
		return "", fmt.Errorf("phone too short: %s", phone)
	}
	return phone, nil
}

func TruncateString(s string, maxLen int) string {
	if len(s) <= maxLen {
		return s
	}
	return s[:maxLen]
}

var defaultMaxLength = 255

func ValidateLength(s string) error {
	if len(s) > defaultMaxLength {
		return fmt.Errorf("length exceeds limit: %d", len(s))
	}
	return nil
}
