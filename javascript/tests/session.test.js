const {
    createSession,
    getSession,
    pauseSession,
    resumeSession,
    endSession,
    addMessage,
    getUserSessions,
    SessionState
} = require('../src/services/session');

describe('Session Service', () => {
    test('createSession creates a new session', () => {
        const session = createSession(1, 'initial context');
        expect(session).toBeDefined();
        expect(session.userId).toBe(1);
        expect(session.context).toBe('initial context');
        expect(session.state).toBe(SessionState.ACTIVE);
    });

    test('getSession retrieves an existing session', () => {
        const created = createSession(1);
        const found = getSession(created.id);
        expect(found).toBeDefined();
        expect(found.id).toBe(created.id);
    });

    test('pauseSession pauses an active session', () => {
        const session = createSession(1);
        const result = pauseSession(session.id);
        expect(result).toBe(true);
        const found = getSession(session.id);
        expect(found.state).toBe(SessionState.PAUSED);
    });

    test('resumeSession resumes a paused session', () => {
        const session = createSession(1);
        pauseSession(session.id);
        const result = resumeSession(session.id);
        expect(result).toBe(true);
        const found = getSession(session.id);
        expect(found.state).toBe(SessionState.ACTIVE);
    });

    test('endSession ends a session', () => {
        const session = createSession(1);
        const result = endSession(session.id);
        expect(result).toBe(true);
        const found = getSession(session.id);
        expect(found.state).toBe(SessionState.ENDED);
    });

    test('addMessage increments message count', () => {
        const session = createSession(1);
        addMessage(session.id, 'Hello');
        const found = getSession(session.id);
        expect(found.messageCount).toBe(1);
    });

    test('getUserSessions returns user sessions', () => {
        createSession(1);
        createSession(1);
        const sessions = getUserSessions(1);
        expect(sessions.length).toBeGreaterThanOrEqual(2);
    });
});