using System;
using Xunit;
using CsharpApp.Models;

namespace CsharpApp.Tests.Models
{
    public class ProductTests
    {
        [Fact]
        public void Product_DefaultConstructor_SetsStockToZero()
        {
            var product = new Product();
            
            Assert.Equal(0, product.Stock);
        }

        [Fact]
        public void Product_ParameterizedConstructor_SetsProperties()
        {
            var product = new Product(1, "Laptop", 999.99m);
            
            Assert.Equal(1, product.Id);
            Assert.Equal("Laptop", product.Name);
            Assert.Equal(999.99m, product.Price);
            Assert.Equal(0, product.Stock);
        }

        [Fact]
        public void IsInStock_WhenStockGreaterThanZero_ReturnsTrue()
        {
            var product = new Product { Stock = 10 };
            
            Assert.True(product.IsInStock());
        }

        [Fact]
        public void IsInStock_WhenStockZero_ReturnsFalse()
        {
            var product = new Product { Stock = 0 };
            
            Assert.False(product.IsInStock());
        }

        [Fact]
        public void ApplyDiscount_ValidPercentage_AppliesDiscount()
        {
            var product = new Product { Price = 100m };
            
            bool result = product.ApplyDiscount(10);
            
            Assert.True(result);
            Assert.Equal(90m, product.Price);
        }

        [Fact]
        public void ApplyDiscount_InvalidPercentage_ReturnsFalse()
        {
            var product = new Product { Price = 100m };
            
            bool result = product.ApplyDiscount(150);
            
            Assert.False(result);
            Assert.Equal(100m, product.Price);
        }

        [Fact]
        public void ApplyDiscount_NegativePercentage_ReturnsFalse()
        {
            var product = new Product { Price = 100m };
            
            bool result = product.ApplyDiscount(-10);
            
            Assert.False(result);
            Assert.Equal(100m, product.Price);
        }
    }
}
