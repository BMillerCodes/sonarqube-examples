require_relative 'user_service'
require_relative 'order_service'
require_relative 'product_service'

class BillingService
  def initialize
    @user_service = UserService.new
    @order_service = OrderService.new
    @product_service = ProductService.new
    @transactions = []
    @transaction_id_counter = 1
  end

  def process_payment(user_id, order_id, amount)
    user = @user_service.find_user(user_id)
    order = @order_service.find_order(order_id)

    return { success: false, error: 'User not found' } if user.nil?
    return { success: false, error: 'Order not found' } if order.nil?

    transaction = {
      id: @transaction_id_counter,
      user_id: user_id,
      order_id: order_id,
      amount: amount,
      status: 'completed',
      timestamp: Time.now
    }

    @transactions << transaction
    @transaction_id_counter += 1
    { success: true, transaction: transaction }
  end

  def refund_transaction(transaction_id)
    transaction = @transactions.find { |t| t[:id] == transaction_id }
    return { success: false, error: 'Transaction not found' } if transaction.nil?

    transaction[:status] = 'refunded'
    { success: true, transaction: transaction }
  end

  def get_transaction(transaction_id)
    @transactions.find { |t| t[:id] == transaction_id }
  end

  def all_transactions
    @transactions.dup
  end

  def calculate_total_revenue
    @transactions
      .select { |t| t[:status] == 'completed' }
      .inject(0) { |sum, t| sum + t[:amount] }
  end

  def generate_invoice(user_id, order_id)
    user = @user_service.find_user(user_id)
    order = @order_service.find_order(order_id)

    return nil if user.nil? || order.nil?

    {
      invoice_id: "INV-#{order_id}",
      user: user.name,
      order_total: order.total,
      items: order.items,
      status: 'generated'
    }
  end

  def validate_invoice(invoice)
    # Duplicate code: similar validation patterns
    return false if invoice.nil?
    return false if invoice[:user].nil? || invoice[:user].strip.empty?
    return false if invoice[:order_total].nil? || invoice[:order_total] < 0
    true
  end

  def send_invoice(invoice)
    # Code smell: instance variable without @
    email_status = 'sent'
    puts "Invoice #{invoice[:invoice_id]} sent to #{invoice[:user]}"
    email_status
  end
end