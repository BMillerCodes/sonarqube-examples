<?php

namespace App\Repositories;

use App\Models\Product;

class ProductRepository
{
    private array $products = [];

    public function save(Product $product): void
    {
        $this->products[$product->getId()] = $product;
    }

    public function findById(int $id): ?Product
    {
        return $this->products[$id] ?? null;
    }

    public function findAll(): array
    {
        return array_values($this->products);
    }

    public function findByCategory(string $category): array
    {
        $results = [];
        foreach ($this->products as $product) {
            if ($product->getCategory() === $category) {
                $results[] = $product;
            }
        }
        return $results;
    }

    public function update(Product $product): void
    {
        if (isset($this->products[$product->getId()])) {
            $this->products[$product->getId()] = $product;
        }
    }

    public function delete(int $id): void
    {
        unset($this->products[$id]);
    }

    public function count(): int
    {
        return count($this->products);
    }
}
