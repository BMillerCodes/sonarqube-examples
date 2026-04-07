export interface User {
    id: number;
    name: string;
    email: string;
    age: number;
    role: string;
    createdAt: Date;
    updatedAt: Date;
}

export interface UserCreate {
    name: string;
    email: string;
    age: number;
    role: string;
}

export interface UserUpdate {
    name?: string;
    email?: string;
    age?: number;
    role?: string;
}

export interface UserResponse {
    success: boolean;
    data: any;
    message: string;
}
