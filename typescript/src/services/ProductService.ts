import { Product, ProductCreate, ProductUpdate, ProductSearchParams, ProductResponse } from '../interfaces/product';

export class ProductService {
    private products: Product[] = [];
    private idCounter: number = 1;

    create(data: ProductCreate): ProductResponse {
        const product: Product = {
            id: this.idCounter++,
            name: data.name,
            description: data.description,
            price: data.price,
            category: data.category,
            stock: data.stock,
            sku: data.sku
        };
        
        this.products.push(product);
        
        return {
            success: true,
            data: product,
            message: 'Product created successfully'
        };
    }

    findAll(): ProductResponse {
        return {
            success: true,
            data: this.products,
            message: 'Products retrieved successfully',
            total: this.products.length
        };
    }

    findById(id: number): ProductResponse {
        const product = this.products.find(p => p.id === id);
        
        return {
            success: !!product,
            data: product,
            message: product ? 'Product found' : 'Product not found'
        };
    }

    update(id: number, data: ProductUpdate): ProductResponse {
        const productIndex = this.products.findIndex(p => p.id === id);
        
        if (productIndex === -1) {
            return {
                success: false,
                data: null,
                message: 'Product not found'
            };
        }
        
        const product = this.products[productIndex];
        
        if (data.name) product.name = data.name;
        if (data.description) product.description = data.description;
        if (data.price) product.price = data.price;
        if (data.category) product.category = data.category;
        if (data.stock !== undefined) product.stock = data.stock;
        
        return {
            success: true,
            data: product,
            message: 'Product updated successfully'
        };
    }

    delete(id: number): ProductResponse {
        const productIndex = this.products.findIndex(p => p.id === id);
        
        if (productIndex === -1) {
            return {
                success: false,
                data: null,
                message: 'Product not found'
            };
        }
        
        const deletedProduct = this.products.splice(productIndex, 1)[0];
        
        return {
            success: true,
            data: deletedProduct,
            message: 'Product deleted successfully'
        };
    }

    search(params: ProductSearchParams): ProductResponse {
        let result = this.products;
        
        if (params.query) {
            const query = params.query.toLowerCase();
            result = result.filter(p => 
                p.name.toLowerCase().includes(query) || 
                p.description.toLowerCase().includes(query) ||
                p.sku.toLowerCase().includes(query)
            );
        }
        
        if (params.category) {
            result = result.filter(p => p.category === params.category);
        }
        
        if (params.minPrice !== undefined) {
            result = result.filter(p => p.price >= params.minPrice);
        }
        
        if (params.maxPrice !== undefined) {
            result = result.filter(p => p.price <= params.maxPrice);
        }
        
        return {
            success: true,
            data: result,
            message: `${result.length} products found`,
            total: result.length
        };
    }

    findByCategory(category: string): ProductResponse {
        const products = this.products.filter(p => p.category === category);
        
        return {
            success: true,
            data: products,
            message: `${products.length} products found in category ${category}`,
            total: products.length
        };
    }

    updateStock(id: number, quantity: number): ProductResponse {
        const product = this.products.find(p => p.id === id);
        
        if (!product) {
            return {
                success: false,
                data: null,
                message: 'Product not found'
            };
        }
        
        product.stock += quantity;
        
        if (product.stock < 0) {
            product.stock = 0;
        }
        
        return {
            success: true,
            data: product,
            message: `Stock updated. New stock: ${product.stock}`
        };
    }

    getProductsByPriceRange(min: number, max: number): ProductResponse {
        const products = this.products.filter(p => p.price >= min && p.price <= max);
        
        return {
            success: true,
            data: products,
            message: `${products.length} products found in price range ${min} - ${max}`,
            total: products.length
        };
    }

    processProductData(products: any[], options: any): any[] {
        let result = products;
        
        if (options.category) {
            result = result.filter(p => p.category === options.category);
        }
        
        if (options.minPrice) {
            result = result.filter(p => p.price >= options.minPrice);
        }
        
        if (options.maxPrice) {
            result = result.filter(p => p.price <= options.maxPrice);
        }
        
        if (options.inStock) {
            result = result.filter(p => p.stock > 0);
        }
        
        if (options.sortBy) {
            result = result.sort((a, b) => {
                if (options.sortOrder === 'desc') {
                    return b[options.sortBy] - a[options.sortBy];
                }
                return a[options.sortBy] - b[options.sortBy];
            });
        }
        
        if (options.limit) {
            result = result.slice(0, options.limit);
        }
        
        return result;
    }

    validateProductData(data: any): boolean {
        if (!data.name || data.name.length === 0) return false;
        if (!data.price || data.price < 0) return false;
        if (!data.category) return false;
        if (data.stock === undefined || data.stock < 0) return false;
        if (!data.sku) return false;
        return true;
    }
}
