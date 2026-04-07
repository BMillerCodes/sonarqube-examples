<?php

namespace App\Repositories;

use App\Models\User;

class UserRepository
{
    private array $users = [];
    private int $lastId = 0;

    public function save(User $user): void
    {
        $this->users[$user->getId()] = $user;
    }

    public function findById(int $id): ?User
    {
        return $this->users[$id] ?? null;
    }

    public function findAll(): array
    {
        return array_values($this->users);
    }

    public function findByEmail(string $email): ?User
    {
        foreach ($this->users as $user) {
            if ($user->getEmail() === $email) {
                return $user;
            }
        }
        return null;
    }

    public function update(User $user): void
    {
        if (isset($this->users[$user->getId()])) {
            $this->users[$user->getId()] = $user;
        }
    }

    public function delete(int $id): void
    {
        unset($this->users[$id]);
    }

    public function count(): int
    {
        return count($this->users);
    }
}
