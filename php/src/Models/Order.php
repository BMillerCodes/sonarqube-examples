<?php

namespace App\Models;

class Order
{
    private int $id;
    private int $userId;
    private array $items;
    private float $totalAmount;
    private string $status;
    private string $createdAt;

    public function __construct(int $id, int $userId)
    {
        $this->id = $id;
        $this->userId = $userId;
        $this->items = [];
        $this->totalAmount = 0.0;
        $this->status = 'pending';
        $this->createdAt = date('Y-m-d H:i:s');
    }

    public function getId(): int
    {
        return $this->id;
    }

    public function getUserId(): int
    {
        return $this->userId;
    }

    public function getItems(): array
    {
        return $this->items;
    }

    public function addItem(Product $product, int $quantity): void
    {
        $this->items[] = [
            'product' => $product,
            'quantity' => $quantity,
            'subtotal' => $product->getPrice() * $quantity
        ];
        $this->calculateTotal();
    }

    public function removeItem(int $productId): bool
    {
        foreach ($this->items as $index => $item) {
            if ($item['product']->getId() === $productId) {
                unset($this->items[$index]);
                $this->items = array_values($this->items);
                $this->calculateTotal();
                return true;
            }
        }
        return false;
    }

    public function getTotalAmount(): float
    {
        return $this->totalAmount;
    }

    private function calculateTotal(): void
    {
        $this->totalAmount = 0.0;
        foreach ($this->items as $item) {
            $this->totalAmount += $item['subtotal'];
        }
    }

    public function getStatus(): string
    {
        return $this->status;
    }

    public function setStatus(string $status): void
    {
        $this->status = $status;
    }

    public function getCreatedAt(): string
    {
        return $this->createdAt;
    }

    public function toArray(): array
    {
        $itemsArray = [];
        foreach ($this->items as $item) {
            $itemsArray[] = [
                'product' => $item['product']->toArray(),
                'quantity' => $item['quantity'],
                'subtotal' => $item['subtotal']
            ];
        }

        return [
            'id' => $this->id,
            'user_id' => $this->userId,
            'items' => $itemsArray,
            'total_amount' => $this->totalAmount,
            'status' => $this->status,
            'created_at' => $this->createdAt,
        ];
    }
}
