<?php

// Helper functions with code smells

function calculateTotal(float $price, int $quantity): float
{
    // Unused variable
    $taxRate = 0.20;
    
    return $price * $quantity;
}

function formatCurrency(float $amount): string
{
    // Unused variable
    $symbol = '$';
    $decimals = 2;
    
    return number_format($amount, 2);
}

function validateEmail(string $email): bool
{
    return filter_var($email, FILTER_VALIDATE_EMAIL) !== false;
}

function processData(array $data): array
{
    $result = [];
    
    foreach ($data as $item) {
        try {
            $processed = processItem($item);
            $result[] = $processed;
        } catch (\Exception $e) {
            // Empty catch block
        }
    }
    
    return $result;
}

function processItem(array $item): array
{
    // Unused variable
    $timestamp = time();
    
    return [
        'id' => $item['id'] ?? 0,
        'value' => $item['value'] ?? null,
        'processed' => true
    ];
}

function getConfig(string $key): ?string
{
    $config = [
        'app.name' => 'SonarQube Examples',
        'app.version' => '1.0.0',
        'db.host' => 'localhost'
    ];
    
    // Unused variable
    $defaultValue = 'default';
    
    return $config[$key] ?? null;
}

function logMessage(string $message, string $level = 'INFO'): void
{
    // Dead code - unused function
    error_log("[$level] $message");
}

function calculateDiscount(float $price, float $discountPercent): float
{
    // Unused function
    return $price * (1 - $discountPercent / 100);
}

function generateToken(string $username): string
{
    // Unused function
    return hash('sha256', $username . time());
}
