<?php

namespace App\Repositories;

use App\Models\Order;

class OrderRepository
{
    private array $orders = [];

    public function save(Order $order): void
    {
        $this->orders[$order->getId()] = $order;
    }

    public function findById(int $id): ?Order
    {
        return $this->orders[$id] ?? null;
    }

    public function findAll(): array
    {
        return array_values($this->orders);
    }

    public function findByUserId(int $userId): array
    {
        $results = [];
        foreach ($this->orders as $order) {
            if ($order->getUserId() === $userId) {
                $results[] = $order;
            }
        }
        return $results;
    }

    public function findByStatus(string $status): array
    {
        $results = [];
        foreach ($this->orders as $order) {
            if ($order->getStatus() === $status) {
                $results[] = $order;
            }
        }
        return $results;
    }

    public function update(Order $order): void
    {
        if (isset($this->orders[$order->getId()])) {
            $this->orders[$order->getId()] = $order;
        }
    }

    public function delete(int $id): void
    {
        unset($this->orders[$id]);
    }

    public function count(): int
    {
        return count($this->orders);
    }
}
