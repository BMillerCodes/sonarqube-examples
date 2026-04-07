import { ProductService } from '../services/ProductService';

describe('ProductService', () => {
    let productService: ProductService;

    beforeEach(() => {
        productService = new ProductService();
    });

    describe('create', () => {
        it('should create a new product', () => {
            const result = productService.create({
                name: 'Laptop',
                description: 'High-performance laptop',
                price: 999.99,
                category: 'electronics',
                stock: 50,
                sku: 'LAP-001'
            });

            expect(result.success).toBe(true);
            expect(result.data.name).toBe('Laptop');
            expect(result.data.price).toBe(999.99);
            expect(result.data.id).toBe(1);
        });

        it('should create multiple products with incrementing IDs', () => {
            productService.create({
                name: 'Product 1',
                description: 'Description 1',
                price: 10.00,
                category: 'category1',
                stock: 100,
                sku: 'PROD-001'
            });

            const result = productService.create({
                name: 'Product 2',
                description: 'Description 2',
                price: 20.00,
                category: 'category2',
                stock: 200,
                sku: 'PROD-002'
            });

            expect(result.data.id).toBe(2);
        });
    });

    describe('findAll', () => {
        it('should return empty array when no products exist', () => {
            const result = productService.findAll();
            expect(result.success).toBe(true);
            expect(result.data).toEqual([]);
        });

        it('should return all products with total count', () => {
            productService.create({
                name: 'Product 1',
                description: 'Description 1',
                price: 10.00,
                category: 'category1',
                stock: 100,
                sku: 'PROD-001'
            });

            productService.create({
                name: 'Product 2',
                description: 'Description 2',
                price: 20.00,
                category: 'category2',
                stock: 200,
                sku: 'PROD-002'
            });

            const result = productService.findAll();
            expect(result.data.length).toBe(2);
            expect(result.total).toBe(2);
        });
    });

    describe('findById', () => {
        it('should find product by id', () => {
            productService.create({
                name: 'Laptop',
                description: 'High-performance laptop',
                price: 999.99,
                category: 'electronics',
                stock: 50,
                sku: 'LAP-001'
            });

            const result = productService.findById(1);
            expect(result.success).toBe(true);
            expect(result.data.name).toBe('Laptop');
        });

        it('should return not found for non-existent id', () => {
            const result = productService.findById(999);
            expect(result.success).toBe(false);
            expect(result.data).toBeUndefined();
        });
    });

    describe('update', () => {
        it('should update product successfully', () => {
            productService.create({
                name: 'Laptop',
                description: 'High-performance laptop',
                price: 999.99,
                category: 'electronics',
                stock: 50,
                sku: 'LAP-001'
            });

            const result = productService.update(1, {
                price: 899.99,
                stock: 45
            });

            expect(result.success).toBe(true);
            expect(result.data.price).toBe(899.99);
            expect(result.data.stock).toBe(45);
        });

        it('should return not found for non-existent id', () => {
            const result = productService.update(999, { price: 100 });
            expect(result.success).toBe(false);
        });
    });

    describe('delete', () => {
        it('should delete product successfully', () => {
            productService.create({
                name: 'Laptop',
                description: 'High-performance laptop',
                price: 999.99,
                category: 'electronics',
                stock: 50,
                sku: 'LAP-001'
            });

            const result = productService.delete(1);
            expect(result.success).toBe(true);

            const findResult = productService.findById(1);
            expect(findResult.success).toBe(false);
        });

        it('should return not found for non-existent id', () => {
            const result = productService.delete(999);
            expect(result.success).toBe(false);
        });
    });

    describe('search', () => {
        it('should search by query string', () => {
            productService.create({
                name: 'Laptop',
                description: 'High-performance laptop',
                price: 999.99,
                category: 'electronics',
                stock: 50,
                sku: 'LAP-001'
            });

            productService.create({
                name: 'Mouse',
                description: 'Wireless mouse',
                price: 29.99,
                category: 'electronics',
                stock: 100,
                sku: 'MOU-001'
            });

            const result = productService.search({ query: 'laptop' });
            expect(result.data.length).toBe(1);
            expect(result.data[0].name).toBe('Laptop');
        });

        it('should filter by category', () => {
            productService.create({
                name: 'Laptop',
                description: 'High-performance laptop',
                price: 999.99,
                category: 'electronics',
                stock: 50,
                sku: 'LAP-001'
            });

            productService.create({
                name: 'T-Shirt',
                description: 'Cotton t-shirt',
                price: 19.99,
                category: 'clothing',
                stock: 200,
                sku: 'TSH-001'
            });

            const result = productService.search({ category: 'electronics' });
            expect(result.data.length).toBe(1);
            expect(result.data[0].name).toBe('Laptop');
        });

        it('should filter by price range', () => {
            productService.create({
                name: 'Product 1',
                description: 'Description 1',
                price: 100.00,
                category: 'category1',
                stock: 100,
                sku: 'PROD-001'
            });

            productService.create({
                name: 'Product 2',
                description: 'Description 2',
                price: 500.00,
                category: 'category2',
                stock: 200,
                sku: 'PROD-002'
            });

            productService.create({
                name: 'Product 3',
                description: 'Description 3',
                price: 1000.00,
                category: 'category3',
                stock: 300,
                sku: 'PROD-003'
            });

            const result = productService.search({ minPrice: 200, maxPrice: 750 });
            expect(result.data.length).toBe(1);
            expect(result.data[0].name).toBe('Product 2');
        });
    });

    describe('updateStock', () => {
        it('should update stock quantity', () => {
            productService.create({
                name: 'Laptop',
                description: 'High-performance laptop',
                price: 999.99,
                category: 'electronics',
                stock: 50,
                sku: 'LAP-001'
            });

            const result = productService.updateStock(1, 10);
            expect(result.success).toBe(true);
            expect(result.data.stock).toBe(60);
        });

        it('should handle negative stock updates', () => {
            productService.create({
                name: 'Laptop',
                description: 'High-performance laptop',
                price: 999.99,
                category: 'electronics',
                stock: 50,
                sku: 'LAP-001'
            });

            const result = productService.updateStock(1, -100);
            expect(result.success).toBe(true);
            expect(result.data.stock).toBe(0);
        });
    });

    describe('validateProductData', () => {
        it('should return true for valid data', () => {
            const valid = productService.validateProductData({
                name: 'Laptop',
                price: 999.99,
                category: 'electronics',
                stock: 50,
                sku: 'LAP-001'
            });
            expect(valid).toBe(true);
        });

        it('should return false for negative price', () => {
            const invalid = productService.validateProductData({
                name: 'Laptop',
                price: -100,
                category: 'electronics',
                stock: 50,
                sku: 'LAP-001'
            });
            expect(invalid).toBe(false);
        });

        it('should return false for missing name', () => {
            const invalid = productService.validateProductData({
                name: '',
                price: 999.99,
                category: 'electronics',
                stock: 50,
                sku: 'LAP-001'
            });
            expect(invalid).toBe(false);
        });
    });
});
