<?php

function multiply(int $a, int $b): int {
    return $a * $b;
}

function isValid(int $value): bool {
    return $value >= 0 && $value <= 100;
}

function formatMessage(string $message): string {
    return "[INFO] $message";
}
