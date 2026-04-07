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

  def self.process_data(data)
    # Code smell: instance variable without @
    result = data.upcase
    result = result.strip
    result
  end

  def self.calculate_total(items)
    # Code smell: local variable named same as method
    total = 0
    items.each do |item|
      total += item[:price] * item[:quantity]
    end
    total
  end

  def self.validate_email(email)
    # Code smell: duplicate validation logic
    return false if email.nil?
    return false if email.empty?
    return false unless email.include?('@')
    return false if email.start_with?('@')
    return false if email.end_with?('@')
    true
  end

  def self.format_date(date)
    # Duplicate code: similar formatting in other places
    "#{date.year}-#{date.month.to_s.rjust(2, '0')}-#{date.day.to_s.rjust(2, '0')}"
  end

  def self.format_timestamp(time)
    # Duplicate code: similar formatting patterns
    "#{time.year}-#{time.month.to_s.rjust(2, '0')}-#{time.day.to_s.rjust(2, '0')} #{time.hour.to_s.rjust(2, '0')}:#{time.min.to_s.rjust(2, '0')}"
  end
end