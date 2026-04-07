package com.example.service;

import com.example.exception.ResourceNotFoundException;
import com.example.exception.ValidationException;
import com.example.model.Order;
import com.example.model.OrderStatus;
import com.example.repository.OrderRepository;
import com.example.repository.UserRepository;

import java.util.List;

/**
 * Order business logic layer.
 * Code smell: God class with too many responsibilities
 */
public class OrderService {
    private final OrderRepository orderRepository;
    private final UserRepository userRepository;

    public OrderService() {
        this.orderRepository = OrderRepository.getInstance();
        this.userRepository = UserRepository.getInstance();
    }

    public Order createOrder(Long userId, Double totalAmount, String items) {
        // Code smell: long method with validation scattered
        if (userId == null) {
            throw new ValidationException("userId", "User ID cannot be null");
        }
        if (userId <= 0) {
            throw new ValidationException("userId", "User ID must be positive");
        }
        if (totalAmount == null) {
            throw new ValidationException("totalAmount", "Total amount cannot be null");
        }
        if (totalAmount < 0) {
            throw new ValidationException("totalAmount", "Total amount cannot be negative");
        }
        if (totalAmount > 10000) {
            throw new ValidationException("totalAmount", "Total amount exceeds maximum allowed");
        }

        // Verify user exists
        if (userRepository.findById(userId) == null) {
            throw new ResourceNotFoundException("User", "id", userId);
        }

        if (items == null || items.trim().isEmpty()) {
            throw new ValidationException("items", "Items cannot be empty");
        }

        Order order = new Order(null, userId, totalAmount);
        order.setItems(items);
        return orderRepository.save(order);
    }

    public Order getOrderById(Long id) {
        Order order = orderRepository.findById(id);
        if (order == null) {
            throw new ResourceNotFoundException("Order", "id", id);
        }
        return order;
    }

    public List<Order> getOrdersByUserId(Long userId) {
        if (userId == null) {
            throw new ValidationException("userId", "User ID cannot be null");
        }
        return orderRepository.findByUserId(userId);
    }

    public Order updateOrderStatus(Long orderId, OrderStatus status) {
        if (orderId == null) {
            throw new ValidationException("orderId", "Order ID cannot be null");
        }
        if (status == null) {
            throw new ValidationException("status", "Status cannot be null");
        }

        Order order = orderRepository.findById(orderId);
        if (order == null) {
            throw new ResourceNotFoundException("Order", "id", orderId);
        }

        order.setStatus(status);
        return orderRepository.save(order);
    }

    public Order shipOrder(Long orderId) {
        Order order = getOrderById(orderId);

        if (order.getStatus() != OrderStatus.CONFIRMED) {
            throw new ValidationException("Order must be confirmed before shipping");
        }

        order.setStatus(OrderStatus.SHIPPED);
        order.setShippedAt(java.time.LocalDateTime.now());
        return orderRepository.save(order);
    }

    public List<Order> getAllOrders() {
        return orderRepository.findAll();
    }

    public void cancelOrder(Long orderId) {
        Order order = getOrderById(orderId);

        if (order.getStatus() == OrderStatus.SHIPPED || order.getStatus() == OrderStatus.DELIVERED) {
            throw new ValidationException("Cannot cancel shipped or delivered orders");
        }

        order.setStatus(OrderStatus.CANCELLED);
        orderRepository.save(order);
    }

    public long getOrderCount() {
        return orderRepository.count();
    }
}