'============================================
' Product class for VB6 example
' Code smell: empty catch equivalents, dead code
'============================================

VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "CProduct"
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False

Option Explicit

Public lngID As Long
Public strName As String
Public curPrice As Currency
Public lngStock As Long
Public strCategory As String

Private Sub Class_Initialize()
    lngID = 0
    strName = ""
    curPrice = 0
    lngStock = 0
    strCategory = ""
End Sub

Public Property Get ID() As Long
    ID = lngID
End Property

Public Property Let ID(Value As Long)
    lngID = Value
End Property

Public Property Get Name() As String
    Name = strName
End Property

Public Property Let Name(Value As String)
    strName = Value
End Property

Public Property Get Price() As Currency
    Price = curPrice
End Property

Public Property Let Price(Value As Currency)
    ' Code smell: no negative price check
    curPrice = Value
End Property

Public Property Get Stock() As Long
    Stock = lngStock
End Property

Public Property Let Stock(Value As Long)
    lngStock = Value
End Property

Public Property Get Category() As String
    Category = strCategory
End Property

Public Property Let Category(Value As String)
    strCategory = Value
End Property

Public Function Init(ai_lngID As Long, as_strName As String, acurPrice As Currency, as_strCategory As String) As Boolean
    On Error GoTo ErrorHandler
    lngID = ai_lngID
    strName = as_strName
    curPrice = acurPrice
    strCategory = as_strCategory
    lngStock = 0
    Init = True
    Exit Function
    
ErrorHandler:
    ' Code smell: empty error handler
    Init = False
End Function

Public Function IsInStock() As Boolean
    IsInStock = (lngStock > 0)
End Function

Public Sub ApplyDiscount(apercent As Double)
    ' Code smell: no validation of percent value
    ' Code smell: division by zero not checked
    curPrice = curPrice * (1 - apercent / 100)
End Sub

Public Function ToString() As String
    ToString = "Product[ID=" & lngID & ", Name=" & strName & ", Price=" & curPrice & "]"
End Function

'============================================
' Dead code - unused functions
'============================================

Public Sub UnusedMethod1()
    ' Code smell: dead code
    MsgBox "This method is never called"
End Sub

Public Function UnusedMethod2() As String
    ' Code smell: dead code
    UnusedMethod2 = "This function is never used"
End Function
