using System;
using System.IO;
using CsharpApp.Models;
using CsharpApp.Services;
using CsharpApp.Repositories;

class Program
{
    static void Main(string[] args)
    {
        Console.WriteLine("=== C# SonarQube Example Application ===");
        
        // Initialize services
        var userService = new UserService();
        var productService = new ProductService();
        var orderService = new OrderService();

        // Demonstrate basic functionality
        Console.WriteLine("\n--- User Operations ---");
        var users = userService.GetAllUsers();
        Console.WriteLine($"Found {users.Count} users");

        // Create a new user (demonstrates unused parameter)
        bool created = userService.CreateUser("Bob Wilson", "bob@example.com", 0);
        Console.WriteLine($"User created: {created}");

        // Product operations
        Console.WriteLine("\n--- Product Operations ---");
        var product = productService.GetProductById(1);
        if (product != null)
        {
            Console.WriteLine($"Product: {product.Name}, Price: ${product.Price}");
        }

        // Create product (demonstrates empty catch)
        bool productCreated = productService.CreateProduct("", "Test description", 19.99m, 10, "Test");
        Console.WriteLine($"Empty name product created: {productCreated}");

        // Order operations
        Console.WriteLine("\n--- Order Operations ---");
        var order = orderService.GetOrderById(999); // Non-existent
        Console.WriteLine($"Order lookup result: {order == null}");

        // Demonstrate file operations with empty catch
        Console.WriteLine("\n--- File Operations ---");
        try
        {
            string content = File.ReadAllText("nonexistent.txt");
            Console.WriteLine(content);
        }
        catch (Exception ex)
        {
            Console.WriteLine($"Error: {ex.Message}");
        }

        // More code smells demonstration
        Console.WriteLine("\n--- Code Smells Demonstration ---");
        
        // Dead code example
        int deadCode = CalculateSomething();
        Console.WriteLine($"Dead code result: {deadCode}");

        // Empty catch blocks
        try
        {
            int result = 10 / 0;
        }
        catch (Exception)
        {
            // Intentionally empty
        }

        // Unused parameters in method calls
        userService.DeleteUser(1, true);
        productService.GetProductsByCategory("Electronics", true);
        orderService.UpdateOrderStatus(1, "Completed", false);

        Console.WriteLine("\n=== Application Complete ===");
    }

    // Dead code - never called
    private static int CalculateSomething()
    {
        return 42;
    }

    // Unused private method
    private static bool ValidateInput(string input, bool strictMode)
    {
        // strictMode is never used
        if (string.IsNullOrEmpty(input))
            return false;
        return true;
    }
}

class Calculator
{
    public static int Add(int a, int b) => a + b;

    public static int Divide(int a, int b)
    {
        if (b == 0)
            throw new ArgumentException("Division by zero");
        return a / b;
    }
}
