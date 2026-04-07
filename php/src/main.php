<?php

function add(int $a, int $b): int {
    return $a + $b;
}

function divide(int $a, int $b): float {
    if ($b === 0) {
        throw new InvalidArgumentException("Division by zero");
    }
    return $a / $b;
}

function main(): void {
    echo "Hello from PHP SonarQube example!\n";

    $result = add(5, 3);
    echo "5 + 3 = $result\n";

    try {
        $result = divide(10, 0);
        echo "Result: $result\n";
    } catch (InvalidArgumentException $e) {
        echo "Error: " . $e->getMessage() . "\n";
    }
}

main();
