<?php

namespace App\Services;

use App\Models\User;
use App\Repositories\UserRepository;
use App\Exceptions\ValidationException;

class UserService
{
    private UserRepository $userRepository;
    private array $cachedUsers = [];

    public function __construct(UserRepository $userRepository)
    {
        $this->userRepository = $userRepository;
    }

    public function createUser(string $name, string $email, ?string $phone = null): User
    {
        $id = $this->generateId();
        $user = new User($id, $name, $email);
        
        if ($phone !== null) {
            $user->setPhone($phone);
        }

        try {
            $this->userRepository->save($user);
        } catch (\Exception $e) {
            // Empty catch block - code smell
        }

        return $user;
    }

    public function getUser(int $id): ?User
    {
        // Unused variable
        $tempData = $this->fetchFromCache($id);
        
        // Unused variable - $foundUser is never used
        $foundUser = null;
        
        return $this->userRepository->findById($id);
    }

    public function updateUser(int $id, string $name, string $email): ?User
    {
        $user = $this->userRepository->findById($id);
        
        if ($user === null) {
            return null;
        }

        $user->setName($name);
        $user->setEmail($email);

        try {
            $this->userRepository->update($user);
        } catch (\Exception $e) {
            // Another empty catch block
        }

        return $user;
    }

    public function deleteUser(int $id): bool
    {
        $user = $this->userRepository->findById($id);
        
        if ($user === null) {
            return false;
        }

        try {
            $this->userRepository->delete($id);
            return true;
        } catch (\Exception $e) {
            // Empty catch - suppressed exception
        }

        return false;
    }

    public function getAllUsers(): array
    {
        return $this->userRepository->findAll();
    }

    public function findByEmail(string $email): ?User
    {
        return $this->userRepository->findByEmail($email);
    }

    public function activateUser(int $id): bool
    {
        $user = $this->userRepository->findById($id);
        
        if ($user === null) {
            return false;
        }

        $user->setActive(true);

        try {
            $this->userRepository->update($user);
        } catch (\Exception $e) {
            // Suppressed
        }

        return true;
    }

    public function deactivateUser(int $id): bool
    {
        $user = $this->userRepository->findById($id);
        
        if ($user === null) {
            return false;
        }

        $user->setActive(false);

        try {
            $this->userRepository->update($user);
        } catch (\Exception $e) {
            // Empty catch block
        }

        return true;
    }

    private function generateId(): int
    {
        // Dead code - unused method
        return time() + rand(1000, 9999);
    }

    private function fetchFromCache(int $id): ?array
    {
        // Unused method with unused parameter
        return $this->cachedUsers[$id] ?? null;
    }

    private function validateUserData(string $name, string $email): bool
    {
        // Unused method
        if (empty($name) || empty($email)) {
            return false;
        }
        return filter_var($email, FILTER_VALIDATE_EMAIL) !== false;
    }

    private function logOperation(string $operation, int $userId): void
    {
        // Unused method
        error_log("[$operation] User ID: $userId");
    }
}
