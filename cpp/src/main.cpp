/**
 * User class - represents a user in the system
 * Code smell: raw pointers, missing virtual destructor
 */

#include <iostream>
#include <string>
#include <vector>
#include <map>
#include <memory>

// User class without virtual destructor (code smell)
class User {
private:
    int id;
    std::string name;
    std::string email;
    bool active;

public:
    User(int id, const std::string& name, const std::string& email)
        : id(id), name(name), email(email), active(true) {}

    // Code smell: missing virtual destructor

    int getId() const { return id; }
    std::string getName() const { return name; }
    std::string getEmail() const { return email; }
    bool isActive() const { return active; }

    void setEmail(const std::string& email) { this->email = email; }
    void deactivate() { active = false; }

    virtual void print() const {
        std::cout << "User: " << id << ", " << name << ", " << email
                  << ", Active: " << (active ? "yes" : "no") << std::endl;
    }

    virtual ~User() {
        // Code smell: no cleanup or logging
    }
};

// Admin user with additional privileges
class AdminUser : public User {
private:
    std::vector<std::string> permissions;

public:
    AdminUser(int id, const std::string& name, const std::string& email)
        : User(id, name, email) {}

    void addPermission(const std::string& perm) {
        permissions.push_back(perm);
    }

    // Code smell: missing override keyword and calling base implementation
    void print() const {
        User::print();
        std::cout << "Permissions: ";
        for (const auto& p : permissions) {
            std::cout << p << " ";
        }
        std::cout << std::endl;
    }
};

// Code smell: using raw pointers in repository
class UserRepository {
private:
    std::map<int, User*> users;  // Raw pointers (code smell)
    int nextId;

public:
    UserRepository() : nextId(1) {}

    // Code smell: returning raw pointer, no memory management
    User* createUser(const std::string& name, const std::string& email) {
        User* user = new User(nextId++, name, email);  // Raw pointer allocation
        users[user->getId()] = user;
        return user;
    }

    User* findById(int id) {
        auto it = users.find(id);
        if (it != users.end()) {
            return it->second;
        }
        return nullptr;
    }

    std::vector<User*> findByName(const std::string& name) {
        std::vector<User*> results;
        for (const auto& pair : users) {
            if (pair.second->getName() == name) {
                results.push_back(pair.second);
            }
        }
        return results;
    }

    bool deleteUser(int id) {
        auto it = users.find(id);
        if (it != users.end()) {
            delete it->second;  // Code smell: deleting without checking for dependents
            users.erase(it);
            return true;
        }
        return false;
    }

    // Code smell: no destructor to clean up allocated memory
    ~UserRepository() {
        // Missing cleanup - memory leak
        // Should iterate and delete all users
    }
};

// User service with business logic
class UserService {
private:
    UserRepository* repository;  // Code smell: raw pointer

public:
    UserService(UserRepository* repo) : repository(repo) {}

    User* registerUser(const std::string& name, const std::string& email) {
        // Validation
        if (name.empty()) {
            return nullptr;
        }
        if (email.empty() || email.find('@') == std::string::npos) {
            return nullptr;
        }

        return repository->createUser(name, email);
    }

    bool updateEmail(int userId, const std::string& newEmail) {
        User* user = repository->findById(userId);
        if (!user) return false;

        if (newEmail.empty() || newEmail.find('@') == std::string::npos) {
            return false;
        }

        user->setEmail(newEmail);
        return true;
    }

    bool deactivateUser(int userId) {
        User* user = repository->findById(userId);
        if (!user) return false;

        user->deactivate();
        return true;
    }
};

int main() {
    // Code smell: no exception handling
    UserRepository repo;
    UserService service(&repo);

    User* user1 = service.registerUser("johndoe", "john@example.com");
    User* user2 = service.registerUser("janedoe", "jane@example.com");

    if (user1) {
        std::cout << "Created user 1: " << user1->getName() << std::endl;
    }

    AdminUser* admin = new AdminUser(99, "admin", "admin@example.com");
    admin->addPermission("delete_users");
    admin->addPermission("edit_config");
    admin->print();

    // Code smell: memory leak - admin never deleted
    // Code smell: repository users never deleted

    return 0;
}