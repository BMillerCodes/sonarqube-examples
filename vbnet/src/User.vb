' User model
' Code smell: empty catch blocks, unused parameters

Public Class User
    Private _id As Integer
    Private _username As String
    Private _email As String
    Private _isActive As Boolean
    Private _createdAt As DateTime

    Public Sub New()
        _createdAt = DateTime.Now
        _isActive = True
    End Sub

    Public Sub New(id As Integer, username As String, email As String)
        Me.New()
        _id = id
        _username = username
        _email = email
    End Sub

    Public Property Id As Integer
        Get
            Return _id
        End Get
        Set(value As Integer)
            _id = value
        End Set
    End Property

    Public Property Username As String
        Get
            Return _username
        End Get
        Set(value As String)
            _username = value
        End Set
    End Property

    Public Property Email As String
        Get
            Return _email
        End Get
        Set(value As String)
            _email = value
        End Set
    End Property

    Public Property IsActive As Boolean
        Get
            Return _isActive
        End Get
        Set(value As Boolean)
            _isActive = value
        End Set
    End Property

    Public ReadOnly Property CreatedAt As DateTime
        Get
            Return _createdAt
        End Get
    End Property

    Public Overrides Function ToString() As String
        Return String.Format("User[Id={0}, Username={1}, Email={2}]", _id, _username, _email)
    End Function
End Class

' User repository
Public Class UserRepository
    Private users As New List(Of User)()
    Private _nextId As Integer = 1

    Public Function Create(username As String, email As String) As User
        Dim user As New User(_nextId, username, email)
        users.Add(user)
        _nextId += 1
        Return user
    End Function

    Public Function FindById(id As Integer) As User
        Try
            For Each user In users
                If user.Id = id Then
                    Return user
                End If
            Next
            Return Nothing
        Catch ex As Exception
            ' Code smell: empty catch block
            Return Nothing
        End Try
    End Function

    Public Function FindAll() As List(Of User)
        Try
            Return users
        Catch ex As Exception
            ' Code smell: empty catch block
            Return New List(Of User)()
        End Try
    End Function

    Public Function Delete(id As Integer) As Boolean
        Try
            Dim user = FindById(id)
            If user IsNot Nothing Then
                users.Remove(user)
                Return True
            End If
            Return False
        Catch ex As Exception
            ' Code smell: empty catch block
            Return False
        End Try
    End Function
End Class

' User service
Public Class UserService
    Private _repository As UserRepository

    Public Sub New(repository As UserRepository)
        _repository = repository
    End Sub

    Public Function Register(username As String, email As String, forceCreate As Boolean) As User
        ' Code smell: unused parameter forceCreate
        If String.IsNullOrEmpty(username) Then
            Throw New ArgumentException("Username is required")
        End If

        If String.IsNullOrEmpty(email) Then
            Throw New ArgumentException("Email is required")
        End If

        Return _repository.Create(username, email)
    End Function

    Public Function Deactivate(id As Integer) As Boolean
        Dim user = _repository.FindById(id)
        If user Is Nothing Then
            Return False
        End If

        user.IsActive = False
        Return True
    End Function

    Public Function UpdateEmail(id As Integer, newEmail As String) As Boolean
        ' Code smell: unused parameter validateEmail
        Dim user = _repository.FindById(id)
        If user Is Nothing Then
            Return False
        End If

        user.Email = newEmail
        Return True
    End Function
End Class