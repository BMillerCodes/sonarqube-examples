<?php

namespace App\Tests\Services;

use PHPUnit\Framework\TestCase;
use App\Services\UserService;
use App\Repositories\UserRepository;

class UserServiceTest extends TestCase
{
    private UserService $userService;
    private UserRepository $repository;

    protected function setUp(): void
    {
        $this->repository = new UserRepository();
        $this->userService = new UserService($this->repository);
    }

    public function testCreateUser(): void
    {
        $user = $this->userService->createUser('John Doe', 'john@example.com');
        
        $this->assertEquals('John Doe', $user->getName());
        $this->assertEquals('john@example.com', $user->getEmail());
        $this->assertTrue($user->isActive());
    }

    public function testCreateUserWithPhone(): void
    {
        $user = $this->userService->createUser('John Doe', 'john@example.com', '1234567890');
        
        $this->assertEquals('1234567890', $user->getPhone());
    }

    public function testGetUser(): void
    {
        $createdUser = $this->userService->createUser('John Doe', 'john@example.com');
        $retrievedUser = $this->userService->getUser($createdUser->getId());
        
        $this->assertNotNull($retrievedUser);
        $this->assertEquals($createdUser->getId(), $retrievedUser->getId());
    }

    public function testGetNonExistentUser(): void
    {
        $user = $this->userService->getUser(9999);
        
        $this->assertNull($user);
    }

    public function testUpdateUser(): void
    {
        $user = $this->userService->createUser('John Doe', 'john@example.com');
        
        $updatedUser = $this->userService->updateUser($user->getId(), 'Jane Doe', 'jane@example.com');
        
        $this->assertNotNull($updatedUser);
        $this->assertEquals('Jane Doe', $updatedUser->getName());
        $this->assertEquals('jane@example.com', $updatedUser->getEmail());
    }

    public function testDeleteUser(): void
    {
        $user = $this->userService->createUser('John Doe', 'john@example.com');
        $result = $this->userService->deleteUser($user->getId());
        
        $this->assertTrue($result);
        $this->assertNull($this->userService->getUser($user->getId()));
    }

    public function testDeleteNonExistentUser(): void
    {
        $result = $this->userService->deleteUser(9999);
        
        $this->assertFalse($result);
    }

    public function testGetAllUsers(): void
    {
        $this->userService->createUser('User 1', 'user1@example.com');
        $this->userService->createUser('User 2', 'user2@example.com');
        
        $users = $this->userService->getAllUsers();
        
        $this->assertCount(2, $users);
    }

    public function testFindByEmail(): void
    {
        $this->userService->createUser('John Doe', 'john@example.com');
        
        $user = $this->userService->findByEmail('john@example.com');
        
        $this->assertNotNull($user);
        $this->assertEquals('john@example.com', $user->getEmail());
    }

    public function testActivateUser(): void
    {
        $user = $this->userService->createUser('John Doe', 'john@example.com');
        $user->setActive(false);
        
        $result = $this->userService->activateUser($user->getId());
        
        $this->assertTrue($result);
        $updatedUser = $this->userService->getUser($user->getId());
        $this->assertTrue($updatedUser->isActive());
    }

    public function testDeactivateUser(): void
    {
        $user = $this->userService->createUser('John Doe', 'john@example.com');
        
        $result = $this->userService->deactivateUser($user->getId());
        
        $this->assertTrue($result);
        $updatedUser = $this->userService->getUser($user->getId());
        $this->assertFalse($updatedUser->isActive());
    }
}
