using System;
using System.IO;

class Program
{
    static void Main(string[] args)
    {
        Console.WriteLine("Hello from C# SonarQube example!");

        int result = Calculator.Add(5, 3);
        Console.WriteLine($"5 + 3 = {result}");

        try
        {
            string content = File.ReadAllText("nonexistent.txt");
            Console.WriteLine(content);
        }
        catch (Exception ex)
        {
            Console.Error.WriteLine($"Error: {ex.Message}");
        }
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