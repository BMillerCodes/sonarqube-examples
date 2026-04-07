require_relative '../src/services/order_service'
require_relative '../src/services/user_service'

describe OrderService do
  let(:user_service) { UserService.new }
  let(:service) { OrderService.new }

  describe '#create_order' do
    it 'creates an order for a user' do
      user = user_service.create_user('John', 'john@example.com')
      order = service.create_order(user)
      expect(order.user).to eq(user)
      expect(order.status).to eq('pending')
    end
  end

  describe '#add_item_to_order' do
    it 'adds item to order' do
      user = user_service.create_user('John', 'john@example.com')
      order = service.create_order(user)
      result = service.add_item_to_order(order.id, 'Widget', 2, 10.0)
      expect(result.items.length).to eq(1)
    end

    it 'returns nil for non-existent order' do
      result = service.add_item_to_order(9999, 'Widget', 1, 5.0)
      expect(result).to be_nil
    end
  end

  describe '#complete_order' do
    it 'completes an order' do
      user = user_service.create_user('John', 'john@example.com')
      order = service.create_order(user)
      service.add_item_to_order(order.id, 'Widget', 1, 10.0)
      service.complete_order(order.id)
      expect(order.status).to eq('completed')
    end
  end

  describe '#cancel_order' do
    it 'cancels an order' do
      user = user_service.create_user('John', 'john@example.com')
      order = service.create_order(user)
      service.cancel_order(order.id)
      expect(order.status).to eq('cancelled')
    end
  end

  describe '#apply_discount' do
    it 'applies discount to order' do
      user = user_service.create_user('John', 'john@example.com')
      order = service.create_order(user)
      service.add_item_to_order(order.id, 'Widget', 1, 100.0)
      service.apply_discount(order.id, 10)
      expect(order.total).to eq(90.0)
    end
  end

  describe '#orders_by_status' do
    it 'filters orders by status' do
      user = user_service.create_user('John', 'john@example.com')
      order1 = service.create_order(user)
      order2 = service.create_order(user)
      service.complete_order(order1.id)
      pending = service.orders_by_status('pending')
      expect(pending.length).to eq(1)
    end
  end

  describe '#total_revenue' do
    it 'calculates total revenue from all orders' do
      user = user_service.create_user('John', 'john@example.com')
      order1 = service.create_order(user)
      order2 = service.create_order(user)
      service.add_item_to_order(order1.id, 'Widget', 1, 50.0)
      service.add_item_to_order(order2.id, 'Widget', 1, 30.0)
      expect(service.total_revenue).to eq(80.0)
    end
  end

  describe '#validate_order' do
    it 'returns true for valid order with items' do
      user = user_service.create_user('John', 'john@example.com')
      order = service.create_order(user)
      service.add_item_to_order(order.id, 'Widget', 1, 10.0)
      expect(service.validate_order(order)).to be true
    end

    it 'returns false for nil order' do
      expect(service.validate_order(nil)).to be false
    end

    it 'returns false for order with no items' do
      user = user_service.create_user('John', 'john@example.com')
      order = service.create_order(user)
      expect(service.validate_order(order)).to be false
    end

    it 'returns false for order with negative total' do
      user = user_service.create_user('John', 'john@example.com')
      order = service.create_order(user)
      order.total = -10
      expect(service.validate_order(order)).to be false
    end
  end
end