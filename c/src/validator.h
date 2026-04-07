/**
 * Validator header file
 */

#ifndef VALIDATOR_H
#define VALIDATOR_H

#include <stdbool.h>

bool validate_email(const char* email);
bool validate_username(const char* username);
void sanitize_input(const char* input, char* output);
void safe_copy(char* dest, const char* src, size_t dest_size);
bool safe_concat(char* dest, const char* src, size_t dest_size);

#endif