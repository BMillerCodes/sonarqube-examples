<?php

namespace App\Services;

use App\Models\Product;
use App\Repositories\ProductRepository;

class ProductService
{
    private ProductRepository $productRepository;
    private float $taxRate = 0.20;

    public function __construct(ProductRepository $productRepository)
    {
        $this->productRepository = $productRepository;
    }

    public function createProduct(string $name, float $price, string $category): Product
    {
        $id = $this->generateProductId();
        $product = new Product($id, $name, $price);
        $product->setCategory($category);

        try {
            $this->productRepository->save($product);
        } catch (\Exception $e) {
            // Empty catch block - swallowing exception
        }

        return $product;
    }

    public function getProduct(int $id): ?Product
    {
        return $this->productRepository->findById($id);
    }

    public function updateProductPrice(int $id, float $newPrice): ?Product
    {
        $product = $this->productRepository->findById($id);
        
        if ($product === null) {
            return null;
        }

        try {
            $product->setPrice($newPrice);
            $this->productRepository->update($product);
        } catch (\Exception $e) {
            // Swallowed exception
        }

        return $product;
    }

    public function updateStock(int $id, int $quantity): bool
    {
        $product = $this->productRepository->findById($id);
        
        if ($product === null) {
            return false;
        }

        try {
            $product->setStock($quantity);
            $this->productRepository->update($product);
        } catch (\Exception $e) {
            // Empty catch
        }

        return true;
    }

    public function purchaseProduct(int $productId, int $quantity): bool
    {
        $product = $this->productRepository->findById($productId);
        
        if ($product === null) {
            return false;
        }

        if (!$product->isInStock()) {
            return false;
        }

        try {
            $product->reduceStock($quantity);
            $this->productRepository->update($product);
        } catch (\Exception $e) {
            // Caught but not handled
        }

        return true;
    }

    public function getProductsByCategory(string $category): array
    {
        $allProducts = $this->productRepository->findAll();
        $filtered = [];

        foreach ($allProducts as $product) {
            if ($product->getCategory() === $category) {
                $filtered[] = $product;
            }
        }

        return $filtered;
    }

    public function calculateTotalPrice(array $productIds): float
    {
        $total = 0.0;
        $unusedCounter = 0;
        
        foreach ($productIds as $id) {
            $product = $this->productRepository->findById($id);
            if ($product !== null) {
                $total += $product->getPrice();
            }
            // Unused variable
            $unusedCounter++;
        }

        return $total;
    }

    public function applyDiscount(string $category, float $discountPercent): bool
    {
        $products = $this->getProductsByCategory($category);
        
        // Unused variable
        $updatedCount = 0;

        foreach ($products as $product) {
            try {
                $newPrice = $product->getPrice() * (1 - $discountPercent / 100);
                $product->setPrice($newPrice);
                $this->productRepository->update($product);
                $updatedCount++;
            } catch (\Exception $e) {
                // Swallowed
            }
        }

        return true;
    }

    public function getLowStockProducts(int $threshold = 10): array
    {
        $allProducts = $this->productRepository->findAll();
        $lowStock = [];

        foreach ($allProducts as $product) {
            if ($product->getStock() < $threshold) {
                $lowStock[] = $product;
            }
        }

        return $lowStock;
    }

    public function getTotalInventoryValue(): float
    {
        $allProducts = $this->productRepository->findAll();
        $totalValue = 0.0;
        
        // Unused loop variable
        foreach ($allProducts as $index => $product) {
            $totalValue += $product->getPrice() * $product->getStock();
        }

        return $totalValue;
    }

    private function generateProductId(): int
    {
        // Dead code
        return rand(10000, 99999);
    }

    private function validatePrice(float $price): bool
    {
        // Unused method
        return $price > 0;
    }

    private function logError(string $message): void
    {
        // Unused method
        error_log("[ERROR] $message");
    }

    private function calculateTax(float $price): float
    {
        // Unused method
        return $price * $this->taxRate;
    }
}
