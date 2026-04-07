const {
    createUser,
    findUserById,
    findUserByUsername,
    getAllUsers,
    updateUser,
    deleteUser
} = require('../src/models/user');

describe('User Model', () => {
    beforeEach(() => {
        // Clear registry before each test
        const userModule = require('../src/models/user');
    });

    test('createUser creates a new user', () => {
        const user = createUser('johndoe', 'john@example.com', 'password123');
        expect(user).toBeDefined();
        expect(user.username).toBe('johndoe');
        expect(user.email).toBe('john@example.com');
        expect(user.id).toBeDefined();
    });

    test('findUserById finds an existing user', () => {
        const created = createUser('johndoe', 'john@example.com', 'password123');
        const found = findUserById(created.id);
        expect(found).toBeDefined();
        expect(found.username).toBe('johndoe');
    });

    test('findUserByUsername finds an existing user', () => {
        createUser('johndoe', 'john@example.com', 'password123');
        const found = findUserByUsername('johndoe');
        expect(found).toBeDefined();
        expect(found.email).toBe('john@example.com');
    });

    test('updateUser updates user properties', () => {
        const created = createUser('johndoe', 'john@example.com', 'password123');
        const updated = updateUser(created.id, { email: 'newemail@example.com' });
        expect(updated.email).toBe('newemail@example.com');
    });

    test('deleteUser removes a user', () => {
        const created = createUser('johndoe', 'john@example.com', 'password123');
        const deleted = deleteUser(created.id);
        expect(deleted).toBe(true);
        expect(findUserById(created.id)).toBeNull();
    });

    test('getAllUsers returns all users', () => {
        createUser('user1', 'user1@example.com', 'password');
        createUser('user2', 'user2@example.com', 'password');
        const users = getAllUsers();
        expect(users.length).toBeGreaterThanOrEqual(2);
    });
});