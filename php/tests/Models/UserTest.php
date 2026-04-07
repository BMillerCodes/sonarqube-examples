<?php

namespace App\Tests\Models;

use PHPUnit\Framework\TestCase;
use App\Models\User;

class UserTest extends TestCase
{
    public function testUserCreation(): void
    {
        $user = new User(1, 'John Doe', 'john@example.com');
        
        $this->assertEquals(1, $user->getId());
        $this->assertEquals('John Doe', $user->getName());
        $this->assertEquals('john@example.com', $user->getEmail());
        $this->assertTrue($user->isActive());
    }

    public function testUserSetters(): void
    {
        $user = new User(1, 'John Doe', 'john@example.com');
        
        $user->setName('Jane Doe');
        $user->setEmail('jane@example.com');
        $user->setPhone('1234567890');
        $user->setActive(false);
        
        $this->assertEquals('Jane Doe', $user->getName());
        $this->assertEquals('jane@example.com', $user->getEmail());
        $this->assertEquals('1234567890', $user->getPhone());
        $this->assertFalse($user->isActive());
    }

    public function testUserToArray(): void
    {
        $user = new User(1, 'John Doe', 'john@example.com');
        $user->setPhone('1234567890');
        
        $array = $user->toArray();
        
        $this->assertIsArray($array);
        $this->assertEquals(1, $array['id']);
        $this->assertEquals('John Doe', $array['name']);
        $this->assertEquals('john@example.com', $array['email']);
        $this->assertEquals('1234567890', $array['phone']);
    }
}
