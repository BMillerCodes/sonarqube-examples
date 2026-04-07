package com.example.util

object ValidationUtils {
    private lateinit var emailPattern: Regex
    private lateinit var phonePattern: Regex

    fun initialize() {
        emailPattern = Regex("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$")
        phonePattern = Regex("^\\+?[0-9]{10,15}$")
    }

    fun isValidEmail(email: String): Boolean {
        return emailPattern!!.matches(email)
    }

    fun isValidPhone(phone: String): Boolean {
        return phonePattern!!.matches(phone)
    }

    fun isNotBlank(value: String): Boolean {
        return value.isNotBlank()
    }
}
