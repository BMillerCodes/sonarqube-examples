package utils

import (
	"testing"
)

func TestToJSON(t *testing.T) {
	data := map[string]string{"key": "value"}
	jsonBytes, err := ToJSON(data)
	if err != nil {
		t.Errorf("ToJSON failed: %v", err)
	}
	if len(jsonBytes) == 0 {
		t.Error("Expected non-empty json")
	}
}

func TestFromJSON(t *testing.T) {
	jsonData := []byte(`{"key":"value"}`)
	var result map[string]string
	err := FromJSON(jsonData, &result)
	if err != nil {
		t.Errorf("FromJSON failed: %v", err)
	}
	if result["key"] != "value" {
		t.Errorf("Expected 'value', got '%s'", result["key"])
	}
}

func TestToJSONString(t *testing.T) {
	data := struct{ Name string }{Name: "Test"}
	result, err := ToJSONString(data)
	if err != nil {
		t.Errorf("ToJSONString failed: %v", err)
	}
	if result == "" {
		t.Error("Expected non-empty string")
	}
}
