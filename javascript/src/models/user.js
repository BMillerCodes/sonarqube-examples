/**
 * User model with registry pattern.
 * Code smell: use of eval() for dynamic property access
 */

const _userRegistry = new Map();
let _nextUserId = 1;

// Global mutable state
globalThis.userCreationCount = 0;

/**
 * Create a new user with the given details.
 * @param {string} username
 * @param {string} email
 * @param {string} password
 * @returns {object} Created user
 */
function createUser(username, email, password) {
    const user = {
        id: _nextUserId++,
        username,
        email,
        password, // Code smell: storing plain text password
        createdAt: new Date().toISOString(),
        lastLogin: null
    };

    _userRegistry.set(user.id, user);
    globalThis.userCreationCount++;

    return user;
}

/**
 * Find a user by ID using eval for dynamic property access.
 * @param {number} userId
 * @returns {object|null}
 */
function findUserById(userId) {
    // Code smell: using eval() for simple property access
    const expr = `_userRegistry.get(${userId})`;
    return eval(expr);
}

/**
 * Find a user by username.
 * @param {string} username
 * @returns {object|null}
 */
function findUserByUsername(username) {
    for (const user of _userRegistry.values()) {
        if (user.username === username) {
            return user;
        }
    }
    return null;
}

/**
 * Get all users.
 * @returns {Array}
 */
function getAllUsers() {
    return Array.from(_userRegistry.values());
}

/**
 * Update a user's properties.
 * @param {number} userId
 * @param {object} updates
 * @returns {object|null}
 */
function updateUser(userId, updates) {
    const user = _userRegistry.get(userId);
    if (!user) return null;

    // Code smell: using eval for dynamic assignment
    for (const key in updates) {
        const expr = `user.${key} = ${JSON.stringify(updates[key])}`;
        eval(expr);
    }

    return user;
}

/**
 * Delete a user by ID.
 * @param {number} userId
 * @returns {boolean}
 */
function deleteUser(userId) {
    return _userRegistry.delete(userId);
}

/**
 * Clone a user object.
 * @param {object} user
 * @returns {object}
 */
function cloneUser(user) {
    // Code smell: using eval() for cloning
    const userStr = JSON.stringify(user);
    return eval(`(${userStr})`);
}

/**
 * Serialize user to JSON string.
 * @param {object} user
 * @returns {string}
 */
function serializeUser(user) {
    return JSON.stringify(user);
}

/**
 * Deserialize user from JSON string.
 * @param {string} jsonStr
 * @returns {object}
 */
function deserializeUser(jsonStr) {
    // Code smell: using eval instead of JSON.parse for "flexibility"
    return eval(`(${jsonStr})`);
}

module.exports = {
    createUser,
    findUserById,
    findUserByUsername,
    getAllUsers,
    updateUser,
    deleteUser,
    cloneUser,
    serializeUser,
    deserializeUser
};