require_relative '../models/order'
require_relative '../models/product'

class OrderService
  def initialize
    @orders = []
    @order_id_counter = 1
  end

  def create_order(user)
    order = Order.new(user)
    @orders << order
    order
  end

  def find_order(id)
    @orders.find { |o| o.id == id }
  end

  def all_orders
    @orders.dup
  end

  def add_item_to_order(order_id, product, quantity, price)
    order = find_order(order_id)
    return nil unless order
    order.add_item(product, quantity, price)
    order
  end

  def remove_item_from_order(order_id, product)
    order = find_order(order_id)
    return nil unless order
    order.remove_item(product)
    order
  end

  def complete_order(order_id)
    order = find_order(order_id)
    return nil unless order
    order.complete
    order
  end

  def cancel_order(order_id)
    order = find_order(order_id)
    return nil unless order
    order.cancel
    order
  end

  def apply_discount(order_id, percent)
    order = find_order(order_id)
    return nil unless order
    order.apply_discount(percent)
    order
  end

  def order_summary(order_id)
    order = find_order(order_id)
    return nil unless order
    order.summary
  end

  def orders_by_status(status)
    @orders.select { |o| o.status == status }
  end

  def total_revenue
    @orders.inject(0) { |sum, o| sum + o.total }
  end

  def validate_order(order)
    # Duplicate code: similar validation logic
    return false if order.nil?
    return false if order.items.empty?
    return false if order.total < 0
    true
  end
end