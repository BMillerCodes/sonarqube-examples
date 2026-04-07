require_relative '../src/models/order'
require_relative '../src/models/user'

describe Order do
  let(:user) { User.new('John Doe', 'john@example.com') }

  describe '#initialize' do
    it 'creates an order with pending status' do
      order = Order.new(user)
      expect(order.status).to eq('pending')
      expect(order.user).to eq(user)
      expect(order.items).to be_empty
    end
  end

  describe '#add_item' do
    it 'adds item to order' do
      order = Order.new(user)
      order.add_item('Widget', 2, 10.0)
      expect(order.items.length).to eq(1)
      expect(order.items[0][:product]).to eq('Widget')
    end

    it 'recalculates total when adding item' do
      order = Order.new(user)
      order.add_item('Widget', 2, 10.0)
      expect(order.total).to eq(20.0)
    end
  end

  describe '#remove_item' do
    it 'removes item from order' do
      order = Order.new(user)
      order.add_item('Widget', 2, 10.0)
      order.remove_item('Widget')
      expect(order.items).to be_empty
    end
  end

  describe '#calculate_discount' do
    it 'calculates correct discount percentage' do
      order = Order.new(user)
      order.add_item('Widget', 1, 100.0)
      expect(order.calculate_discount(10)).to eq(10.0)
    end
  end

  describe '#apply_discount' do
    it 'applies discount to total' do
      order = Order.new(user)
      order.add_item('Widget', 1, 100.0)
      order.apply_discount(10)
      expect(order.total).to eq(90.0)
    end
  end

  describe '#complete and #cancel' do
    it 'completes order' do
      order = Order.new(user)
      order.complete
      expect(order.status).to eq('completed')
    end

    it 'cancels order' do
      order = Order.new(user)
      order.cancel
      expect(order.status).to eq('cancelled')
    end
  end

  describe '#summary' do
    it 'returns order summary string' do
      order = Order.new(user)
      order.add_item('Widget', 2, 10.0)
      expect(order.summary).to include('pending')
      expect(order.summary).to include('20.0')
    end
  end
end