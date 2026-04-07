Module Helper
    Public Function FormatMessage(message As String) As String
        Return $"[INFO] {message}"
    End Function

    Public Function IsValid(value As Integer) As Boolean
        Return value >= 0 AndAlso value <= 100
    End Function
End Module
