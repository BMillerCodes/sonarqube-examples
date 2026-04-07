<?php

namespace App\Services;

use App\Models\Order;
use App\Models\Product;
use App\Repositories\OrderRepository;
use App\Repositories\ProductRepository;

class OrderService
{
    private OrderRepository $orderRepository;
    private ProductRepository $productRepository;

    public function __construct(OrderRepository $orderRepository, ProductRepository $productRepository)
    {
        $this->orderRepository = $orderRepository;
        $this->productRepository = $productRepository;
    }

    public function createOrder(int $userId): Order
    {
        $id = $this->generateOrderId();
        $order = new Order($id, $userId);

        try {
            $this->orderRepository->save($order);
        } catch (\Exception $e) {
            // Empty catch block
        }

        return $order;
    }

    public function addItemToOrder(int $orderId, int $productId, int $quantity): bool
    {
        $order = $this->orderRepository->findById($orderId);
        
        if ($order === null) {
            return false;
        }

        $product = $this->productRepository->findById($productId);
        
        if ($product === null) {
            return false;
        }

        try {
            $order->addItem($product, $quantity);
            $this->orderRepository->update($order);
        } catch (\Exception $e) {
            // Empty catch
        }

        return true;
    }

    public function removeItemFromOrder(int $orderId, int $productId): bool
    {
        $order = $this->orderRepository->findById($orderId);
        
        if ($order === null) {
            return false;
        }

        try {
            $result = $order->removeItem($productId);
            if ($result) {
                $this->orderRepository->update($order);
            }
        } catch (\Exception $e) {
            // Swallowed
        }

        return true;
    }

    public function getOrder(int $id): ?Order
    {
        // Unused variable
        $cachedOrder = null;
        
        return $this->orderRepository->findById($id);
    }

    public function getOrdersByUser(int $userId): array
    {
        $allOrders = $this->orderRepository->findAll();
        $userOrders = [];

        foreach ($allOrders as $order) {
            if ($order->getUserId() === $userId) {
                $userOrders[] = $order;
            }
        }

        return $userOrders;
    }

    public function getAllOrders(): array
    {
        return $this->orderRepository->findAll();
    }

    public function updateOrderStatus(int $orderId, string $status): bool
    {
        $order = $this->orderRepository->findById($orderId);
        
        if ($order === null) {
            return false;
        }

        // Unused variable
        $previousStatus = $order->getStatus();

        try {
            $order->setStatus($status);
            $this->orderRepository->update($order);
        } catch (\Exception $e) {
            // Empty catch
        }

        return true;
    }

    public function cancelOrder(int $orderId): bool
    {
        return $this->updateOrderStatus($orderId, 'cancelled');
    }

    public function completeOrder(int $orderId): bool
    {
        return $this->updateOrderStatus($orderId, 'completed');
    }

    public function getTotalRevenue(): float
    {
        $allOrders = $this->orderRepository->findAll();
        $revenue = 0.0;
        
        // Unused loop variable
        foreach ($allOrders as $index => $order) {
            if ($order->getStatus() === 'completed') {
                $revenue += $order->getTotalAmount();
            }
        }

        return $revenue;
    }

    public function getOrderCountByStatus(string $status): int
    {
        $allOrders = $this->orderRepository->findAll();
        $count = 0;
        
        foreach ($allOrders as $order) {
            if ($order->getStatus() === $status) {
                $count++;
            }
        }

        return $count;
    }

    public function deleteOrder(int $orderId): bool
    {
        $order = $this->orderRepository->findById($orderId);
        
        if ($order === null) {
            return false;
        }

        try {
            $this->orderRepository->delete($orderId);
            return true;
        } catch (\Exception $e) {
            // Empty catch
        }

        return false;
    }

    private function generateOrderId(): int
    {
        // Dead code
        return time() + rand(100, 999);
    }

    private function validateOrder(Order $order): bool
    {
        // Unused method
        if (count($order->getItems()) === 0) {
            return false;
        }
        return $order->getTotalAmount() > 0;
    }

    private function calculateDiscount(float $amount, float $percent): float
    {
        // Unused method
        return $amount * (1 - $percent / 100);
    }

    private function logOrderAction(string $action, int $orderId): void
    {
        // Unused method
        error_log("[$action] Order ID: $orderId");
    }
}
