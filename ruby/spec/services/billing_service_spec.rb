require_relative '../src/services/billing_service'
require_relative '../src/services/user_service'
require_relative '../src/services/order_service'

describe BillingService do
  let(:user_service) { UserService.new }
  let(:order_service) { OrderService.new }
  let(:billing) { described_class.new }

  before do
    @user_service = user_service
    @order_service = order_service
  end

  describe '#process_payment' do
    it 'processes payment for valid user and order' do
      user = user_service.create_user('John', 'john@example.com')
      order = order_service.create_order(user)
      order.add_item('Widget', 1, 50.0)
      result = billing.process_payment(user.id, order.id, 50.0)
      expect(result[:success]).to be true
      expect(result[:transaction][:amount]).to eq(50.0)
    end

    it 'fails for non-existent user' do
      order = order_service.create_order(user_service.create_user('John', 'john@example.com'))
      result = billing.process_payment(9999, order.id, 50.0)
      expect(result[:success]).to be false
      expect(result[:error]).to include('User not found')
    end

    it 'fails for non-existent order' do
      user = user_service.create_user('John', 'john@example.com')
      result = billing.process_payment(user.id, 9999, 50.0)
      expect(result[:success]).to be false
      expect(result[:error]).to include('Order not found')
    end
  end

  describe '#refund_transaction' do
    it 'refunds a completed transaction' do
      user = user_service.create_user('John', 'john@example.com')
      order = order_service.create_order(user)
      order.add_item('Widget', 1, 50.0)
      payment = billing.process_payment(user.id, order.id, 50.0)
      refund = billing.refund_transaction(payment[:transaction][:id])
      expect(refund[:success]).to be true
      expect(refund[:transaction][:status]).to eq('refunded')
    end

    it 'fails for non-existent transaction' do
      result = billing.refund_transaction(9999)
      expect(result[:success]).to be false
    end
  end

  describe '#get_transaction' do
    it 'finds transaction by id' do
      user = user_service.create_user('John', 'john@example.com')
      order = order_service.create_order(user)
      order.add_item('Widget', 1, 50.0)
      payment = billing.process_payment(user.id, order.id, 50.0)
      found = billing.get_transaction(payment[:transaction][:id])
      expect(found[:id]).to eq(payment[:transaction][:id])
    end
  end

  describe '#calculate_total_revenue' do
    it 'sums completed transaction amounts' do
      user = user_service.create_user('John', 'john@example.com')
      order1 = order_service.create_order(user)
      order1.add_item('Widget', 1, 30.0)
      order2 = order_service.create_order(user)
      order2.add_item('Widget', 1, 20.0)
      billing.process_payment(user.id, order1.id, 30.0)
      billing.process_payment(user.id, order2.id, 20.0)
      expect(billing.calculate_total_revenue).to eq(50.0)
    end
  end

  describe '#generate_invoice' do
    it 'generates invoice for user and order' do
      user = user_service.create_user('John', 'john@example.com')
      order = order_service.create_order(user)
      order.add_item('Widget', 2, 25.0)
      invoice = billing.generate_invoice(user.id, order.id)
      expect(invoice).not_to be_nil
      expect(invoice[:user]).to eq('John')
      expect(invoice[:order_total]).to eq(50.0)
    end

    it 'returns nil for non-existent user' do
      order = order_service.create_order(user_service.create_user('John', 'john@example.com'))
      invoice = billing.generate_invoice(9999, order.id)
      expect(invoice).to be_nil
    end
  end

  describe '#validate_invoice' do
    it 'returns true for valid invoice' do
      invoice = { user: 'John', order_total: 50.0 }
      expect(billing.validate_invoice(invoice)).to be true
    end

    it 'returns false for nil invoice' do
      expect(billing.validate_invoice(nil)).to be false
    end

    it 'returns false for invoice with nil user' do
      invoice = { user: nil, order_total: 50.0 }
      expect(billing.validate_invoice(invoice)).to be false
    end

    it 'returns false for invoice with negative total' do
      invoice = { user: 'John', order_total: -10.0 }
      expect(billing.validate_invoice(invoice)).to be false
    end
  end

  describe '#send_invoice' do
    it 'sends invoice and returns status' do
      invoice = { invoice_id: 'INV-123', user: 'john@example.com' }
      status = billing.send_invoice(invoice)
      expect(status).to eq('sent')
    end
  end
end