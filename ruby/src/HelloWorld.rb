class HelloWorld
  # Code smell: class variable without @@
  count = 0

  def initialize
    @greeting = 'Hello, World!'
  end

  def say
    puts @greeting
  end

  def self.greeting
    # Code smell: instance variable without @
    message = 'Hello from class method!'
    puts message
    message
  end

  def format_output(text)
    # Duplicate code: similar formatting
    "[OUTPUT] #{text}"
  end

  def format_result(result)
    # Duplicate code: similar formatting
    "[RESULT] #{result}"
  end
end

if __FILE__ == $0
  hello = HelloWorld.new
  hello.say
  HelloWorld.greeting
end