require_relative '../models/product'

class ProductService
  def initialize
    @products = []
    @product_id_counter = 1
  end

  def create_product(name, price, category = 'general')
    product = Product.new(name, price, category)
    @products << product
    product
  end

  def find_product(id)
    @products.find { |p| p.id == id }
  end

  def find_by_category(category)
    @products.select { |p| p.category == category }
  end

  def all_products
    @products.dup
  end

  def update_product(id, attributes)
    product = find_product(id)
    return nil unless product

    product.name = attributes[:name] if attributes[:name]
    product.price = attributes[:price] if attributes[:price]
    product.category = attributes[:category] if attributes[:category]
    product
  end

  def delete_product(id)
    @products.delete_if { |p| p.id == id }
  end

  def update_stock(id, quantity)
    product = find_product(id)
    return nil unless product
    product.update_stock(quantity)
    product
  end

  def products_in_stock
    @products.select(&:in_stock?)
  end

  def out_of_stock_products
    @products.select(&:out_of_stock?)
  end

  def search_by_name(name)
    @products.select { |p| p.name.downcase.include?(name.downcase) }
  end

  def average_price
    return 0 if @products.empty?
    @products.inject(0) { |sum, p| sum + p.price } / @products.length
  end

  def validate_product(name, price)
    # Duplicate code: similar validation as in other services
    return false if name.nil? || name.strip.empty?
    return false if price.nil? || price < 0
    true
  end
end