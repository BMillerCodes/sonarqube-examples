using System;
using System.Collections.Generic;
using CsharpApp.Models;
using CsharpApp.Repositories;

namespace CsharpApp.Services
{
    public class UserService
    {
        private readonly UserRepository _userRepository;
        private readonly EmailService _emailService;

        public UserService()
        {
            _userRepository = new UserRepository();
            _emailService = new EmailService();
        }

        public User GetUserById(int id)
        {
            try
            {
                return _userRepository.GetById(id);
            }
            catch (Exception)
            {
                // Silently catch and return null - code smell: empty catch block
            }
            return null;
        }

        public List<User> GetAllUsers()
        {
            try
            {
                return _userRepository.GetAll();
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error retrieving users: {ex.Message}");
                return new List<User>();
            }
        }

        public bool CreateUser(string name, string email, int unusedParameter)
        {
            // Code smell: unused parameter
            if (string.IsNullOrEmpty(name) || string.IsNullOrEmpty(email))
            {
                return false;
            }

            try
            {
                var user = new User
                {
                    Name = name,
                    Email = email
                };
                
                _userRepository.Add(user);
                _emailService.SendWelcomeEmail(email, name);
                return true;
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
                return false;
            }
        }

        public bool UpdateUser(int id, string name, string email, bool isActive)
        {
            try
            {
                var user = _userRepository.GetById(id);
                if (user == null)
                    return false;

                user.Name = name;
                user.Email = email;
                user.IsActive = isActive;
                
                return _userRepository.Update(user);
            }
            catch (Exception)
            {
                // Empty catch - swallowing exception
                return false;
            }
        }

        public bool DeleteUser(int id, bool forceDelete = false)
        {
            // Code smell: unused parameter 'forceDelete'
            try
            {
                return _userRepository.Delete(id);
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
                return false;
            }
        }

        public int GetActiveUserCount()
        {
            try
            {
                var users = _userRepository.GetAll();
                int count = 0;
                foreach (var user in users)
                {
                    if (user.IsActive)
                        count++;
                }
                return count;
            }
            catch (Exception)
            {
                return 0;
            }
        }
    }
}
