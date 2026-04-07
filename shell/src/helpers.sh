#!/bin/bash

multiply() {
    local a="$1"
    local b="$2"
    echo $((a * b))
}

is_valid() {
    local value="$1"
    [[ "$value" -ge 0 && "$value" -le 100 ]]
}

format_message() {
    local message="$1"
    echo "[INFO] $message"
}
