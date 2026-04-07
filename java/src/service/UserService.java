package com.example.service;

import com.example.exception.ResourceNotFoundException;
import com.example.exception.ValidationException;
import com.example.model.User;
import com.example.repository.UserRepository;

import java.time.LocalDateTime;
import java.util.List;

/**
 * User business logic layer.
 * Code smell: God class doing too much, duplicate validation logic
 */
public class UserService {
    private final UserRepository userRepository;

    public UserService() {
        this.userRepository = UserRepository.getInstance();
    }

    public User createUser(String username, String email, String password) {
        // Code smell: duplicate validation logic scattered across methods
        if (username == null || username.trim().isEmpty()) {
            throw new ValidationException("username", "Username cannot be empty");
        }
        if (username.length() < 3 || username.length() > 50) {
            throw new ValidationException("username", "Username must be between 3 and 50 characters");
        }
        if (email == null || !email.contains("@")) {
            throw new ValidationException("email", "Invalid email format");
        }
        if (password == null || password.length() < 6) {
            throw new ValidationException("password", "Password must be at least 6 characters");
        }

        // Check for existing username
        User existing = userRepository.findByUsername(username);
        if (existing != null) {
            throw new ValidationException("username", "Username already exists");
        }

        User user = new User(null, username, email);
        user.setPassword(password); // Code smell: storing plain text
        return userRepository.save(user);
    }

    public User getUserById(Long id) {
        User user = userRepository.findById(id);
        if (user == null) {
            throw new ResourceNotFoundException("User", "id", id);
        }
        return user;
    }

    public User updateUser(Long id, String email, String password) {
        // Code smell: more duplicate validation, long method with too many responsibilities
        if (id == null) {
            throw new ValidationException("id", "User ID cannot be null");
        }

        User user = userRepository.findById(id);
        if (user == null) {
            throw new ResourceNotFoundException("User", "id", id);
        }

        if (email != null && !email.isEmpty()) {
            if (!email.contains("@")) {
                throw new ValidationException("email", "Invalid email format");
            }
            user.setEmail(email);
        }

        if (password != null && !password.isEmpty()) {
            if (password.length() < 6) {
                throw new ValidationException("password", "Password must be at least 6 characters");
            }
            user.setPassword(password); // Code smell: storing plain text
        }

        return userRepository.save(user);
    }

    public User authenticate(String username, String password) {
        // Code smell: plain text password comparison
        if (username == null || password == null) {
            throw new ValidationException("Invalid credentials");
        }

        User user = userRepository.findByUsername(username);
        if (user == null) {
            throw new ResourceNotFoundException("User", "username", username);
        }

        // Code smell: direct password comparison instead of using BCrypt or similar
        if (!password.equals(user.getPassword())) {
            throw new ValidationException("Invalid credentials");
        }

        user.setLastLogin(LocalDateTime.now());
        return userRepository.save(user);
    }

    public List<User> getAllUsers() {
        return userRepository.findAll();
    }

    public void deleteUser(Long id) {
        User user = userRepository.findById(id);
        if (user == null) {
            throw new ResourceNotFoundException("User", "id", id);
        }
        userRepository.deleteById(id);
    }

    public boolean existsByUsername(String username) {
        return userRepository.findByUsername(username) != null;
    }

    public boolean existsByEmail(String email) {
        return userRepository.findByEmail(email) != null;
    }
}