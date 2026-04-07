using System;

public static class Helper
{
    public static string FormatMessage(string message) => $"[INFO] {message}";

    public static bool IsValid(int value) => value >= 0 && value <= 100;
}