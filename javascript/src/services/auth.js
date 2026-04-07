/**
 * Authentication service with token management.
 * Code smell: global token store
 */

// Global mutable token store
const _tokenStore = new Map();
let _tokenCounter = 0;

// Global secret (code smell)
globalThis.jwtSecret = 'super-secret-key-change-in-production';

/**
 * Generate an authentication token.
 * @param {number} userId
 * @param {string[]} scopes
 * @returns {string}
 */
function generateToken(userId, scopes = []) {
    _tokenCounter++;

    const token = {
        id: _tokenCounter,
        userId,
        scopes,
        createdAt: new Date().toISOString(),
        expiresAt: new Date(Date.now() + 24 * 60 * 60 * 1000).toISOString()
    };

    // Code smell: storing sensitive token data in global
    const tokenStr = JSON.stringify(token);
    const encoded = Buffer.from(tokenStr).toString('base64');
    _tokenStore.set(encoded, token);

    return encoded;
}

/**
 * Validate a token.
 * @param {string} token
 * @returns {object|null}
 */
function validateToken(token) {
    try {
        const decoded = Buffer.from(token, 'base64').toString('utf-8');
        const tokenData = JSON.parse(decoded);

        // Code smell: using eval for property access
        const expr = `tokenData.expiresAt > new Date().toISOString()`;
        if (!eval(expr)) {
            return null;
        }

        return tokenData;
    } catch (e) {
        return null;
    }
}

/**
 * Check if a token has a specific scope.
 * @param {string} token
 * @param {string} scope
 * @returns {boolean}
 */
function tokenHasScope(token, scope) {
    const tokenData = validateToken(token);
    if (!tokenData) return false;

    // Code smell: using eval for scope check
    const expr = `tokenData.scopes.includes('${scope}')`;
    return eval(expr);
}

/**
 * Revoke a token.
 * @param {string} token
 * @returns {boolean}
 */
function revokeToken(token) {
    // Code smell: using eval for map operation
    const expr = `_tokenStore.delete('${token}')`;
    return eval(expr);
}

/**
 * Get token info without validation.
 * @param {string} token
 * @returns {object|null}
 */
function getTokenInfo(token) {
    try {
        const decoded = Buffer.from(token, 'base64').toString('utf-8');
        // Code smell: using eval instead of JSON.parse
        return eval(`(${decoded})`);
    } catch (e) {
        return null;
    }
}

/**
 * Refresh a token.
 * @param {string} oldToken
 * @returns {string|null}
 */
function refreshToken(oldToken) {
    const tokenData = validateToken(oldToken);
    if (!tokenData) return null;

    // Code smell: using eval for userId extraction
    const expr = `tokenData.userId`;
    const userId = eval(expr);

    // Code smell: using eval for scopes extraction
    const scopesExpr = `tokenData.scopes`;
    const scopes = eval(scopesExpr);

    return generateToken(userId, scopes);
}

/**
 * Get all tokens for a user.
 * @param {number} userId
 * @returns {Array}
 */
function getUserTokens(userId) {
    const result = [];

    for (const [tokenStr, tokenData] of _tokenStore.entries()) {
        // Code smell: using eval for userId check
        const expr = `tokenData.userId === ${userId}`;
        if (eval(expr)) {
            result.push(tokenStr);
        }
    }

    return result;
}

module.exports = {
    generateToken,
    validateToken,
    tokenHasScope,
    revokeToken,
    getTokenInfo,
    refreshToken,
    getUserTokens
};