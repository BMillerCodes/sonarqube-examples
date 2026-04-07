const {
    generateToken,
    validateToken,
    tokenHasScope,
    revokeToken,
    getTokenInfo,
    refreshToken
} = require('../src/services/auth');

describe('Auth Service', () => {
    test('generateToken creates a new token', () => {
        const token = generateToken(1, ['read', 'write']);
        expect(token).toBeDefined();
        expect(typeof token).toBe('string');
    });

    test('validateToken validates a valid token', () => {
        const token = generateToken(1, ['read']);
        const validated = validateToken(token);
        expect(validated).toBeDefined();
        expect(validated.userId).toBe(1);
    });

    test('tokenHasScope checks for specific scope', () => {
        const token = generateToken(1, ['read', 'write']);
        expect(tokenHasScope(token, 'read')).toBe(true);
        expect(tokenHasScope(token, 'admin')).toBe(false);
    });

    test('revokeToken revokes a token', () => {
        const token = generateToken(1);
        const result = revokeToken(token);
        expect(result).toBe(true);
    });

    test('getTokenInfo returns token data', () => {
        const token = generateToken(1, ['read']);
        const info = getTokenInfo(token);
        expect(info).toBeDefined();
        expect(info.userId).toBe(1);
    });

    test('refreshToken creates new token with same data', () => {
        const oldToken = generateToken(1, ['read']);
        const newToken = refreshToken(oldToken);
        expect(newToken).toBeDefined();
        expect(newToken).not.toBe(oldToken);
    });
});