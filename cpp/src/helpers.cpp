#include "helpers.hpp"
#include <sstream>

int multiply(int a, int b) {
    return a * b;
}

bool is_valid(int value) {
    return value >= 0 && value <= 100;
}

std::string format_message(const std::string& message) {
    return "[INFO] " + message;
}