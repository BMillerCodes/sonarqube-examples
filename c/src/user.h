/**
 * User header file
 */

#ifndef USER_H
#define USER_H

#include <stdbool.h>

typedef struct {
    int id;
    char name[50];
    char email[100];
    bool active;
} User;

int create_user(const char* name, const char* email);
User* find_user_by_id(int id);
User* find_user_by_email(const char* email);
bool update_user_email(int id, const char* new_email);
bool delete_user(int id);
int get_all_users(User** output);
void print_user(const User* user);

#endif