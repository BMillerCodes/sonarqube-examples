import { UserService } from '../services/UserService';

describe('UserService', () => {
    let userService: UserService;

    beforeEach(() => {
        userService = new UserService();
    });

    describe('create', () => {
        it('should create a new user', () => {
            const result = userService.create({
                name: 'John Doe',
                email: 'john@example.com',
                age: 30,
                role: 'admin'
            });

            expect(result.success).toBe(true);
            expect(result.data.name).toBe('John Doe');
            expect(result.data.email).toBe('john@example.com');
            expect(result.data.id).toBe(1);
        });

        it('should create multiple users with incrementing IDs', () => {
            userService.create({
                name: 'User 1',
                email: 'user1@example.com',
                age: 25,
                role: 'user'
            });

            const result = userService.create({
                name: 'User 2',
                email: 'user2@example.com',
                age: 35,
                role: 'moderator'
            });

            expect(result.data.id).toBe(2);
        });
    });

    describe('findAll', () => {
        it('should return empty array when no users exist', () => {
            const result = userService.findAll();
            expect(result.success).toBe(true);
            expect(result.data).toEqual([]);
        });

        it('should return all users', () => {
            userService.create({
                name: 'User 1',
                email: 'user1@example.com',
                age: 25,
                role: 'user'
            });

            userService.create({
                name: 'User 2',
                email: 'user2@example.com',
                age: 35,
                role: 'moderator'
            });

            const result = userService.findAll();
            expect(result.data.length).toBe(2);
        });
    });

    describe('findById', () => {
        it('should find user by id', () => {
            userService.create({
                name: 'John Doe',
                email: 'john@example.com',
                age: 30,
                role: 'admin'
            });

            const result = userService.findById(1);
            expect(result.success).toBe(true);
            expect(result.data.name).toBe('John Doe');
        });

        it('should return not found for non-existent id', () => {
            const result = userService.findById(999);
            expect(result.success).toBe(false);
            expect(result.data).toBeUndefined();
        });
    });

    describe('update', () => {
        it('should update user successfully', () => {
            userService.create({
                name: 'John Doe',
                email: 'john@example.com',
                age: 30,
                role: 'admin'
            });

            const result = userService.update(1, {
                name: 'Jane Doe',
                age: 28
            });

            expect(result.success).toBe(true);
            expect(result.data.name).toBe('Jane Doe');
            expect(result.data.age).toBe(28);
            expect(result.data.email).toBe('john@example.com');
        });

        it('should return not found for non-existent id', () => {
            const result = userService.update(999, { name: 'Test' });
            expect(result.success).toBe(false);
        });
    });

    describe('delete', () => {
        it('should delete user successfully', () => {
            userService.create({
                name: 'John Doe',
                email: 'john@example.com',
                age: 30,
                role: 'admin'
            });

            const result = userService.delete(1);
            expect(result.success).toBe(true);

            const findResult = userService.findById(1);
            expect(findResult.success).toBe(false);
        });

        it('should return not found for non-existent id', () => {
            const result = userService.delete(999);
            expect(result.success).toBe(false);
        });
    });

    describe('findByEmail', () => {
        it('should find user by email', () => {
            userService.create({
                name: 'John Doe',
                email: 'john@example.com',
                age: 30,
                role: 'admin'
            });

            const result = userService.findByEmail('john@example.com');
            expect(result.success).toBe(true);
            expect(result.data.name).toBe('John Doe');
        });
    });

    describe('findByRole', () => {
        it('should find users by role', () => {
            userService.create({
                name: 'User 1',
                email: 'user1@example.com',
                age: 25,
                role: 'admin'
            });

            userService.create({
                name: 'User 2',
                email: 'user2@example.com',
                age: 35,
                role: 'user'
            });

            const result = userService.findByRole('admin');
            expect(result.data.length).toBe(1);
            expect(result.data[0].name).toBe('User 1');
        });
    });

    describe('bulkCreate', () => {
        it('should create multiple users at once', () => {
            const users = [
                { name: 'User 1', email: 'user1@example.com', age: 25, role: 'user' },
                { name: 'User 2', email: 'user2@example.com', age: 35, role: 'admin' },
                { name: 'User 3', email: 'user3@example.com', age: 28, role: 'moderator' }
            ];

            const result = userService.bulkCreate(users);
            expect(result.success).toBe(true);
            expect(result.data.length).toBe(3);
        });
    });

    describe('validateUserData', () => {
        it('should return true for valid data', () => {
            const valid = userService.validateUserData({
                name: 'John',
                email: 'john@example.com',
                age: 30,
                role: 'admin'
            });
            expect(valid).toBe(true);
        });

        it('should return false for invalid email', () => {
            const invalid = userService.validateUserData({
                name: 'John',
                email: 'invalid-email',
                age: 30,
                role: 'admin'
            });
            expect(invalid).toBe(false);
        });

        it('should return false for age out of range', () => {
            const invalid = userService.validateUserData({
                name: 'John',
                email: 'john@example.com',
                age: 200,
                role: 'admin'
            });
            expect(invalid).toBe(false);
        });
    });
});
