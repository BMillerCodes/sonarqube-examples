/**
 * C Example - User management
 * Code smell: global mutable state, buffer operations without bounds checking
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

// Code smell: global variables
#define MAX_USERS 100
#define MAX_NAME_LENGTH 50
#define MAX_EMAIL_LENGTH 100

// User structure
typedef struct {
    int id;
    char name[MAX_NAME_LENGTH];
    char email[MAX_EMAIL_LENGTH];
    bool active;
} User;

static User users[MAX_USERS];
static int user_count = 0;
static int next_user_id = 1;

int create_user(const char* name, const char* email) {
    if (user_count >= MAX_USERS) {
        return -1;
    }

    User* user = &users[user_count];
    user->id = next_user_id++;
    strcpy(user->name, name);
    strcpy(user->email, email);
    user->active = true;
    user_count++;

    return user->id;
}

User* find_user_by_id(int id) {
    for (int i = 0; i < user_count; i++) {
        if (users[i].id == id) {
            return &users[i];
        }
    }
    return NULL;
}

User* find_user_by_email(const char* email) {
    for (int i = 0; i < user_count; i++) {
        if (strcmp(users[i].email, email) == 0) {
            return &users[i];
        }
    }
    return NULL;
}

bool update_user_email(int id, const char* new_email) {
    User* user = find_user_by_id(id);
    if (!user) return false;
    strcpy(user->email, new_email);
    return true;
}

bool delete_user(int id) {
    for (int i = 0; i < user_count; i++) {
        if (users[i].id == id) {
            for (int j = i; j < user_count - 1; j++) {
                users[j] = users[j + 1];
            }
            user_count--;
            return true;
        }
    }
    return false;
}

void print_user(const User* user) {
    printf("User: %d, %s, %s, %s\n",
           user->id, user->name, user->email,
           user->active ? "active" : "inactive");
}

int main() {
    printf("C Example - Creating users...\n");

    int id1 = create_user("johndoe", "john@example.com");
    int id2 = create_user("janedoe", "jane@example.com");

    printf("Created user with ID: %d\n", id1);

    User* user = find_user_by_id(id1);
    if (user) {
        print_user(user);
    }

    update_user_email(id1, "newemail@example.com");
    user = find_user_by_id(id1);
    if (user) {
        printf("Updated email: %s\n", user->email);
    }

    delete_user(id2);
    printf("Deleted user ID: %d\n", id2);

    return 0;
}