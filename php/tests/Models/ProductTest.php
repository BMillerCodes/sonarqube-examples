<?php

namespace App\Tests\Models;

use PHPUnit\Framework\TestCase;
use App\Models\Product;

class ProductTest extends TestCase
{
    public function testProductCreation(): void
    {
        $product = new Product(1, 'Test Product', 99.99);
        
        $this->assertEquals(1, $product->getId());
        $this->assertEquals('Test Product', $product->getName());
        $this->assertEquals(99.99, $product->getPrice());
        $this->assertEquals(0, $product->getStock());
    }

    public function testProductSetters(): void
    {
        $product = new Product(1, 'Test Product', 99.99);
        
        $product->setName('Updated Product');
        $product->setPrice(149.99);
        $product->setStock(100);
        $product->setCategory('Electronics');
        $product->setDescription('A test product');
        
        $this->assertEquals('Updated Product', $product->getName());
        $this->assertEquals(149.99, $product->getPrice());
        $this->assertEquals(100, $product->getStock());
        $this->assertEquals('Electronics', $product->getCategory());
        $this->assertEquals('A test product', $product->getDescription());
    }

    public function testIsInStock(): void
    {
        $product = new Product(1, 'Test Product', 99.99);
        
        $this->assertFalse($product->isInStock());
        
        $product->setStock(10);
        $this->assertTrue($product->isInStock());
    }

    public function testReduceStock(): void
    {
        $product = new Product(1, 'Test Product', 99.99);
        $product->setStock(50);
        
        $product->reduceStock(10);
        $this->assertEquals(40, $product->getStock());
    }

    public function testReduceStockThrowsOnInsufficientStock(): void
    {
        $product = new Product(1, 'Test Product', 99.99);
        $product->setStock(5);
        
        $this->expectException(\InvalidArgumentException::class);
        $product->reduceStock(10);
    }

    public function testSetNegativePriceThrows(): void
    {
        $product = new Product(1, 'Test Product', 99.99);
        
        $this->expectException(\InvalidArgumentException::class);
        $product->setPrice(-10);
    }

    public function testProductToArray(): void
    {
        $product = new Product(1, 'Test Product', 99.99);
        $product->setCategory('Electronics');
        $product->setStock(10);
        
        $array = $product->toArray();
        
        $this->assertIsArray($array);
        $this->assertEquals(1, $array['id']);
        $this->assertEquals('Test Product', $array['name']);
        $this->assertEquals(99.99, $array['price']);
        $this->assertEquals(10, $array['stock']);
        $this->assertEquals('Electronics', $array['category']);
    }
}
