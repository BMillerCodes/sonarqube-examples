using System;
using System.Collections.Generic;
using CsharpApp.Models;
using CsharpApp.Repositories;

namespace CsharpApp.Services
{
    public class OrderService
    {
        private readonly OrderRepository _orderRepository;
        private readonly ProductRepository _productRepository;
        private readonly UserRepository _userRepository;
        private readonly EmailService _emailService;

        public OrderService()
        {
            _orderRepository = new OrderRepository();
            _productRepository = new ProductRepository();
            _userRepository = new UserRepository();
            _emailService = new EmailService();
        }

        public Order GetOrderById(int id)
        {
            try
            {
                return _orderRepository.GetById(id);
            }
            catch (Exception)
            {
                return null;
            }
        }

        public List<Order> GetOrdersByUserId(int userId, bool includePending = false)
        {
            // Code smell: unused parameter includePending
            try
            {
                return _orderRepository.GetByUserId(userId);
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
                return new List<Order>();
            }
        }

        public bool CreateOrder(int userId, List<OrderItem> items, int unusedParam1, int unusedParam2)
        {
            // Code smell: multiple unused parameters
            try
            {
                var user = _userRepository.GetById(userId);
                if (user == null)
                    return false;

                if (items == null || items.Count == 0)
                    return false;

                var order = new Order
                {
                    UserId = userId,
                    Items = items
                };
                order.CalculateTotal();

                bool result = _orderRepository.Add(order);
                
                if (result)
                {
                    _emailService.SendOrderConfirmation(user.Email, order.Id);
                }
                
                return result;
            }
            catch (Exception)
            {
                // Empty catch block - code smell
            }
            return false;
        }

        public bool UpdateOrderStatus(int orderId, string newStatus, bool sendNotification = false)
        {
            // Code smell: unused parameter sendNotification
            try
            {
                var order = _orderRepository.GetById(orderId);
                if (order == null)
                    return false;

                order.Status = newStatus;
                return _orderRepository.Update(order);
            }
            catch (Exception)
            {
            }
            return false;
        }

        public bool CancelOrder(int orderId, string reason, bool notifyUser = true)
        {
            // Code smell: unused parameter notifyUser
            try
            {
                var order = _orderRepository.GetById(orderId);
                if (order == null)
                    return false;

                order.Status = "Cancelled";
                return _orderRepository.Update(order);
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
                return false;
            }
        }

        public decimal CalculateOrderTotal(int orderId, bool applyTax = true, bool applyDiscount = false)
        {
            // Code smell: applyTax is never used in logic
            try
            {
                var order = _orderRepository.GetById(orderId);
                if (order == null)
                    return 0;

                decimal total = order.TotalAmount;
                
                // Note: applyTax parameter not used in calculation - code smell
                if (applyDiscount && total > 100)
                {
                    total = total * 0.9m; // 10% discount
                }
                
                return total;
            }
            catch (Exception)
            {
                return 0;
            }
        }
    }
}
