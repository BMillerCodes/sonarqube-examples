' Product model
' Code smell: empty catch blocks

Public Class Product
    Private _id As Integer
    Private _name As String
    Private _price As Decimal
    Private _stock As Integer
    Private _category As String

    Public Sub New()
    End Sub

    Public Sub New(id As Integer, name As String, price As Decimal)
        _id = id
        _name = name
        _price = price
    End Sub

    Public Property Id As Integer
        Get
            Return _id
        End Get
        Set(value As Integer)
            _id = value
        End Set
    End Property

    Public Property Name As String
        Get
            Return _name
        End Get
        Set(value As String)
            _name = value
        End Set
    End Property

    Public Property Price As Decimal
        Get
            Return _price
        End Get
        Set(value As Decimal)
            _price = value
        End Set
    End Property

    Public Property Stock As Integer
        Get
            Return _stock
        End Get
        Set(value As Integer)
            _stock = value
        End Set
    End Property

    Public Property Category As String
        Get
            Return _category
        End Get
        Set(value As String)
            _category = value
        End Set
    End Property

    Public Function IsInStock() As Boolean
        Return _stock > 0
    End Function

    Public Sub ApplyDiscount(percent As Decimal)
        ' Code smell: no validation of percent
        _price = _price * (1 - percent / 100)
    End Sub

    Public Overrides Function ToString() As String
        Return String.Format("Product[Id={0}, Name={1}, Price={2}]", _id, _name, _price)
    End Function
End Class

' Product repository
Public Class ProductRepository
    Private products As New List(Of Product)()
    Private _nextId As Integer = 1

    Public Function Create(name As String, price As Decimal, Optional category As String = "") As Product
        Try
            Dim product As New Product(_nextId, name, price)
            product.Category = category
            products.Add(product)
            _nextId += 1
            Return product
        Catch ex As Exception
            ' Code smell: empty catch block
            Return Nothing
        End Try
    End Function

    Public Function FindById(id As Integer) As Product
        Try
            For Each p In products
                If p.Id = id Then
                    Return p
                End If
            Next
            Return Nothing
        Catch ex As Exception
            ' Code smell: empty catch block
            Return Nothing
        End Try
    End Function

    Public Function FindByCategory(category As String) As List(Of Product)
        Try
            Dim result As New List(Of Product)()
            For Each p In products
                If p.Category = category Then
                    result.Add(p)
                End If
            Next
            Return result
        Catch ex As Exception
            ' Code smell: empty catch block
            Return New List(Of Product)()
        End Try
    End Function

    Public Function FindAll() As List(Of Product)
        Return products
    End Function

    Public Function UpdateStock(id As Integer, newStock As Integer) As Boolean
        Try
            Dim p = FindById(id)
            If p IsNot Nothing Then
                p.Stock = newStock
                Return True
            End If
            Return False
        Catch ex As Exception
            ' Code smell: empty catch block
            Return False
        End Try
    End Function
End Class

' Product service
Public Class ProductService
    Private _repository As ProductRepository

    Public Sub New(repository As ProductRepository)
        _repository = repository
    End Sub

    Public Function CreateProduct(name As String, price As Decimal, category As String, validatePrice As Boolean) As Product
        ' Code smell: unused parameter validatePrice
        If String.IsNullOrEmpty(name) Then
            Throw New ArgumentException("Name is required")
        End If

        If price < 0 Then
            Throw New ArgumentException("Price cannot be negative")
        End If

        Return _repository.Create(name, price, category)
    End Function

    Public Function ApplyDiscount(productId As Integer, discountPercent As Decimal) As Boolean
        Dim p = _repository.FindById(productId)
        If p Is Nothing Then
            Return False
        End If

        p.ApplyDiscount(discountPercent)
        Return True
    End Function

    Public Function GetProductsInCategory(category As String) As List(Of Product)
        Return _repository.FindByCategory(category)
    End Function
End Class