class Product
  attr_accessor :name, :description, :price, :category, :stock

  def initialize(name, price, category = 'general')
    @name = name
    @description = ''
    @price = price
    @category = category
    @stock = 0
  end

  def in_stock?
    @stock > 0
  end

  def out_of_stock?
    @stock.zero?
  end

  def update_stock(quantity)
    # Code smell: instance variable without @
    stock = @stock + quantity
    @stock = stock
  end

  def reduce_stock(quantity)
    if @stock >= quantity
      @stock -= quantity
      true
    else
      false
    end
  end

  def display_info
    # Duplicate code: similar display in other models
    puts "Product: #{@name}, Price: #{@price}, Stock: #{@stock}"
  end

  def to_s
    "#<Product name=#{@name} price=#{@price}>"
  end

  def formatted_price
    "$#{'%.2f' % @price}"
  end

  def validate
    return false if @name.nil? || @name.empty?
    return false if @price < 0
    true
  end
end