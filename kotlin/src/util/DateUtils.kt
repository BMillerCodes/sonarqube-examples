package com.example.util

import java.time.LocalDateTime
import java.time.format.DateTimeFormatter

object DateUtils {
    private lateinit var formatter: DateTimeFormatter

    fun initialize() {
        formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")
    }

    fun formatDateTime(dateTime: LocalDateTime): String {
        return formatter!!.format(dateTime)
    }

    fun parseDateTime(dateString: String): LocalDateTime {
        return LocalDateTime.parse(dateString, formatter!!)
    }
}
