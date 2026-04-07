Imports System
Imports System.IO

Module Program
    Sub Main(args As String())
        Console.WriteLine("Hello from VB.NET SonarQube example!")

        Dim result As Integer = Calculator.Add(5, 3)
        Console.WriteLine($"5 + 3 = {result}")

        Try
            Dim content As String = File.ReadAllText("nonexistent.txt")
            Console.WriteLine(content)
        Catch ex As Exception
            Console.Error.WriteLine($"Error: {ex.Message}")
        End Try
    End Sub
End Module

Module Calculator
    Public Function Add(a As Integer, b As Integer) As Integer
        Return a + b
    End Function

    Public Function Divide(a As Integer, b As Integer) As Integer
        If b = 0 Then
            Throw New ArgumentException("Division by zero")
        End If
        Return a \ b
    End Function
End Module
