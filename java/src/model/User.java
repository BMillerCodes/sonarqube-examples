package com.example.model;

import java.time.LocalDateTime;
import java.util.Objects;

/**
 * User entity with basic profile information.
 * Contains code smell: plain text password storage (no hashing)
 */
public class User {
    private Long id;
    private String username;
    private String email;
    private String password; // Code smell: storing password in plain text
    private UserStatus status;
    private LocalDateTime createdAt;
    private LocalDateTime lastLogin;

    public User() {
        this.status = UserStatus.ACTIVE;
        this.createdAt = LocalDateTime.now();
    }

    public User(Long id, String username, String email) {
        this.id = id;
        this.username = username;
        this.email = email;
        this.status = UserStatus.ACTIVE;
        this.createdAt = LocalDateTime.now();
    }

    // Getters and setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public UserStatus getStatus() { return status; }
    public void setStatus(UserStatus status) { this.status = status; }

    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }

    public LocalDateTime getLastLogin() { return lastLogin; }
    public void setLastLogin(LocalDateTime lastLogin) { this.lastLogin = lastLogin; }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        User user = (User) o;
        return Objects.equals(id, user.id);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id);
    }

    @Override
    public String toString() {
        return "User{id=" + id + ", username='" + username + "', email='" + email + "'}";
    }
}