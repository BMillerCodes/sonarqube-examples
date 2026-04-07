<?php

// Test main file with code smells

require_once __DIR__ . '/../vendor/autoload.php';

use App\Models\User;
use App\Models\Product;
use App\Services\UserService;
use App\Repositories\UserRepository;

function runTests(): void
{
    $userService = new UserService(new UserRepository());
    
    // Test 1: Create user
    $user = $userService->createUser('John Doe', 'john@example.com');
    
    // Unused variable
    $unusedUser = $user;
    
    // Test 2: Get user
    $foundUser = $userService->getUser($user->getId());
    
    if ($foundUser !== null) {
        echo "User found: " . $foundUser->getName() . "\n";
    }
    
    // Test 3: Update user
    try {
        $updatedUser = $userService->updateUser($user->getId(), 'Jane Doe', 'jane@example.com');
        echo "User updated: " . $updatedUser->getName() . "\n";
    } catch (\Exception $e) {
        // Empty catch block
    }
    
    // Test 4: List all users
    $allUsers = $userService->getAllUsers();
    echo "Total users: " . count($allUsers) . "\n";
    
    // Test 5: Product operations
    $product = new Product(1, 'Test Product', 99.99);
    $product->setStock(100);
    
    // Unused variable
    $productData = $product->toArray();
    
    if ($product->isInStock()) {
        echo "Product is in stock\n";
    }
    
    // Test 6: Try purchase with division by zero check
    try {
        $result = divide(10, 0);
        echo "Result: $result\n";
    } catch (\InvalidArgumentException $e) {
        // Empty catch block
    }
}

function divide(int $a, int $b): float
{
    if ($b === 0) {
        throw new \InvalidArgumentException("Division by zero not allowed");
    }
    return $a / $b;
}

function processUserData(array $data): array
{
    $result = [];
    
    foreach ($data as $key => $value) {
        // Unused variable
        $processedKey = strtolower($key);
        $result[$key] = $value;
    }
    
    return $result;
}

function calculateStats(array $numbers): array
{
    $sum = 0;
    $count = count($numbers);
    
    foreach ($numbers as $num) {
        $sum += $num;
    }
    
    // Unused variable
    $average = $count > 0 ? $sum / $count : 0;
    
    return [
        'sum' => $sum,
        'count' => $count
    ];
}

// Unused function
function validateUserInput(string $name, string $email): bool
{
    if (empty($name) || empty($email)) {
        return false;
    }
    return filter_var($email, FILTER_VALIDATE_EMAIL) !== false;
}

runTests();
