Module ProgramTests
    Sub Main()
        Dim result As Integer = Calculator.Add(2, 3)
        If result <> 5 Then
            Throw New Exception($"Expected 5, got {result}")
        End If
        Console.WriteLine("All tests passed!")
    End Sub
End Module
