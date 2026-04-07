#include "helpers.h"
#include <stdio.h>

int multiply(int a, int b) {
    return a * b;
}

int is_valid(int value) {
    return value >= 0 && value <= 100;
}

void format_message(const char *message, char *buffer, size_t size) {
    snprintf(buffer, size, "[INFO] %s", message);
}
