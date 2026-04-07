module Helper
  def self.multiply(a, b)
    a * b
  end

  def self.valid?(value)
    value >= 0 && value <= 100
  end

  def self.format(message)
    "[INFO] #{message}"
  end
end
