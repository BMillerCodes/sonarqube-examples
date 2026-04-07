using System;
using System.Collections.Generic;
using CsharpApp.Models;

namespace CsharpApp.Repositories
{
    public class ProductRepository
    {
        private readonly List<Product> _products;
        private int _nextId;

        public ProductRepository()
        {
            _products = new List<Product>();
            _nextId = 1;
            
            // Seed test data
            _products.Add(new Product(1, "Laptop", 999.99m) { Stock = 10, Category = "Electronics" });
            _products.Add(new Product(2, "Mouse", 29.99m) { Stock = 50, Category = "Electronics" });
            _products.Add(new Product(3, "Desk", 299.99m) { Stock = 5, Category = "Furniture" });
            _nextId = 4;
        }

        public Product GetById(int id)
        {
            try
            {
                foreach (var product in _products)
                {
                    if (product.Id == id)
                        return product;
                }
                return null;
            }
            catch (Exception)
            {
                return null;
            }
        }

        public List<Product> GetAll()
        {
            try
            {
                return new List<Product>(_products);
            }
            catch (Exception)
            {
                return new List<Product>();
            }
        }

        public List<Product> GetByCategory(string category)
        {
            try
            {
                var results = new List<Product>();
                foreach (var product in _products)
                {
                    if (product.Category == category)
                        results.Add(product);
                }
                return results;
            }
            catch (Exception)
            {
                return new List<Product>();
            }
        }

        public bool Add(Product product, bool validatePrice = true)
        {
            // Code smell: unused parameter validatePrice
            try
            {
                if (product == null)
                    return false;

                product.Id = _nextId++;
                _products.Add(product);
                return true;
            }
            catch (Exception)
            {
                return false;
            }
        }

        public bool Update(Product product, bool updateStock = true)
        {
            // Code smell: unused parameter updateStock
            try
            {
                if (product == null)
                    return false;

                for (int i = 0; i < _products.Count; i++)
                {
                    if (_products[i].Id == product.Id)
                    {
                        _products[i] = product;
                        return true;
                    }
                }
                return false;
            }
            catch (Exception)
            {
                return false;
            }
        }

        public bool Delete(int id, bool forceDelete = false)
        {
            // Code smell: unused parameter forceDelete
            try
            {
                for (int i = 0; i < _products.Count; i++)
                {
                    if (_products[i].Id == id)
                    {
                        _products.RemoveAt(i);
                        return true;
                    }
                }
                return false;
            }
            catch (Exception)
            {
                return false;
            }
        }

        public List<Product> GetLowStockProducts(int threshold = 10, bool includeOutOfStock = true)
        {
            // Code smell: includeOutOfStock is never used in implementation
            try
            {
                var results = new List<Product>();
                foreach (var product in _products)
                {
                    if (product.Stock <= threshold)
                        results.Add(product);
                }
                return results;
            }
            catch (Exception)
            {
                return new List<Product>();
            }
        }
    }
}
