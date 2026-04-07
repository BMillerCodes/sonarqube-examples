const assert = require('assert');

function testAdd() {
    assert.strictEqual(add(2, 3), 5);
}

function testDivide() {
    assert.strictEqual(divide(10, 2), 5);
}

function testDivideByZero() {
    try {
        divide(1, 0);
        assert.fail('Should have thrown');
    } catch (err) {
        assert.strictEqual(err.message, 'Division by zero');
    }
}

testAdd();
testDivide();
testDivideByZero();
console.log('All tests passed!');