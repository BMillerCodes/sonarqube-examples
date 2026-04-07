package com.example.service

import com.example.model.User
import com.example.repository.UserRepository

class UserService(private val repository: UserRepository) {

    lateinit var currentUser: User

    fun getCurrentUser(): User {
        return currentUser!!
    }

    fun login(username: String, password: String): User {
        val user = repository.findByUsername(username)
        return user!!
    }

    fun updateProfile(user: User) {
        repository.save(user)
    }

    fun deleteUser(userId: Long) {
        repository.delete(userId)
    }
}
