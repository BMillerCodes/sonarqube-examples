package com.example.test;

import com.example.exception.ResourceNotFoundException;
import com.example.exception.ValidationException;
import com.example.model.Order;
import com.example.model.OrderStatus;
import com.example.repository.OrderRepository;
import com.example.repository.UserRepository;
import com.example.service.OrderService;
import com.example.service.UserService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

/**
 * Unit tests for OrderService.
 */
public class OrderServiceTest {
    private OrderService orderService;
    private UserService userService;

    @BeforeEach
    public void setUp() {
        UserRepository.getInstance().clear();
        OrderRepository.getInstance().clear();
        userService = new UserService();
        orderService = new OrderService();
    }

    @Test
    public void testCreateOrder_Success() {
        var user = userService.createUser("johndoe", "john@example.com", "password123");
        Order order = orderService.createOrder(user.getId(), 99.99, "Widget x 2");
        assertNotNull(order);
        assertNotNull(order.getId());
        assertEquals(user.getId(), order.getUserId());
        assertEquals(99.99, order.getTotalAmount());
        assertEquals(OrderStatus.PENDING, order.getStatus());
    }

    @Test
    public void testCreateOrder_InvalidAmount() {
        var user = userService.createUser("johndoe", "john@example.com", "password123");
        assertThrows(ValidationException.class, () -> {
            orderService.createOrder(user.getId(), -50.00, "Item");
        });
    }

    @Test
    public void testCreateOrder_ExceedsMaximum() {
        var user = userService.createUser("johndoe", "john@example.com", "password123");
        assertThrows(ValidationException.class, () -> {
            orderService.createOrder(user.getId(), 15000.00, "Expensive item");
        });
    }

    @Test
    public void testGetOrderById_Success() {
        var user = userService.createUser("johndoe", "john@example.com", "password123");
        Order created = orderService.createOrder(user.getId(), 99.99, "Widget");
        Order found = orderService.getOrderById(created.getId());
        assertNotNull(found);
        assertEquals(created.getId(), found.getId());
    }

    @Test
    public void testGetOrderById_NotFound() {
        assertThrows(ResourceNotFoundException.class, () -> {
            orderService.getOrderById(999L);
        });
    }

    @Test
    public void testGetOrdersByUserId_Success() {
        var user = userService.createUser("johndoe", "john@example.com", "password123");
        orderService.createOrder(user.getId(), 50.00, "Item1");
        orderService.createOrder(user.getId(), 75.00, "Item2");
        List<Order> orders = orderService.getOrdersByUserId(user.getId());
        assertEquals(2, orders.size());
    }

    @Test
    public void testUpdateOrderStatus_Success() {
        var user = userService.createUser("johndoe", "john@example.com", "password123");
        Order order = orderService.createOrder(user.getId(), 99.99, "Widget");
        Order updated = orderService.updateOrderStatus(order.getId(), OrderStatus.CONFIRMED);
        assertEquals(OrderStatus.CONFIRMED, updated.getStatus());
    }

    @Test
    public void testCancelOrder_Success() {
        var user = userService.createUser("johndoe", "john@example.com", "password123");
        Order order = orderService.createOrder(user.getId(), 99.99, "Widget");
        orderService.cancelOrder(order.getId());
        Order cancelled = orderService.getOrderById(order.getId());
        assertEquals(OrderStatus.CANCELLED, cancelled.getStatus());
    }

    @Test
    public void testCancelShippedOrder_Fails() {
        var user = userService.createUser("johndoe", "john@example.com", "password123");
        Order order = orderService.createOrder(user.getId(), 99.99, "Widget");
        orderService.updateOrderStatus(order.getId(), OrderStatus.CONFIRMED);
        orderService.updateOrderStatus(order.getId(), OrderStatus.SHIPPED);
        assertThrows(ValidationException.class, () -> {
            orderService.cancelOrder(order.getId());
        });
    }
}