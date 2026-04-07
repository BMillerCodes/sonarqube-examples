using System;
using System.Collections.Generic;
using CsharpApp.Models;
using CsharpApp.Repositories;

namespace CsharpApp.Services
{
    public class ProductService
    {
        private readonly ProductRepository _productRepository;
        private readonly ILogger _logger;

        public ProductService()
        {
            _productRepository = new ProductRepository();
            _logger = new Logger();
        }

        public Product GetProductById(int id)
        {
            try
            {
                return _productRepository.GetById(id);
            }
            catch (Exception ex)
            {
                _logger.Log($"Error: {ex.Message}");
                return null;
            }
        }

        public List<Product> GetProductsByCategory(string category, bool includeInactive = false)
        {
            // Code smell: unused parameter includeInactive
            try
            {
                return _productRepository.GetByCategory(category);
            }
            catch (Exception ex)
            {
                _logger.Log($"Error: {ex.Message}");
                return new List<Product>();
            }
        }

        public bool CreateProduct(string name, string description, decimal price, int stock, string category)
        {
            if (string.IsNullOrEmpty(name))
            {
                return false;
            }

            try
            {
                var product = new Product
                {
                    Name = name,
                    Description = description,
                    Price = price,
                    Stock = stock,
                    Category = category
                };
                
                return _productRepository.Add(product);
            }
            catch (Exception)
            {
                // Empty catch block - code smell
            }
            return false;
        }

        public bool UpdateStock(int productId, int newStock, bool validateStock = true)
        {
            // Code smell: unused parameter validateStock
            try
            {
                var product = _productRepository.GetById(productId);
                if (product == null)
                    return false;

                product.Stock = newStock;
                return _productRepository.Update(product);
            }
            catch (Exception)
            {
                // Swallowing exception
            }
            return false;
        }

        public bool ApplyDiscountToProduct(int productId, decimal discountPercentage, int unusedArg)
        {
            // Multiple code smells: unused parameter unusedArg
            try
            {
                var product = _productRepository.GetById(productId);
                if (product == null)
                    return false;

                return product.ApplyDiscount(discountPercentage);
            }
            catch (Exception ex)
            {
                _logger.Log(ex.Message);
                return false;
            }
        }

        public List<Product> SearchProducts(string searchTerm, int pageSize, int pageIndex)
        {
            // Code smell: unused parameter pageIndex
            try
            {
                var allProducts = _productRepository.GetAll();
                var results = new List<Product>();
                
                foreach (var product in allProducts)
                {
                    if (product.Name.Contains(searchTerm, StringComparison.OrdinalIgnoreCase) ||
                        product.Description.Contains(searchTerm, StringComparison.OrdinalIgnoreCase))
                    {
                        results.Add(product);
                        if (results.Count >= pageSize)
                            break;
                    }
                }
                
                return results;
            }
            catch (Exception)
            {
                return new List<Product>();
            }
        }
    }

    public class Logger
    {
        public void Log(string message)
        {
            Console.WriteLine($"[LOG] {message}");
        }
    }

    public class EmailService
    {
        public void SendWelcomeEmail(string email, string name)
        {
            try
            {
                Console.WriteLine($"Sending welcome email to {email}");
                // Actual email sending logic would go here
            }
            catch (Exception)
            {
                // Silently fail - code smell: empty catch block
            }
        }

        public void SendOrderConfirmation(string email, int orderId)
        {
            try
            {
                Console.WriteLine($"Sending order confirmation for order {orderId} to {email}");
            }
            catch (Exception)
            {
                // Empty catch
            }
        }
    }
}
