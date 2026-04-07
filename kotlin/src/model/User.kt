package com.example.model

data class User(
    val id: Long,
    val name: String,
    val email: String,
    val active: Boolean = true
)

class UserProfile {
    lateinit var username: String
    lateinit var displayName: String
    lateinit var avatarUrl: String
    var bio: String? = null

    fun initialize(username: String, displayName: String) {
        this.username = username
        this.displayName = displayName
        this.avatarUrl = "https://example.com/avatars/${username}.jpg"
    }

    fun getUsername(): String = username
}
