<?php

require_once __DIR__ . '/main.php';

function testAdd(): void {
    $result = add(2, 3);
    assert($result === 5, "Expected 5");
}

function testDivide(): void {
    $result = divide(10, 2);
    assert($result === 5.0, "Expected 5.0");
}

function testDivideByZero(): void {
    try {
        divide(1, 0);
        echo "FAIL: Should have thrown\n";
    } catch (InvalidArgumentException $e) {
        echo "PASS: Caught expected exception\n";
    }
}

testAdd();
testDivide();
testDivideByZero();
echo "All tests passed!\n";
