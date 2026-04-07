require_relative 'helpers'
require_relative 'models/user'
require_relative 'models/order'
require_relative 'models/product'
require_relative 'services/user_service'
require_relative 'services/order_service'
require_relative 'services/product_service'
require_relative 'services/billing_service'

module App
  class Application
    def initialize
      @user_service = UserService.new
      @order_service = OrderService.new
      @product_service = ProductService.new
      @billing_service = BillingService.new
    end

    def run
      puts "=== Ruby SonarQube Demo Application ==="
      puts

      create_sample_data
      demonstrate_functionality
      run_billing_example
    end

    private

    def create_sample_data
      puts "Creating sample data..."
      @user = @user_service.create_user('Alice Johnson', 'alice@example.com', 28)
      @admin = @user_service.create_user('Bob Admin', 'admin@example.com', 35)
      @admin.role = 'admin'

      @product1 = @product_service.create_product('Wireless Mouse', 29.99, 'electronics')
      @product2 = @product_service.create_product('Mechanical Keyboard', 89.99, 'electronics')
      @product3 = @product_service.create_product('USB Hub', 19.99, 'electronics')

      @product_service.update_stock(@product1.id, 50)
      @product_service.update_stock(@product2.id, 25)
      @product_service.update_stock(@product3.id, 100)

      puts "Created #{@user_service.count} users"
      puts "Created #{@product_service.all_products.length} products"
      puts
    end

    def demonstrate_functionality
      puts "=== User Operations ==="
      puts "Active users: #{@user_service.list_active_users.length}"
      puts "Admin users: #{@user_service.list_admin_users.length}"
      puts

      puts "=== Product Operations ==="
      @product_service.all_products.each do |p|
        puts "  - #{p.name}: #{p.formatted_price} (#{p.stock} in stock)"
      end
      puts "Average product price: $#{'%.2f' % @product_service.average_price}"
      puts

      puts "=== Order Operations ==="
      order = @order_service.create_order(@user)
      @order_service.add_item_to_order(order.id, @product1.name, 2, @product1.price)
      @order_service.add_item_to_order(order.id, @product2.name, 1, @product2.price)
      puts "Created order #{order.id} with total: $#{'%.2f' % order.total}"

      @order_service.apply_discount(order.id, 10)
      puts "After 10% discount: $#{'%.2f' % order.total}"
      puts

      @order_service.complete_order(order.id)
      puts "Order status: #{order.status}"
      puts
    end

    def run_billing_example
      puts "=== Billing Operations ==="
      user = @user_service.create_user('Charlie', 'charlie@example.com')
      order = @order_service.create_order(user)
      @order_service.add_item_to_order(order.id, 'Widget', 1, 100.0)

      payment = @billing_service.process_payment(user.id, order.id, 100.0)
      if payment[:success]
        puts "Payment processed successfully! Transaction ID: #{payment[:transaction][:id]}"
      end

      invoice = @billing_service.generate_invoice(user.id, order.id)
      puts "Invoice generated: #{invoice[:invoice_id]}"
      @billing_service.send_invoice(invoice)
      puts
    end
  end
end

App::Application.new.run