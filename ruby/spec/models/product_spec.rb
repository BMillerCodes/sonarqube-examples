require_relative '../src/models/product'

describe Product do
  describe '#initialize' do
    it 'creates a product with name and price' do
      product = Product.new('Widget', 19.99)
      expect(product.name).to eq('Widget')
      expect(product.price).to eq(19.99)
    end

    it 'sets default category to general' do
      product = Product.new('Widget', 10.0)
      expect(product.category).to eq('general')
    end

    it 'sets stock to 0 by default' do
      product = Product.new('Widget', 10.0)
      expect(product.stock).to eq(0)
    end
  end

  describe '#in_stock?' do
    it 'returns true when stock > 0' do
      product = Product.new('Widget', 10.0)
      product.update_stock(5)
      expect(product.in_stock?).to be true
    end

    it 'returns false when stock is 0' do
      product = Product.new('Widget', 10.0)
      expect(product.in_stock?).to be false
    end
  end

  describe '#out_of_stock?' do
    it 'returns true when stock is 0' do
      product = Product.new('Widget', 10.0)
      expect(product.out_of_stock?).to be true
    end
  end

  describe '#update_stock' do
    it 'increases stock by quantity' do
      product = Product.new('Widget', 10.0)
      product.update_stock(5)
      expect(product.stock).to eq(5)
    end
  end

  describe '#reduce_stock' do
    it 'reduces stock by quantity' do
      product = Product.new('Widget', 10.0)
      product.update_stock(10)
      product.reduce_stock(3)
      expect(product.stock).to eq(7)
    end

    it 'returns false if not enough stock' do
      product = Product.new('Widget', 10.0)
      product.update_stock(2)
      expect(product.reduce_stock(5)).to be false
    end
  end

  describe '#validate' do
    it 'returns true for valid product' do
      product = Product.new('Widget', 10.0)
      expect(product.validate).to be true
    end

    it 'returns false for nil name' do
      product = Product.new(nil, 10.0)
      expect(product.validate).to be false
    end

    it 'returns false for negative price' do
      product = Product.new('Widget', -5.0)
      expect(product.validate).to be false
    end
  end

  describe '#formatted_price' do
    it 'returns formatted price string' do
      product = Product.new('Widget', 10.5)
      expect(product.formatted_price).to eq('$10.50')
    end
  end
end