using System;
using System.Collections.Generic;
using CsharpApp.Models;

namespace CsharpApp.Repositories
{
    public class OrderRepository
    {
        private readonly List<Order> _orders;
        private int _nextId;

        public OrderRepository()
        {
            _orders = new List<Order>();
            _nextId = 1;
        }

        public Order GetById(int id)
        {
            try
            {
                foreach (var order in _orders)
                {
                    if (order.Id == id)
                        return order;
                }
                return null;
            }
            catch (Exception)
            {
                return null;
            }
        }

        public List<Order> GetAll()
        {
            try
            {
                return new List<Order>(_orders);
            }
            catch (Exception)
            {
                return new List<Order>();
            }
        }

        public List<Order> GetByUserId(int userId, bool includePending = false)
        {
            // Code smell: unused parameter includePending
            try
            {
                var results = new List<Order>();
                foreach (var order in _orders)
                {
                    if (order.UserId == userId)
                        results.Add(order);
                }
                return results;
            }
            catch (Exception)
            {
                return new List<Order>();
            }
        }

        public List<Order> GetByStatus(string status, bool caseSensitive = true)
        {
            // Code smell: caseSensitive parameter is never used
            try
            {
                var results = new List<Order>();
                foreach (var order in _orders)
                {
                    if (order.Status == status)
                        results.Add(order);
                }
                return results;
            }
            catch (Exception)
            {
                return new List<Order>();
            }
        }

        public bool Add(Order order, bool validateTotal = true)
        {
            // Code smell: unused parameter validateTotal
            try
            {
                if (order == null)
                    return false;

                order.Id = _nextId++;
                _orders.Add(order);
                return true;
            }
            catch (Exception)
            {
                return false;
            }
        }

        public bool Update(Order order, bool recalculateTotal = false)
        {
            // Code smell: unused parameter recalculateTotal
            try
            {
                if (order == null)
                    return false;

                for (int i = 0; i < _orders.Count; i++)
                {
                    if (_orders[i].Id == order.Id)
                    {
                        _orders[i] = order;
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
                for (int i = 0; i < _orders.Count; i++)
                {
                    if (_orders[i].Id == id)
                    {
                        _orders.RemoveAt(i);
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
    }
}
