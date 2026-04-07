using System;
using Xunit;
using CsharpApp.Repositories;
using CsharpApp.Models;

namespace CsharpApp.Tests.Repositories
{
    public class UserRepositoryTests
    {
        private readonly UserRepository _repository;

        public UserRepositoryTests()
        {
            _repository = new UserRepository();
        }

        [Fact]
        public void GetById_ExistingUser_ReturnsUser()
        {
            var user = _repository.GetById(1);
            
            Assert.NotNull(user);
            Assert.Equal(1, user.Id);
        }

        [Fact]
        public void GetById_NonExistingUser_ReturnsNull()
        {
            var user = _repository.GetById(999);
            
            Assert.Null(user);
        }

        [Fact]
        public void GetAll_ReturnsAllUsers()
        {
            var users = _repository.GetAll();
            
            Assert.NotNull(users);
            Assert.True(users.Count > 0);
        }

        [Fact]
        public void Add_ValidUser_ReturnsTrue()
        {
            var user = new User { Name = "Test", Email = "test@example.com" };
            
            bool result = _repository.Add(user, true);
            
            Assert.True(result);
            Assert.True(user.Id > 0);
        }

        [Fact]
        public void Add_NullUser_ReturnsFalse()
        {
            bool result = _repository.Add(null, true);
            
            Assert.False(result);
        }

        [Fact]
        public void Update_ExistingUser_ReturnsTrue()
        {
            var user = _repository.GetById(1);
            user.Name = "Updated";
            
            bool result = _repository.Update(user, true);
            
            Assert.True(result);
        }

        [Fact]
        public void Update_NullUser_ReturnsFalse()
        {
            bool result = _repository.Update(null, true);
            
            Assert.False(result);
        }

        [Fact]
        public void Delete_ExistingUser_ReturnsTrue()
        {
            bool result = _repository.Delete(1, true);
            
            Assert.True(result);
        }

        [Fact]
        public void GetByEmail_ExistingEmail_ReturnsUser()
        {
            var user = _repository.GetByEmail("john@example.com", true);
            
            Assert.NotNull(user);
        }

        [Fact]
        public void SearchByName_ReturnsMatchingUsers()
        {
            var users = _repository.SearchByName("John", false);
            
            Assert.NotNull(users);
        }
    }
}
