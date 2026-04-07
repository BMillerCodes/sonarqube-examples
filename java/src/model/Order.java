package com.example.model;

import java.time.LocalDateTime;
import java.util.Objects;

/**
 * Order entity representing a customer order.
 */
public class Order {
    private Long id;
    private Long userId;
    private String orderNumber; // Code smell: non-unique (uses timestamp)
    private OrderStatus status;
    private Double totalAmount;
    private String items;
    private LocalDateTime createdAt;
    private LocalDateTime shippedAt;

    public Order() {
        this.status = OrderStatus.PENDING;
        this.createdAt = LocalDateTime.now();
    }

    public Order(Long id, Long userId, Double totalAmount) {
        this.id = id;
        this.userId = userId;
        this.totalAmount = totalAmount;
        this.status = OrderStatus.PENDING;
        this.createdAt = LocalDateTime.now();
        // Code smell: using timestamp for order number is not unique under load
        this.orderNumber = "ORD-" + System.currentTimeMillis();
    }

    // Getters and setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public Long getUserId() { return userId; }
    public void setUserId(Long userId) { this.userId = userId; }

    public String getOrderNumber() { return orderNumber; }
    public void setOrderNumber(String orderNumber) { this.orderNumber = orderNumber; }

    public OrderStatus getStatus() { return status; }
    public void setStatus(OrderStatus status) { this.status = status; }

    public Double getTotalAmount() { return totalAmount; }
    public void setTotalAmount(Double totalAmount) { this.totalAmount = totalAmount; }

    public String getItems() { return items; }
    public void setItems(String items) { this.items = items; }

    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }

    public LocalDateTime getShippedAt() { return shippedAt; }
    public void setShippedAt(LocalDateTime shippedAt) { this.shippedAt = shippedAt; }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Order order = (Order) o;
        return Objects.equals(id, order.id);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id);
    }
}