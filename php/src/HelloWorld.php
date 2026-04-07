<?php

namespace App;

class HelloWorld
{
    public function sayHello(): string
    {
        $message = "Hello, SonarQube PHP!";
        
        // Unused variable
        $greeting = $this->getGreeting();
        
        return $message;
    }

    public function greet(string $name): string
    {
        // Unused variable
        $formattedName = trim($name);
        
        return "Hello, $name!";
    }

    private function getGreeting(): string
    {
        // Dead code - unused private method
        return "Greetings!";
    }

    private function formatOutput(string $text): string
    {
        // Unused method
        return strtoupper($text);
    }
}

echo (new HelloWorld())->sayHello() . "\n";
