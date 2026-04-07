VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "CUser"
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False

'============================================
' User class for VB6 example
' Code smell: empty error handling, global variables
'============================================

Option Explicit

' Code smell: public variables (no encapsulation)
Public lngID As Long
Public strName As String
Public strEmail As String
Public blnActive As Boolean
Public dtCreated As Date

' Code smell: global variable for tracking instances
Public g_nInstanceCount As Long

Private Sub Class_Initialize()
    ' Code smell: no error handling
    lngID = 0
    strName = ""
    strEmail = ""
    blnActive = True
    dtCreated = Now
    g_nInstanceCount = g_nInstanceCount + 1
End Sub

Private Sub Class_Terminate()
    ' Code smell: no cleanup or logging
    g_nInstanceCount = g_nInstanceCount - 1
End Sub

Public Property Get ID() As Long
    ID = lngID
End Property

Public Property Let ID(Value As Long)
    ' Code smell: no validation
    lngID = Value
End Property

Public Property Get Name() As String
    Name = strName
End Property

Public Property Let Name(Value As String)
    ' Code smell: no validation for empty strings
    strName = Value
End Property

Public Property Get Email() As String
    Email = strEmail
End Property

Public Property Let Email(Value As String)
    ' Code smell: no email format validation
    strEmail = Value
End Property

Public Property Get IsActive() As Boolean
    IsActive = blnActive
End Property

Public Property Let IsActive(Value As Boolean)
    blnActive = Value
End Property

Public Sub Init(ai_lngID As Long, as_strName As String, as_strEmail As String)
    ' Code smell: no error handling
    lngID = ai_lngID
    strName = as_strName
    strEmail = as_strEmail
    blnActive = True
    dtCreated = Now
End Sub

Public Function Validate() As Boolean
    ' Code smell: simplistic validation
    If Len(strName) = 0 Then
        Validate = False
        Exit Function
    End If
    
    ' Code smell: no proper email format validation
    If InStr(strEmail, "@") = 0 Then
        Validate = False
        Exit Function
    End If
    
    Validate = True
End Function

Public Sub Deactivate()
    blnActive = False
End Sub

Public Function ToString() As String
    ToString = "User[ID=" & lngID & ", Name=" & strName & ", Email=" & strEmail & "]"
End Function

'============================================
' User collection class
' Code smell: using Variant instead of proper types
'============================================

Public Function GetAllUsers() As Collection
    ' Code smell: returning Nothing without error handling
    Set GetAllUsers = Nothing
End Function

Public Function FindByID(a_lngID As Long) As CUser
    On Error GoTo ErrorHandler
    ' Code smell: empty error handler
    Set FindByID = Nothing
    Exit Function
    
ErrorHandler:
    ' Code smell: empty error handler
    Set FindByID = Nothing
End Function

Public Function Delete(a_lngID As Long) As Boolean
    On Error GoTo ErrorHandler
    Delete = False
    Exit Function
    
ErrorHandler:
    ' Code smell: silent failure
    Delete = False
End Function
