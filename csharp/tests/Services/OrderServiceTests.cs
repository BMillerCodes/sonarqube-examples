using System;
using System.Collections.Generic;
using Xunit;
using CsharpApp.Services;
using CsharpApp.Models;

namespace CsharpApp.Tests.Services
{
    public class OrderServiceTests
    {
        private readonly OrderService _orderService;

        public OrderServiceTests()
        {
            _orderService = new OrderService();
        }

        [Fact]
        public void GetOrderById_NonExistingOrder_ReturnsNull()
        {
            var order = _orderService.GetOrderById(999);
            
            Assert.Null(order);
        }

        [Fact]
        public void GetOrdersByUserId_ReturnsOrders()
        {
            var orders = _orderService.GetOrdersByUserId(1, true);
            
            Assert.NotNull(orders);
        }

        [Fact]
        public void CreateOrder_InvalidUserId_ReturnsFalse()
        {
            var items = new List<OrderItem>
            {
                new OrderItem(1, "Test", 10m, 1)
            };
            
            bool result = _orderService.CreateOrder(999, items, 0, 0);
            
            Assert.False(result);
        }

        [Fact]
        public void CreateOrder_EmptyItems_ReturnsFalse()
        {
            bool result = _orderService.CreateOrder(1, new List<OrderItem>(), 0, 0);
            
            Assert.False(result);
        }

        [Fact]
        public void CreateOrder_NullItems_ReturnsFalse()
        {
            bool result = _orderService.CreateOrder(1, null, 0, 0);
            
            Assert.False(result);
        }

        [Fact]
        public void UpdateOrderStatus_NonExistingOrder_ReturnsFalse()
        {
            bool result = _orderService.UpdateOrderStatus(999, "Completed", false);
            
            Assert.False(result);
        }

        [Fact]
        public void CancelOrder_NonExistingOrder_ReturnsFalse()
        {
            bool result = _orderService.CancelOrder(999, "Reason", true);
            
            Assert.False(result);
        }

        [Fact]
        public void CalculateOrderTotal_NonExistingOrder_ReturnsZero()
        {
            decimal total = _orderService.CalculateOrderTotal(999, true, false);
            
            Assert.Equal(0, total);
        }
    }
}
