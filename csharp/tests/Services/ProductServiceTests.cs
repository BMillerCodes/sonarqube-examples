using System;
using Xunit;
using CsharpApp.Services;
using CsharpApp.Models;

namespace CsharpApp.Tests.Services
{
    public class ProductServiceTests
    {
        private readonly ProductService _productService;

        public ProductServiceTests()
        {
            _productService = new ProductService();
        }

        [Fact]
        public void GetProductById_ExistingProduct_ReturnsProduct()
        {
            var product = _productService.GetProductById(1);
            
            Assert.NotNull(product);
            Assert.Equal(1, product.Id);
        }

        [Fact]
        public void GetProductById_NonExistingProduct_ReturnsNull()
        {
            var product = _productService.GetProductById(999);
            
            Assert.Null(product);
        }

        [Fact]
        public void GetProductsByCategory_ReturnsMatchingProducts()
        {
            var products = _productService.GetProductsByCategory("Electronics", false);
            
            Assert.NotNull(products);
        }

        [Fact]
        public void CreateProduct_ValidData_ReturnsTrue()
        {
            bool result = _productService.CreateProduct("Test Product", "Description", 29.99m, 10, "Test");
            
            Assert.True(result);
        }

        [Fact]
        public void CreateProduct_EmptyName_ReturnsFalse()
        {
            bool result = _productService.CreateProduct("", "Description", 29.99m, 10, "Test");
            
            Assert.False(result);
        }

        [Fact]
        public void UpdateStock_ExistingProduct_ReturnsTrue()
        {
            bool result = _productService.UpdateStock(1, 100, true);
            
            Assert.True(result);
        }

        [Fact]
        public void UpdateStock_NonExistingProduct_ReturnsFalse()
        {
            bool result = _productService.UpdateStock(999, 100, true);
            
            Assert.False(result);
        }

        [Fact]
        public void ApplyDiscountToProduct_ValidDiscount_ReturnsTrue()
        {
            bool result = _productService.ApplyDiscountToProduct(1, 10, 0);
            
            Assert.True(result);
        }

        [Fact]
        public void SearchProducts_ReturnsResults()
        {
            var results = _productService.SearchProducts("Laptop", 10, 0);
            
            Assert.NotNull(results);
        }
    }
}
