using System;

namespace CsharpApp.Models
{
    public class User
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string Email { get; set; }
        public DateTime CreatedAt { get; set; }
        public bool IsActive { get; set; }

        public User()
        {
            CreatedAt = DateTime.Now;
            IsActive = true;
        }

        public User(int id, string name, string email) : this()
        {
            Id = id;
            Name = name;
            Email = email;
        }

        public bool ValidateEmail()
        {
            return Email != null && Email.Contains("@");
        }

        public string GetDisplayName()
        {
            return $"{Name} ({Email})";
        }
    }
}
