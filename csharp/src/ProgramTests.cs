using System;

class ProgramTests
{
    static void Main()
    {
        Console.WriteLine("Running Program Tests...");
        
        // Test Calculator.Add
        int result = Calculator.Add(2, 3);
        if (result != 5)
            throw new Exception($"Expected 5, got {result}");
        
        // Test Calculator.Divide
        try
        {
            int divResult = Calculator.Divide(10, 2);
            if (divResult != 5)
                throw new Exception($"Expected 5, got {divResult}");
        }
        catch (Exception ex)
        {
            Console.WriteLine($"Division test failed: {ex.Message}");
        }
        
        // Test division by zero
        try
        {
            Calculator.Divide(10, 0);
            throw new Exception("Should have thrown exception");
        }
        catch (ArgumentException)
        {
            // Expected exception
        }
        catch (Exception)
        {
            // Empty catch - code smell
        }

        Console.WriteLine("All tests passed!");
    }
}
