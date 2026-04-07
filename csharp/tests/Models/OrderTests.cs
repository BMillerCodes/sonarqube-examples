using System;
using Xunit;
using CsharpApp.Models;

namespace CsharpApp.Tests.Models
{
    public class OrderTests
    {
        [Fact]
        public void Order_DefaultConstructor_SetsDefaults()
        {
            var order = new Order();
            
            Assert.NotNull(order.Items);
            Assert.Equal("Pending", order.Status);
            Assert.NotEqual(default, order.OrderDate);
        }

        [Fact]
        public void Order_ParameterizedConstructor_SetsProperties()
        {
            var order = new Order(1, 100);
            
            Assert.Equal(1, order.Id);
            Assert.Equal(100, order.UserId);
            Assert.Equal("Pending", order.Status);
        }

        [Fact]
        public void CalculateTotal_WithNoItems_ReturnsZero()
        {
            var order = new Order();
            order.CalculateTotal();
            
            Assert.Equal(0, order.TotalAmount);
        }

        [Fact]
        public void CalculateTotal_WithItems_CalculatesCorrectTotal()
        {
            var order = new Order
            {
                Items = new System.Collections.Generic.List<OrderItem>
                {
                    new OrderItem(1, "Product 1", 10m, 2),
                    new OrderItem(2, "Product 2", 5m, 3)
                }
            };
            
            order.CalculateTotal();
            
            Assert.Equal(35m, order.TotalAmount);
        }

        [Fact]
        public void AddItem_ValidItem_AddsToOrderAndRecalculates()
        {
            var order = new Order();
            var item = new OrderItem(1, "Test Product", 25m, 2);
            
            bool result = order.AddItem(item);
            
            Assert.True(result);
            Assert.Single(order.Items);
            Assert.Equal(50m, order.TotalAmount);
        }

        [Fact]
        public void AddItem_NullItem_ReturnsFalse()
        {
            var order = new Order();
            
            bool result = order.AddItem(null);
            
            Assert.False(result);
            Assert.Empty(order.Items);
        }
    }

    public class OrderItemTests
    {
        [Fact]
        public void OrderItem_DefaultConstructor_SetsQuantityToOne()
        {
            var item = new OrderItem();
            
            Assert.Equal(1, item.Quantity);
        }

        [Fact]
        public void OrderItem_ParameterizedConstructor_SetsAllProperties()
        {
            var item = new OrderItem(1, "Test", 19.99m, 5);
            
            Assert.Equal(1, item.ProductId);
            Assert.Equal("Test", item.ProductName);
            Assert.Equal(19.99m, item.Price);
            Assert.Equal(5, item.Quantity);
        }
    }
}
