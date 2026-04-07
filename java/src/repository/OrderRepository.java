package com.example.repository;

import com.example.model.Order;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

/**
 * In-memory order storage singleton.
 */
public class OrderRepository {
    private static OrderRepository instance;
    private final Map<Long, Order> orders = new ConcurrentHashMap<>();
    private long nextId = 1L;

    private OrderRepository() {}

    public static synchronized OrderRepository getInstance() {
        if (instance == null) {
            instance = new OrderRepository();
        }
        return instance;
    }

    public Order save(Order order) {
        if (order.getId() == null) {
            order.setId(nextId++);
        }
        orders.put(order.getId(), order);
        return order;
    }

    public Order findById(Long id) {
        return orders.get(id);
    }

    public List<Order> findAll() {
        return new ArrayList<>(orders.values());
    }

    public List<Order> findByUserId(Long userId) {
        // Code smell: non-thread-safe iteration in find method
        List<Order> result = new ArrayList<>();
        for (Order order : orders.values()) {
            if (order.getUserId().equals(userId)) {
                result.add(order);
            }
        }
        return result;
    }

    public void deleteById(Long id) {
        orders.remove(id);
    }

    public long count() {
        return orders.size();
    }

    public void clear() {
        orders.clear();
        nextId = 1L;
    }
}