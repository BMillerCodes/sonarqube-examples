<?php

namespace App\Tests\Services;

use PHPUnit\Framework\TestCase;
use App\Services\ProductService;
use App\Repositories\ProductRepository;

class ProductServiceTest extends TestCase
{
    private ProductService $productService;
    private ProductRepository $repository;

    protected function setUp(): void
    {
        $this->repository = new ProductRepository();
        $this->productService = new ProductService($this->repository);
    }

    public function testCreateProduct(): void
    {
        $product = $this->productService->createProduct('Test Product', 99.99, 'Electronics');
        
        $this->assertEquals('Test Product', $product->getName());
        $this->assertEquals(99.99, $product->getPrice());
        $this->assertEquals('Electronics', $product->getCategory());
    }

    public function testGetProduct(): void
    {
        $createdProduct = $this->productService->createProduct('Test Product', 99.99, 'Electronics');
        $retrievedProduct = $this->productService->getProduct($createdProduct->getId());
        
        $this->assertNotNull($retrievedProduct);
        $this->assertEquals($createdProduct->getId(), $retrievedProduct->getId());
    }

    public function testUpdateProductPrice(): void
    {
        $product = $this->productService->createProduct('Test Product', 99.99, 'Electronics');
        
        $updatedProduct = $this->productService->updateProductPrice($product->getId(), 149.99);
        
        $this->assertNotNull($updatedProduct);
        $this->assertEquals(149.99, $updatedProduct->getPrice());
    }

    public function testUpdateStock(): void
    {
        $product = $this->productService->createProduct('Test Product', 99.99, 'Electronics');
        
        $result = $this->productService->updateStock($product->getId(), 50);
        
        $this->assertTrue($result);
        $updatedProduct = $this->productService->getProduct($product->getId());
        $this->assertEquals(50, $updatedProduct->getStock());
    }

    public function testPurchaseProduct(): void
    {
        $product = $this->productService->createProduct('Test Product', 99.99, 'Electronics');
        $this->productService->updateStock($product->getId(), 50);
        
        $result = $this->productService->purchaseProduct($product->getId(), 10);
        
        $this->assertTrue($result);
        $updatedProduct = $this->productService->getProduct($product->getId());
        $this->assertEquals(40, $updatedProduct->getStock());
    }

    public function testGetProductsByCategory(): void
    {
        $this->productService->createProduct('Product 1', 99.99, 'Electronics');
        $this->productService->createProduct('Product 2', 49.99, 'Electronics');
        $this->productService->createProduct('Product 3', 29.99, 'Clothing');
        
        $electronics = $this->productService->getProductsByCategory('Electronics');
        
        $this->assertCount(2, $electronics);
    }

    public function testGetLowStockProducts(): void
    {
        $product1 = $this->productService->createProduct('Product 1', 99.99, 'Electronics');
        $this->productService->updateStock($product1->getId(), 5);
        
        $product2 = $this->productService->createProduct('Product 2', 49.99, 'Electronics');
        $this->productService->updateStock($product2->getId(), 50);
        
        $lowStock = $this->productService->getLowStockProducts(10);
        
        $this->assertCount(1, $lowStock);
    }

    public function testGetTotalInventoryValue(): void
    {
        $product1 = $this->productService->createProduct('Product 1', 100.00, 'Electronics');
        $this->productService->updateStock($product1->getId(), 10);
        
        $product2 = $this->productService->createProduct('Product 2', 50.00, 'Electronics');
        $this->productService->updateStock($product2->getId(), 20);
        
        $totalValue = $this->productService->getTotalInventoryValue();
        
        $this->assertEquals(2000.00, $totalValue);
    }

    public function testCalculateTotalPrice(): void
    {
        $product1 = $this->productService->createProduct('Product 1', 100.00, 'Electronics');
        $product2 = $this->productService->createProduct('Product 2', 50.00, 'Electronics');
        
        $total = $this->productService->calculateTotalPrice([$product1->getId(), $product2->getId()]);
        
        $this->assertEquals(150.00, $total);
    }
}
