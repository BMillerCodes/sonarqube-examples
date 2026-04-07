function multiply(a, b) {
    return a * b;
}

function isValid(value) {
    return value >= 0 && value <= 100;
}

function formatMessage(message) {
    return `[INFO] ${message}`;
}

module.exports = { multiply, isValid, formatMessage };