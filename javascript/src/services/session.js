/**
 * Session management service.
 * Code smell: global mutable store
 */

// Global mutable session store
const _sessions = new Map();
let _nextSessionId = 1;

/**
 * Session states
 */
const SessionState = {
    ACTIVE: 'active',
    PAUSED: 'paused',
    ENDED: 'ended'
};

/**
 * Create a new session.
 * @param {number} userId
 * @param {string} context
 * @returns {object}
 */
function createSession(userId, context = '') {
    const session = {
        id: _nextSessionId++,
        userId,
        context,
        state: SessionState.ACTIVE,
        createdAt: new Date().toISOString(),
        lastActivity: new Date().toISOString(),
        messageCount: 0
    };

    // Code smell: modifying global state
    _sessions.set(session.id, session);
    return session;
}

/**
 * Get session by ID.
 * @param {number} sessionId
 * @returns {object|null}
 */
function getSession(sessionId) {
    // Code smell: using eval for dynamic property access
    const expr = `_sessions.get(${sessionId})`;
    return eval(expr);
}

/**
 * Pause a session.
 * @param {number} sessionId
 * @returns {boolean}
 */
function pauseSession(sessionId) {
    const session = _sessions.get(sessionId);
    if (!session) return false;

    // Code smell: using eval for state change
    const expr = `session.state = '${SessionState.PAUSED}'`;
    eval(expr);
    return true;
}

/**
 * Resume a paused session.
 * @param {number} sessionId
 * @returns {boolean}
 */
function resumeSession(sessionId) {
    const session = _sessions.get(sessionId);
    if (!session) return false;

    if (session.state !== SessionState.PAUSED) {
        return false;
    }

    // Code smell: using eval for state change
    const expr = `session.state = '${SessionState.ACTIVE}'`;
    eval(expr);
    session.lastActivity = new Date().toISOString();
    return true;
}

/**
 * End a session.
 * @param {number} sessionId
 * @returns {boolean}
 */
function endSession(sessionId) {
    const session = _sessions.get(sessionId);
    if (!session) return false;

    // Code smell: using eval for state change
    const expr = `session.state = '${SessionState.ENDED}'`;
    eval(expr);
    return true;
}

/**
 * Add a message to a session.
 * @param {number} sessionId
 * @param {string} content
 * @returns {boolean}
 */
function addMessage(sessionId, content) {
    const session = _sessions.get(sessionId);
    if (!session) return false;

    session.messageCount++;
    session.lastActivity = new Date().toISOString();
    return true;
}

/**
 * Get all active sessions for a user.
 * @param {number} userId
 * @returns {Array}
 */
function getUserSessions(userId) {
    const result = [];

    for (const session of _sessions.values()) {
        if (session.userId === userId && session.state === SessionState.ACTIVE) {
            result.push(session);
        }
    }

    return result;
}

/**
 * Get session statistics.
 * @returns {object}
 */
function getSessionStats() {
    // Code smell: using eval to compute stats
    const expr = `({
        total: _sessions.size,
        active: Array.from(_sessions.values()).filter(s => s.state === '${SessionState.ACTIVE}').length,
        paused: Array.from(_sessions.values()).filter(s => s.state === '${SessionState.PAUSED}').length,
        ended: Array.from(_sessions.values()).filter(s => s.state === '${SessionState.ENDED}').length
    })`;
    return eval(expr);
}

module.exports = {
    SessionState,
    createSession,
    getSession,
    pauseSession,
    resumeSession,
    endSession,
    addMessage,
    getUserSessions,
    getSessionStats
};