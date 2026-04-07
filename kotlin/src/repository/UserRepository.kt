package com.example.repository

import com.example.model.User

class UserRepository {
    private val users = mutableListOf<User>()

    fun findByUsername(username: String): User? {
        return users.find { it.name == username }
    }

    fun findById(id: Long): User? {
        return users.find { it.id == id }
    }

    fun save(user: User) {
        val index = users.indexOfFirst { it.id == user.id }
        if (index >= 0) {
            users[index] = user
        } else {
            users.add(user)
        }
    }

    fun delete(id: Long) {
        users.removeIf { it.id == id }
    }

    fun findAll(): List<User> = users.toList()
}
