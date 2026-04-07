object Main {
  def add(a: Int, b: Int): Int = a + b

  def divide(a: Int, b: Int): Int = {
    if (b == 0) throw new IllegalArgumentException("Division by zero")
    a / b
  }

  def main(args: Array[String]): Unit = {
    println("Hello from Scala SonarQube example!")

    val result = add(5, 3)
    println(s"5 + 3 = $result")

    try {
      val result = divide(10, 0)
      println(s"Result: $result")
    } catch {
      case e: IllegalArgumentException => println(s"Error: ${e.getMessage}")
    }
  }
}
