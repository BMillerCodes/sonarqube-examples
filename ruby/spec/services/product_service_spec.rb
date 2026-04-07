require_relative '../src/services/product_service'

describe ProductService do
  let(:service) { ProductService.new }

  describe '#create_product' do
    it 'creates a product with name and price' do
      product = service.create_product('Widget', 19.99, 'electronics')
      expect(product.name).to eq('Widget')
      expect(product.price).to eq(19.99)
      expect(product.category).to eq('electronics')
    end

    it 'uses default category when not provided' do
      product = service.create_product('Gadget', 29.99)
      expect(product.category).to eq('general')
    end
  end

  describe '#find_product' do
    it 'finds product by id' do
      product = service.create_product('Widget', 10.0)
      found = service.find_product(product.id)
      expect(found).to eq(product)
    end

    it 'returns nil for non-existent id' do
      found = service.find_product(9999)
      expect(found).to be_nil
    end
  end

  describe '#find_by_category' do
    it 'filters products by category' do
      service.create_product('Widget', 10.0, 'electronics')
      service.create_product('Gadget', 20.0, 'electronics')
      service.create_product('Tool', 30.0, 'tools')
      electronics = service.find_by_category('electronics')
      expect(electronics.length).to eq(2)
    end
  end

  describe '#update_product' do
    it 'updates product attributes' do
      product = service.create_product('Widget', 10.0)
      updated = service.update_product(product.id, { name: 'Super Widget', price: 15.0 })
      expect(updated.name).to eq('Super Widget')
      expect(updated.price).to eq(15.0)
    end
  end

  describe '#delete_product' do
    it 'deletes product by id' do
      product = service.create_product('Widget', 10.0)
      service.delete_product(product.id)
      expect(service.find_product(product.id)).to be_nil
    end
  end

  describe '#update_stock' do
    it 'updates product stock' do
      product = service.create_product('Widget', 10.0)
      result = service.update_stock(product.id, 50)
      expect(result.stock).to eq(50)
    end
  end

  describe '#products_in_stock' do
    it 'returns only products in stock' do
      p1 = service.create_product('Widget', 10.0)
      p2 = service.create_product('Gadget', 20.0)
      service.update_stock(p1.id, 10)
      in_stock = service.products_in_stock
      expect(in_stock.length).to eq(1)
    end
  end

  describe '#out_of_stock_products' do
    it 'returns products with zero stock' do
      p1 = service.create_product('Widget', 10.0)
      p2 = service.create_product('Gadget', 20.0)
      service.update_stock(p1.id, 5)
      out = service.out_of_stock_products
      expect(out.length).to eq(1)
      expect(out[0].name).to eq('Gadget')
    end
  end

  describe '#search_by_name' do
    it 'searches products by name (case insensitive)' do
      service.create_product('Blue Widget', 10.0)
      service.create_product('Red Widget', 15.0)
      service.create_product('Blue Gadget', 20.0)
      results = service.search_by_name('blue')
      expect(results.length).to eq(2)
    end
  end

  describe '#average_price' do
    it 'calculates average price of all products' do
      service.create_product('Widget1', 10.0)
      service.create_product('Widget2', 20.0)
      service.create_product('Widget3', 30.0)
      expect(service.average_price).to eq(20.0)
    end

    it 'returns 0 for empty product list' do
      expect(ProductService.new.average_price).to eq(0)
    end
  end

  describe '#validate_product' do
    it 'returns true for valid name and price' do
      expect(service.validate_product('Widget', 10.0)).to be true
    end

    it 'returns false for nil name' do
      expect(service.validate_product(nil, 10.0)).to be false
    end

    it 'returns false for empty name' do
      expect(service.validate_product('', 10.0)).to be false
    end

    it 'returns false for negative price' do
      expect(service.validate_product('Widget', -5.0)).to be false
    end

    it 'returns false for nil price' do
      expect(service.validate_product('Widget', nil)).to be false
    end
  end
end