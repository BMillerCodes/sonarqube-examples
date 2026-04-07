using System;
using Xunit;
using CsharpApp.Models;

namespace CsharpApp.Tests.Models
{
    public class UserTests
    {
        [Fact]
        public void User_DefaultConstructor_SetsDefaults()
        {
            var user = new User();
            
            Assert.True(user.IsActive);
            Assert.NotEqual(default, user.CreatedAt);
        }

        [Fact]
        public void User_ParameterizedConstructor_SetsProperties()
        {
            var user = new User(1, "John Doe", "john@example.com");
            
            Assert.Equal(1, user.Id);
            Assert.Equal("John Doe", user.Name);
            Assert.Equal("john@example.com", user.Email);
        }

        [Fact]
        public void ValidateEmail_ValidEmail_ReturnsTrue()
        {
            var user = new User { Email = "test@example.com" };
            
            Assert.True(user.ValidateEmail());
        }

        [Fact]
        public void ValidateEmail_InvalidEmail_ReturnsFalse()
        {
            var user = new User { Email = "invalid-email" };
            
            Assert.False(user.ValidateEmail());
        }

        [Fact]
        public void ValidateEmail_NullEmail_ReturnsFalse()
        {
            var user = new User { Email = null };
            
            Assert.False(user.ValidateEmail());
        }

        [Fact]
        public void GetDisplayName_ReturnsFormattedName()
        {
            var user = new User { Name = "John", Email = "john@example.com" };
            
            Assert.Equal("John (john@example.com)", user.GetDisplayName());
        }
    }
}
