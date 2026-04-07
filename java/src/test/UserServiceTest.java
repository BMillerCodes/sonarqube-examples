package com.example.test;

import com.example.exception.ResourceNotFoundException;
import com.example.exception.ValidationException;
import com.example.model.User;
import com.example.repository.UserRepository;
import com.example.service.UserService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

/**
 * Unit tests for UserService.
 * Note: Tests depend on singleton state which is a code smell itself.
 */
public class UserServiceTest {
    private UserService userService;

    @BeforeEach
    public void setUp() {
        // Clear singleton state before each test
        UserRepository.getInstance().clear();
        userService = new UserService();
    }

    @Test
    public void testCreateUser_Success() {
        User user = userService.createUser("johndoe", "john@example.com", "password123");
        assertNotNull(user);
        assertNotNull(user.getId());
        assertEquals("johndoe", user.getUsername());
        assertEquals("john@example.com", user.getEmail());
    }

    @Test
    public void testCreateUser_DuplicateUsername() {
        userService.createUser("johndoe", "john@example.com", "password123");
        assertThrows(ValidationException.class, () -> {
            userService.createUser("johndoe", "jane@example.com", "password456");
        });
    }

    @Test
    public void testCreateUser_InvalidEmail() {
        assertThrows(ValidationException.class, () -> {
            userService.createUser("johndoe", "invalid-email", "password123");
        });
    }

    @Test
    public void testCreateUser_ShortPassword() {
        assertThrows(ValidationException.class, () -> {
            userService.createUser("johndoe", "john@example.com", "123");
        });
    }

    @Test
    public void testGetUserById_Success() {
        User created = userService.createUser("johndoe", "john@example.com", "password123");
        User found = userService.getUserById(created.getId());
        assertNotNull(found);
        assertEquals(created.getId(), found.getId());
    }

    @Test
    public void testGetUserById_NotFound() {
        assertThrows(ResourceNotFoundException.class, () -> {
            userService.getUserById(999L);
        });
    }

    @Test
    public void testAuthenticate_Success() {
        userService.createUser("johndoe", "john@example.com", "password123");
        User authenticated = userService.authenticate("johndoe", "password123");
        assertNotNull(authenticated);
        assertNotNull(authenticated.getLastLogin());
    }

    @Test
    public void testAuthenticate_WrongPassword() {
        userService.createUser("johndoe", "john@example.com", "password123");
        assertThrows(ValidationException.class, () -> {
            userService.authenticate("johndoe", "wrongpassword");
        });
    }

    @Test
    public void testUpdateUser_Success() {
        User created = userService.createUser("johndoe", "john@example.com", "password123");
        User updated = userService.updateUser(created.getId(), "newemail@example.com", null);
        assertEquals("newemail@example.com", updated.getEmail());
        // Password should remain unchanged
        assertEquals("password123", updated.getPassword());
    }

    @Test
    public void testDeleteUser_Success() {
        User created = userService.createUser("johndoe", "john@example.com", "password123");
        userService.deleteUser(created.getId());
        assertThrows(ResourceNotFoundException.class, () -> {
            userService.getUserById(created.getId());
        });
    }
}