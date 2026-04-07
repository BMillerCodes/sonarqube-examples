using System;
using System.Collections.Generic;

namespace CsharpApp.Models
{
    public class Order
    {
        public int Id { get; set; }
        public int UserId { get; set; }
        public List<OrderItem> Items { get; set; }
        public decimal TotalAmount { get; set; }
        public DateTime OrderDate { get; set; }
        public string Status { get; set; }

        public Order()
        {
            Items = new List<OrderItem>();
            OrderDate = DateTime.Now;
            Status = "Pending";
        }

        public Order(int id, int userId) : this()
        {
            Id = id;
            UserId = userId;
        }

        public void CalculateTotal()
        {
            TotalAmount = 0;
            foreach (var item in Items)
            {
                TotalAmount += item.Price * item.Quantity;
            }
        }

        public bool AddItem(OrderItem item)
        {
            if (item == null)
                return false;
            
            Items.Add(item);
            CalculateTotal();
            return true;
        }
    }

    public class OrderItem
    {
        public int ProductId { get; set; }
        public string ProductName { get; set; }
        public decimal Price { get; set; }
        public int Quantity { get; set; }

        public OrderItem()
        {
            Quantity = 1;
        }

        public OrderItem(int productId, string productName, decimal price, int quantity)
        {
            ProductId = productId;
            ProductName = productName;
            Price = price;
            Quantity = quantity;
        }
    }
}
