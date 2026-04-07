require_relative 'helpers'

module Calculator
  def self.add(a, b)
    a + b
  end

  def self.divide(a, b)
    raise ArgumentError, "Division by zero" if b.zero?
    a.to_f / b
  end
end

def main
  puts "Hello from Ruby SonarQube example!"

  result = Calculator.add(5, 3)
  puts "5 + 3 = #{result}"

  begin
    result = Calculator.divide(10, 0)
    puts "Result: #{result}"
  rescue ArgumentError => e
    puts "Error: #{e.message}"
  end
end

main
