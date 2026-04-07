package models

import (
	"testing"
)

func TestUserSave(t *testing.T) {
	user := &User{ID: 1, Name: "Bob", Email: "bob@test.com", Age: 30}
	if err := user.Save(nil); err != nil {
		t.Errorf("Save failed: %v", err)
	}
}

func TestUserValidate(t *testing.T) {
	tests := []struct {
		name    string
		user    User
		wantErr bool
	}{
		{"valid user", User{Age: 25}, false},
		{"invalid age negative", User{Age: -1}, true},
		{"invalid age too high", User{Age: 200}, true},
	}

	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			err := tt.user.Validate()
			if (err != nil) != tt.wantErr {
				t.Errorf("Validate() error = %v, wantErr %v", err, tt.wantErr)
			}
		})
	}
}

func TestGetUserByID(t *testing.T) {
	_, err := GetUserByID(nil, 999)
	if err == nil {
		t.Error("Expected error for invalid db")
	}
}

func TestUserSaveValidation(t *testing.T) {
	user := &User{Name: "", Email: "test@test.com"}
	if err := user.Save(nil); err == nil {
		t.Error("Expected validation error for empty name")
	}
}

func TestUserCreatedAt(t *testing.T) {
	user := &User{Name: "Test", Email: "test@test.com"}
	if !user.CreatedAt.IsZero() {
		t.Error("CreatedAt should be zero initially")
	}
}
