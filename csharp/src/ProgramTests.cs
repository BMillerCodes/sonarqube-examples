using System;

class ProgramTests
{
    static void Main()
    {
        int result = Calculator.Add(2, 3);
        if (result != 5)
            throw new Exception($"Expected 5, got {result}");
        Console.WriteLine("All tests passed!");
    }
}