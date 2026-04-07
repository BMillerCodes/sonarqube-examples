<?php

namespace App\Tests\Models;

use PHPUnit\Framework\TestCase;
use App\Models\Order;
use App\Models\Product;

class OrderTest extends TestCase
{
    public function testOrderCreation(): void
    {
        $order = new Order(1, 100);
        
        $this->assertEquals(1, $order->getId());
        $this->assertEquals(100, $order->getUserId());
        $this->assertEquals('pending', $order->getStatus());
        $this->assertEquals(0.0, $order->getTotalAmount());
    }

    public function testAddItem(): void
    {
        $order = new Order(1, 100);
        $product = new Product(1, 'Test Product', 99.99);
        
        $order->addItem($product, 2);
        
        $this->assertCount(1, $order->getItems());
        $this->assertEquals(199.98, $order->getTotalAmount());
    }

    public function testAddMultipleItems(): void
    {
        $order = new Order(1, 100);
        $product1 = new Product(1, 'Product 1', 50.00);
        $product2 = new Product(2, 'Product 2', 30.00);
        
        $order->addItem($product1, 2);
        $order->addItem($product2, 3);
        
        $this->assertCount(2, $order->getItems());
        $this->assertEquals(190.00, $order->getTotalAmount());
    }

    public function testRemoveItem(): void
    {
        $order = new Order(1, 100);
        $product1 = new Product(1, 'Product 1', 50.00);
        $product2 = new Product(2, 'Product 2', 30.00);
        
        $order->addItem($product1, 2);
        $order->addItem($product2, 1);
        
        $result = $order->removeItem(1);
        
        $this->assertTrue($result);
        $this->assertCount(1, $order->getItems());
    }

    public function testRemoveNonExistentItem(): void
    {
        $order = new Order(1, 100);
        
        $result = $order->removeItem(999);
        
        $this->assertFalse($result);
    }

    public function testOrderStatus(): void
    {
        $order = new Order(1, 100);
        
        $this->assertEquals('pending', $order->getStatus());
        
        $order->setStatus('completed');
        $this->assertEquals('completed', $order->getStatus());
    }

    public function testOrderToArray(): void
    {
        $order = new Order(1, 100);
        $product = new Product(1, 'Test Product', 99.99);
        $order->addItem($product, 2);
        
        $array = $order->toArray();
        
        $this->assertIsArray($array);
        $this->assertEquals(1, $array['id']);
        $this->assertEquals(100, $array['user_id']);
        $this->assertEquals('pending', $array['status']);
        $this->assertEquals(199.98, $array['total_amount']);
        $this->assertCount(1, $array['items']);
    }
}
