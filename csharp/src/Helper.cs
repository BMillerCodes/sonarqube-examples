using System;

public static class Helper
{
    public static string FormatMessage(string message) => $"[INFO] {message}";

    public static bool IsValid(int value) => value >= 0 && value <= 100;

    // Additional helper methods with code smells
    
    public static bool ValidateInput(string input, bool strictMode)
    {
        // Code smell: strictMode is never used in the implementation
        if (string.IsNullOrEmpty(input))
            return false;
        return true;
    }

    public static int ProcessData(string data, bool useCache, bool enableLogging)
    {
        // Code smell: useCache and enableLogging are never used
        if (string.IsNullOrEmpty(data))
            return 0;
        return data.Length;
    }

    public static void ExecuteOperation(string operationType, bool asyncMode)
    {
        // Code smell: asyncMode parameter is never used
        try
        {
            Console.WriteLine($"Executing {operationType}");
        }
        catch (Exception)
        {
            // Empty catch block - code smell
        }
    }

    public static string GetConfigValue(string key, bool required, string defaultValue)
    {
        // Code smell: required parameter is never used
        try
        {
            return Environment.GetEnvironmentVariable(key) ?? defaultValue;
        }
        catch (Exception)
        {
            return defaultValue;
        }
    }

    // Dead code - method is never called
    private static bool InternalValidate(string input)
    {
        return !string.IsNullOrWhiteSpace(input);
    }

    // Another dead code method
    private static int CalculateHash(string input, bool useSecureHash)
    {
        // useSecureHash is never used
        return input.GetHashCode();
    }
}
