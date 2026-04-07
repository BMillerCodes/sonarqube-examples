Attribute VB_Name = "modMain"
'============================================
' Main module for VB6 example
' Code smell: global variables, no error handling
'============================================

Option Explicit

' Code smell: global variables
Public g_clsUser As CUser
Public g_clsProduct As CProduct
Public g_strLastError As String

Public Sub Main()
    Dim clsUser1 As CUser
    Dim clsUser2 As CUser
    Dim clsProduct As CProduct
    
    ' Code smell: no error handling for object creation
    Set clsUser1 = New CUser
    clsUser1.ID = 1
    clsUser1.Name = "johndoe"
    clsUser1.Email = "john@example.com"
    
    Set clsUser2 = New CUser
    clsUser2.ID = 2
    clsUser2.Name = "janedoe"
    clsUser2.Email = "jane@example.com"
    
    ' Code smell: no validation before use
    If clsUser1.Validate() Then
        Debug.Print "User 1 valid: " & clsUser1.ToString()
    End If
    
    ' Code smell: null reference not checked
    clsUser1.Deactivate
    
    Set clsProduct = New CProduct
    clsProduct.Init 1, "Widget", 29.99, "Electronics"
    
    If clsProduct.IsInStock() Then
        Debug.Print "Product in stock: " & clsProduct.ToString()
    End If
    
    ' Code smell: resources never released
    ' Should set objects to Nothing
    
    MsgBox "VB6 Example completed", vbInformation
End Sub

Public Function CreateUser(ai_lngID As Long, as_strName As String, as_strEmail As String) As CUser
    ' Code smell: no error handling
    Set CreateUser = New CUser
    CreateUser.ID = ai_lngID
    CreateUser.Name = as_strName
    CreateUser.Email = as_strEmail
End Function

Public Function GetUserByID(a_lngID As Long) As CUser
    ' Code smell: stub returning Nothing
    Set GetUserByID = Nothing
End Function

Public Sub UpdateUserEmail(a_lngID As Long, as_newEmail As String)
    ' Code smell: no implementation
    ' Code smell: global state modification without validation
    If Not (g_clsUser Is Nothing) Then
        g_clsUser.Email = as_newEmail
    End If
End Sub

Public Function DeleteUser(a_lngID As Long) As Boolean
    ' Code smell: stub with no implementation
    DeleteUser = False
End Function

Public Sub LogError(as_strMessage As String)
    ' Code smell: global variable for error tracking
    g_strLastError = as_strMessage
    ' Code smell: no logging mechanism
    Debug.Print "ERROR: " & as_strMessage
End Sub

Public Function ValidateEmail(as_strEmail As String) As Boolean
    ' Code smell: simplistic email validation
    If InStr(as_strEmail, "@") > 0 Then
        ValidateEmail = True
    Else
        ValidateEmail = False
    End If
End Function
