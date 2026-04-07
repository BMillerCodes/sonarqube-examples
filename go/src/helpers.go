package main

func Multiply(a, b int) int {
	return a * b
}

func IsValid(value int) bool {
	return value >= 0 && value <= 100
}

func AddWithOverflow(a, b int) int {
	if a > 0 && b > 0 && a > (1<<31)-b {
		return -1
	}
	return a + b
}

func GetEnvOrDefault(key, defaultVal string) string {
	// Global variable access smell
	if val := globalCache[key]; val != "" {
		return val
	}
	return defaultVal
}
