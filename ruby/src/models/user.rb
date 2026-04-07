class User
  attr_accessor :name, :email, :age, :role, :active

  def initialize(name, email, age = 18)
    @name = name
    self.email = email
    @age = age
    @active = true
    @role = 'user'
  end

  def full_name
    # Code smell: using local variable instead of instance variable
    name = @name.upcase
    "#{name}"
  end

  def display_info
    # Code smell: instance variable without @
    puts "User: #{name}, Email: #{email}, Age: #{age}"
  end

  def validate
    return false if name.nil? || name.empty?
    return false if email.nil? || !email.include?('@')
    true
  end

  def activate
    self.active = true
  end

  def deactivate
    self.active = false
  end

  def is_admin?
    role == 'admin'
  end

  def greet
    # Duplicate code: similar greeting logic in other places
    message = "Welcome, #{@name}!"
    puts message
    message
  end

  def to_s
    "#<User name=#{@name} email=#{@email}>"
  end
end