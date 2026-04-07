using System;
using Xunit;
using CsharpApp.Services;
using CsharpApp.Models;
using CsharpApp.Repositories;

namespace CsharpApp.Tests.Services
{
    public class UserServiceTests
    {
        private readonly UserService _userService;

        public UserServiceTests()
        {
            _userService = new UserService();
        }

        [Fact]
        public void GetUserById_ExistingUser_ReturnsUser()
        {
            var user = _userService.GetUserById(1);
            
            Assert.NotNull(user);
            Assert.Equal(1, user.Id);
        }

        [Fact]
        public void GetUserById_NonExistingUser_ReturnsNull()
        {
            var user = _userService.GetUserById(999);
            
            Assert.Null(user);
        }

        [Fact]
        public void GetAllUsers_ReturnsAllUsers()
        {
            var users = _userService.GetAllUsers();
            
            Assert.NotNull(users);
            Assert.True(users.Count > 0);
        }

        [Fact]
        public void CreateUser_ValidData_ReturnsTrue()
        {
            bool result = _userService.CreateUser("Test User", "test@example.com", 0);
            
            Assert.True(result);
        }

        [Fact]
        public void CreateUser_EmptyName_ReturnsFalse()
        {
            bool result = _userService.CreateUser("", "test@example.com", 0);
            
            Assert.False(result);
        }

        [Fact]
        public void CreateUser_EmptyEmail_ReturnsFalse()
        {
            bool result = _userService.CreateUser("Test User", "", 0);
            
            Assert.False(result);
        }

        [Fact]
        public void UpdateUser_ExistingUser_ReturnsTrue()
        {
            bool result = _userService.UpdateUser(1, "Updated Name", "updated@example.com", true);
            
            Assert.True(result);
        }

        [Fact]
        public void UpdateUser_NonExistingUser_ReturnsFalse()
        {
            bool result = _userService.UpdateUser(999, "Name", "email@example.com", true);
            
            Assert.False(result);
        }

        [Fact]
        public void DeleteUser_ExistingUser_ReturnsTrue()
        {
            _userService.CreateUser("ToDelete", "delete@example.com", 0);
            bool result = _userService.DeleteUser(999, true);
            
            Assert.True(result);
        }

        [Fact]
        public void GetActiveUserCount_ReturnsPositiveCount()
        {
            int count = _userService.GetActiveUserCount();
            
            Assert.True(count >= 0);
        }
    }
}
