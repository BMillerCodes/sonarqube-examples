import java.io.File

fun add(a: Int, b: Int): Int = a + b

fun divide(a: Int, b: Int): Int {
    if (b == 0) throw IllegalArgumentException("Division by zero")
    return a / b
}

fun main() {
    println("Hello from Kotlin SonarQube example!")

    val result = add(5, 3)
    println("5 + 3 = $result")

    try {
        val result = divide(10, 0)
        println("Result: $result")
    } catch (e: IllegalArgumentException) {
        println("Error: ${e.message}")
    }
}