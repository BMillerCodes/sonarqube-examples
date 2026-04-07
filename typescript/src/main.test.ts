import { multiply, isValid, formatMessage } from './helpers';

describe('Helpers', () => {
    describe('multiply', () => {
        it('should multiply two numbers correctly', () => {
            expect(multiply(2, 3)).toBe(6);
        });

        it('should return 0 when multiplying by 0', () => {
            expect(multiply(5, 0)).toBe(0);
        });

        it('should handle negative numbers', () => {
            expect(multiply(-2, 3)).toBe(-6);
        });
    });

    describe('isValid', () => {
        it('should return true for values between 0 and 100', () => {
            expect(isValid(50)).toBe(true);
            expect(isValid(0)).toBe(true);
            expect(isValid(100)).toBe(true);
        });

        it('should return false for values outside 0-100 range', () => {
            expect(isValid(-1)).toBe(false);
            expect(isValid(101)).toBe(false);
        });
    });

    describe('formatMessage', () => {
        it('should wrap message in [INFO] prefix', () => {
            expect(formatMessage('Test message')).toBe('[INFO] Test message');
        });

        it('should handle empty strings', () => {
            expect(formatMessage('')).toBe('[INFO] ');
        });
    });
});
