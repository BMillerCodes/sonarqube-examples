import { User, UserCreate, UserUpdate, UserResponse } from '../interfaces/user';

export class UserService {
    private users: User[] = [];
    private idCounter: number = 1;

    create(data: UserCreate): UserResponse {
        const user: User = {
            id: this.idCounter++,
            name: data.name,
            email: data.email,
            age: data.age,
            role: data.role,
            createdAt: new Date(),
            updatedAt: new Date()
        };
        
        this.users.push(user);
        
        return {
            success: true,
            data: user,
            message: 'User created successfully'
        };
    }

    findAll(): UserResponse {
        return {
            success: true,
            data: this.users,
            message: 'Users retrieved successfully'
        };
    }

    findById(id: number): UserResponse {
        const user = this.users.find(u => u.id === id);
        
        return {
            success: !!user,
            data: user,
            message: user ? 'User found' : 'User not found'
        };
    }

    update(id: number, data: UserUpdate): UserResponse {
        const userIndex = this.users.findIndex(u => u.id === id);
        
        if (userIndex === -1) {
            return {
                success: false,
                data: null,
                message: 'User not found'
            };
        }
        
        const user = this.users[userIndex];
        
        if (data.name) user.name = data.name;
        if (data.email) user.email = data.email;
        if (data.age) user.age = data.age;
        if (data.role) user.role = data.role;
        user.updatedAt = new Date();
        
        return {
            success: true,
            data: user,
            message: 'User updated successfully'
        };
    }

    delete(id: number): UserResponse {
        const userIndex = this.users.findIndex(u => u.id === id);
        
        if (userIndex === -1) {
            return {
                success: false,
                data: null,
                message: 'User not found'
            };
        }
        
        const deletedUser = this.users.splice(userIndex, 1)[0];
        
        return {
            success: true,
            data: deletedUser,
            message: 'User deleted successfully'
        };
    }

    findByEmail(email: string): UserResponse {
        const user = this.users.find(u => u.email === email);
        
        return {
            success: !!user,
            data: user,
            message: user ? 'User found' : 'User not found'
        };
    }

    findByRole(role: string): UserResponse {
        const filteredUsers = this.users.filter(u => u.role === role);
        
        return {
            success: true,
            data: filteredUsers,
            message: `${filteredUsers.length} users found with role ${role}`
        };
    }

    processUsers(users: any[], criteria: any): any[] {
        let result = users;
        
        if (criteria.name) {
            result = result.filter(u => u.name.includes(criteria.name));
        }
        
        if (criteria.email) {
            result = result.filter(u => u.email.includes(criteria.email));
        }
        
        if (criteria.age) {
            result = result.filter(u => u.age === criteria.age);
        }
        
        if (criteria.role) {
            result = result.filter(u => u.role === criteria.role);
        }
        
        if (criteria.minAge) {
            result = result.filter(u => u.age >= criteria.minAge);
        }
        
        if (criteria.maxAge) {
            result = result.filter(u => u.age <= criteria.maxAge);
        }
        
        if (criteria.sortBy) {
            result = result.sort((a, b) => {
                if (a[criteria.sortBy] < b[criteria.sortBy]) return -1;
                if (a[criteria.sortBy] > b[criteria.sortBy]) return 1;
                return 0;
            });
        }
        
        if (criteria.limit) {
            result = result.slice(0, criteria.limit);
        }
        
        if (criteria.offset) {
            result = result.slice(criteria.offset);
        }
        
        return result;
    }

    bulkCreate(users: UserCreate[]): UserResponse {
        const createdUsers: User[] = [];
        
        for (const userData of users) {
            const user: User = {
                id: this.idCounter++,
                name: userData.name,
                email: userData.email,
                age: userData.age,
                role: userData.role,
                createdAt: new Date(),
                updatedAt: new Date()
            };
            createdUsers.push(user);
            this.users.push(user);
        }
        
        return {
            success: true,
            data: createdUsers,
            message: `${createdUsers.length} users created successfully`
        };
    }

    validateUserData(data: any): boolean {
        if (!data.name || data.name.length === 0) return false;
        if (!data.email || !data.email.includes('@')) return false;
        if (!data.age || data.age < 0 || data.age > 150) return false;
        if (!data.role) return false;
        return true;
    }
}
