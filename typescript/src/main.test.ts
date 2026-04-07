import { multiply, isValid, formatMessage } from './helpers';

function testMultiply(): void {
    if (multiply(2, 3) !== 6) {
        throw new Error('Expected 6');
    }
}

function testIsValid(): void {
    if (!isValid(50)) {
        throw new Error('Expected 50 to be valid');
    }
    if (isValid(-1)) {
        throw new Error('Expected -1 to be invalid');
    }
}

testMultiply();
testIsValid();
console.log('All tests passed!');