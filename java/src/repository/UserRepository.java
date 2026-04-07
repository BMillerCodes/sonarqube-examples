package com.example.repository;

import com.example.model.User;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.stream.Collectors;

/**
 * In-memory user storage singleton.
 * Code smell: Singleton with poor thread safety for iteration
 */
public class UserRepository {
    private static UserRepository instance;
    private final Map<Long, User> users = new ConcurrentHashMap<>();
    private long nextId = 1L;

    private UserRepository() {}

    public static synchronized UserRepository getInstance() {
        if (instance == null) {
            instance = new UserRepository();
        }
        return instance;
    }

    public User save(User user) {
        if (user.getId() == null) {
            user.setId(nextId++);
        }
        users.put(user.getId(), user);
        return user;
    }

    public User findById(Long id) {
        return users.get(id);
    }

    public List<User> findAll() {
        // Code smell: non-thread-safe iteration
        return new ArrayList<>(users.values());
    }

    public User findByUsername(String username) {
        return users.values().stream()
                .filter(u -> u.getUsername().equals(username))
                .findFirst()
                .orElse(null);
    }

    public User findByEmail(String email) {
        return users.values().stream()
                .filter(u -> u.getEmail().equals(email))
                .findFirst()
                .orElse(null);
    }

    public List<User> findByUserIds(List<Long> userIds) {
        // Code smell: iteration during stream operation
        return users.values().stream()
                .filter(u -> userIds.contains(u.getId()))
                .collect(Collectors.toList());
    }

    public void deleteById(Long id) {
        users.remove(id);
    }

    public long count() {
        return users.size();
    }

    public void clear() {
        users.clear();
        nextId = 1L;
    }
}