<?php

namespace App\Controllers;

use App\Services\OrderService;
use App\Repositories\OrderRepository;
use App\Repositories\ProductRepository;

class OrderController
{
    private OrderService $orderService;

    public function __construct()
    {
        $orderRepository = new OrderRepository();
        $productRepository = new ProductRepository();
        $this->orderService = new OrderService($orderRepository, $productRepository);
    }

    public function create(array $data): array
    {
        $userId = $data['user_id'] ?? 0;
        
        // Unused variable
        $validationPassed = $this->validateOrderData($data);

        try {
            $order = $this->orderService->createOrder($userId);
            return ['success' => true, 'order' => $order->toArray()];
        } catch (\Exception $e) {
            // Empty catch block
        }

        return ['success' => false];
    }

    public function get(int $id): array
    {
        $order = $this->orderService->getOrder($id);
        
        if ($order === null) {
            return ['success' => false, 'message' => 'Order not found'];
        }

        return ['success' => true, 'order' => $order->toArray()];
    }

    public function addItem(array $data): array
    {
        $orderId = $data['order_id'] ?? 0;
        $productId = $data['product_id'] ?? 0;
        $quantity = $data['quantity'] ?? 1;

        try {
            $result = $this->orderService->addItemToOrder($orderId, $productId, $quantity);
            return ['success' => $result];
        } catch (\Exception $e) {
            // Empty catch
        }

        return ['success' => false];
    }

    public function removeItem(array $data): array
    {
        $orderId = $data['order_id'] ?? 0;
        $productId = $data['product_id'] ?? 0;

        try {
            $result = $this->orderService->removeItemFromOrder($orderId, $productId);
            return ['success' => $result];
        } catch (\Exception $e) {
            // Caught but not handled
        }

        return ['success' => false];
    }

    public function updateStatus(int $id, string $status): array
    {
        try {
            $result = $this->orderService->updateOrderStatus($id, $status);
            return ['success' => $result];
        } catch (\Exception $e) {
            // Swallowed
        }

        return ['success' => false];
    }

    public function cancel(int $id): array
    {
        try {
            $result = $this->orderService->cancelOrder($id);
            return ['success' => $result];
        } catch (\Exception $e) {
            // Empty catch
        }

        return ['success' => false];
    }

    public function complete(int $id): array
    {
        try {
            $result = $this->orderService->completeOrder($id);
            return ['success' => $result];
        } catch (\Exception $e) {
            // Empty catch
        }

        return ['success' => false];
    }

    public function listByUser(int $userId): array
    {
        $orders = $this->orderService->getOrdersByUser($userId);
        
        $result = [];
        foreach ($orders as $order) {
            $result[] = $order->toArray();
        }

        return ['success' => true, 'orders' => $result];
    }

    public function listAll(): array
    {
        $orders = $this->orderService->getAllOrders();
        
        $result = [];
        foreach ($orders as $order) {
            $result[] = $order->toArray();
        }

        return ['success' => true, 'orders' => $result];
    }

    public function delete(int $id): array
    {
        try {
            $result = $this->orderService->deleteOrder($id);
            return ['success' => $result];
        } catch (\Exception $e) {
            // Empty catch
        }

        return ['success' => false];
    }

    private function validateOrderData(array $data): bool
    {
        // Unused method
        return isset($data['user_id']) && $data['user_id'] > 0;
    }

    private function formatOrderOutput(Order $order): string
    {
        // Unused method
        return json_encode($order->toArray());
    }
}
