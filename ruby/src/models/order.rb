class Order
  attr_accessor :user, :items, :status, :total

  def initialize(user)
    @user = user
    @items = []
    @status = 'pending'
    @total = 0.0
    # Code smell: instance variable without @
    created_at = Time.now
  end

  def add_item(product, quantity, price)
    item = {
      product: product,
      quantity: quantity,
      price: price
    }
    @items << item
    recalculate_total
  end

  def remove_item(product)
    @items.delete_if { |item| item[:product] == product }
    recalculate_total
  end

  def recalculate_total
    sum = 0
    @items.each do |item|
      sum += item[:price] * item[:quantity]
    end
    @total = sum
  end

  def calculate_discount(percent)
    @total * (percent / 100.0)
  end

  def apply_discount(percent)
    discount = calculate_discount(percent)
    @total -= discount
    discount
  end

  def complete
    @status = 'completed'
  end

  def cancel
    @status = 'cancelled'
  end

  def summary
    # Duplicate code: similar to other summary methods
    "Order: #{@status}, Total: #{@total}, Items: #{@items.length}"
  end

  def display
    puts summary
  end

  def to_s
    "#<Order user=#{@user.name} status=#{@status} total=#{@total}>"
  end
end