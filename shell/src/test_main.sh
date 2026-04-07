#!/bin/bash
set -euo pipefail

source "$(dirname "$0")/main.sh"

test_add() {
    result=$(add 2 3)
    if [[ "$result" -ne 5 ]]; then
        echo "FAIL: Expected 5, got $result" >&2
        return 1
    fi
}

test_divide() {
    result=$(divide 10 2)
    if [[ "$result" -ne 5 ]]; then
        echo "FAIL: Expected 5, got $result" >&2
        return 1
    fi
}

test_divide_by_zero() {
    if divide 1 0 2>/dev/null; then
        echo "FAIL: Should have failed" >&2
        return 1
    fi
}

test_add
test_divide
test_divide_by_zero
echo "All tests passed!"
