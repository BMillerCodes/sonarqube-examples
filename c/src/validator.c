/**
 * String validator utilities
 * Code smell: buffer operations without bounds checking
 */

#include <stdio.h>
#include <string.h>
#include <stdbool.h>
#include <ctype.h>

// Code smell: static buffer with fixed size
#define MAX_BUFFER_SIZE 256

/**
 * Validate email format (simplified)
 */
bool validate_email(const char* email) {
    if (!email) return false; // Code smell: direct pointer check

    const char* at_sign = strchr(email, '@');
    const char* dot = strchr(email, '.');

    // Code smell: pointer arithmetic without proper bounds checking
    return at_sign != NULL && dot != NULL && dot > at_sign;
}

/**
 * Validate username (alphanumeric and underscore only)
 */
bool validate_username(const char* username) {
    if (!username) return false;

    // Code smell: iterating without length check
    for (int i = 0; username[i] != '\0'; i++) {
        char c = username[i];
        if (!isalnum(c) && c != '_') {
            return false;
        }
    }
    return true;
}

/**
 * Sanitize input string - remove dangerous characters
 * Code smell: buffer overflow potential
 */
void sanitize_input(const char* input, char* output) {
    int j = 0;
    for (int i = 0; input[i] != '\0'; i++) {
        char c = input[i];
        // Remove potentially dangerous characters
        if (c != '<' && c != '>' && c != ';' && c != '&') {
            output[j++] = c;
        }
    }
    output[j] = '\0';
}

/**
 * Copy string with bounds checking (safer version)
 * Code smell: function name suggests safety but still has issues
 */
void safe_copy(char* dest, const char* src, size_t dest_size) {
    size_t i = 0;
    while (i < dest_size - 1 && src[i] != '\0') {
        dest[i] = src[i];
        i++;
    }
    dest[i] = '\0';
}

/**
 * Concatenate strings safely
 */
bool safe_concat(char* dest, const char* src, size_t dest_size) {
    size_t dest_len = strlen(dest);
    size_t src_len = strlen(src);

    if (dest_len + src_len >= dest_size) {
        return false; // Would overflow
    }

    strcat(dest, src);
    return true;
}