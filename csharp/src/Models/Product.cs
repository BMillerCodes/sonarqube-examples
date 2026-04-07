using System;

namespace CsharpApp.Models
{
    public class Product
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string Description { get; set; }
        public decimal Price { get; set; }
        public int Stock { get; set; }
        public string Category { get; set; }

        public Product()
        {
            Stock = 0;
        }

        public Product(int id, string name, decimal price) : this()
        {
            Id = id;
            Name = name;
            Price = price;
        }

        public bool IsInStock()
        {
            return Stock > 0;
        }

        public bool ApplyDiscount(decimal percentage)
        {
            if (percentage < 0 || percentage > 100)
                return false;
            
            Price = Price * (1 - percentage / 100);
            return true;
        }
    }
}
