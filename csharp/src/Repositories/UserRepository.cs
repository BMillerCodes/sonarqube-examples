using System;
using System.Collections.Generic;
using CsharpApp.Models;

namespace CsharpApp.Repositories
{
    public class UserRepository
    {
        private readonly List<User> _users;
        private int _nextId;

        public UserRepository()
        {
            _users = new List<User>();
            _nextId = 1;
            
            // Seed some test data
            _users.Add(new User(1, "John Doe", "john@example.com"));
            _users.Add(new User(2, "Jane Smith", "jane@example.com"));
            _nextId = 3;
        }

        public User GetById(int id)
        {
            try
            {
                foreach (var user in _users)
                {
                    if (user.Id == id)
                        return user;
                }
                return null;
            }
            catch (Exception)
            {
                return null;
            }
        }

        public List<User> GetAll()
        {
            try
            {
                return new List<User>(_users);
            }
            catch (Exception)
            {
                return new List<User>();
            }
        }

        public bool Add(User user, bool skipValidation = false)
        {
            // Code smell: unused parameter skipValidation
            try
            {
                if (user == null)
                    return false;

                user.Id = _nextId++;
                _users.Add(user);
                return true;
            }
            catch (Exception)
            {
                return false;
            }
        }

        public bool Update(User user, bool validateEmail = true)
        {
            // Code smell: unused parameter validateEmail
            try
            {
                if (user == null)
                    return false;

                for (int i = 0; i < _users.Count; i++)
                {
                    if (_users[i].Id == user.Id)
                    {
                        _users[i] = user;
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
                for (int i = 0; i < _users.Count; i++)
                {
                    if (_users[i].Id == id)
                    {
                        _users.RemoveAt(i);
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

        public User GetByEmail(string email, bool includeInactive = false)
        {
            // Code smell: unused parameter includeInactive
            try
            {
                foreach (var user in _users)
                {
                    if (user.Email == email)
                        return user;
                }
                return null;
            }
            catch (Exception)
            {
                return null;
            }
        }

        public List<User> SearchByName(string name, bool exactMatch = false)
        {
            // Code smell: exactMatch is never used in implementation
            try
            {
                var results = new List<User>();
                foreach (var user in _users)
                {
                    if (user.Name.Contains(name, StringComparison.OrdinalIgnoreCase))
                    {
                        results.Add(user);
                    }
                }
                return results;
            }
            catch (Exception)
            {
                return new List<User>();
            }
        }
    }
}
