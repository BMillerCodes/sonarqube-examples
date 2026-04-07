export interface Product {
    id: number;
    name: string;
    description: string;
    price: number;
    category: string;
    stock: number;
    sku: string;
}

export interface ProductCreate {
    name: string;
    description: string;
    price: number;
    category: string;
    stock: number;
    sku: string;
}

export interface ProductUpdate {
    name?: string;
    description?: string;
    price?: number;
    category?: string;
    stock?: number;
}

export interface ProductSearchParams {
    query?: string;
    category?: string;
    minPrice?: number;
    maxPrice?: number;
}

export interface ProductResponse {
    success: boolean;
    data: any;
    message: string;
    total?: number;
}
