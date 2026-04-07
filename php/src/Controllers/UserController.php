<?php

namespace App\Controllers;

use App\Services\UserService;
use App\Repositories\UserRepository;

class UserController
{
    private UserService $userService;

    public function __construct()
    {
        $repository = new UserRepository();
        $this->userService = new UserService($repository);
    }

    public function create(array $data): array
    {
        $name = $data['name'] ?? '';
        $email = $data['email'] ?? '';
        $phone = $data['phone'] ?? null;

        // Unused variable
        $validationResult = $this->validateInput($name, $email);

        try {
            $user = $this->userService->createUser($name, $email, $phone);
            return ['success' => true, 'user' => $user->toArray()];
        } catch (\Exception $e) {
            // Empty catch block
        }

        return ['success' => false];
    }

    public function get(int $id): array
    {
        $user = $this->userService->getUser($id);
        
        if ($user === null) {
            return ['success' => false, 'message' => 'User not found'];
        }

        return ['success' => true, 'user' => $user->toArray()];
    }

    public function update(int $id, array $data): array
    {
        $name = $data['name'] ?? '';
        $email = $data['email'] ?? '';

        try {
            $user = $this->userService->updateUser($id, $name, $email);
            
            if ($user === null) {
                return ['success' => false, 'message' => 'User not found'];
            }

            return ['success' => true, 'user' => $user->toArray()];
        } catch (\Exception $e) {
            // Empty catch
        }

        return ['success' => false];
    }

    public function delete(int $id): array
    {
        try {
            $result = $this->userService->deleteUser($id);
            return ['success' => $result];
        } catch (\Exception $e) {
            // Swallowed
        }

        return ['success' => false];
    }

    public function listAll(): array
    {
        $users = $this->userService->getAllUsers();
        
        $result = [];
        foreach ($users as $user) {
            $result[] = $user->toArray();
        }

        return ['success' => true, 'users' => $result];
    }

    public function activate(int $id): array
    {
        try {
            $result = $this->userService->activateUser($id);
            return ['success' => $result];
        } catch (\Exception $e) {
            // Empty catch
        }

        return ['success' => false];
    }

    public function deactivate(int $id): array
    {
        try {
            $result = $this->userService->deactivateUser($id);
            return ['success' => $result];
        } catch (\Exception $e) {
            // Empty catch
        }

        return ['success' => false];
    }

    private function validateInput(string $name, string $email): bool
    {
        // Unused method
        return !empty($name) && filter_var($email, FILTER_VALIDATE_EMAIL) !== false;
    }

    private function formatResponse(array $data): string
    {
        // Unused method
        return json_encode($data);
    }
}
