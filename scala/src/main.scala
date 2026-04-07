object Main {
  def add(a: Int, b: Int): Int = a + b

  def divide(a: Int, b: Int): Option[Double] = {
    if (b == 0) None else Some(a.toDouble / b)
  }

  def main(args: Array[String]): Unit = {
    println("Hello from Scala SonarQube example!")

    val resultAdd = add(5, 3)
    println(s"5 + 3 = $resultAdd")

    divide(10, 0) match {
      case Some(res) => println(s"Result: $res")
      case None => println("Error: Division by zero")
    }
  }
}
