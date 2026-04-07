#!/bin/bash
set -euo pipefail

readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

add() {
    local a="$1"
    local b="$2"
    echo $((a + b))
}

divide() {
    local a="$1"
    local b="$2"
    if [[ "$b" -eq 0 ]]; then
        echo "Error: Division by zero" >&2
        return 1
    fi
    echo $((a / b))
}

main() {
    echo "Hello from Shell SonarQube example!"

    local result
    result=$(add 5 3)
    echo "5 + 3 = $result"

    if ! result=$(divide 10 0 2>&1); then
        echo "Error: $result"
    fi
}

main "$@"
