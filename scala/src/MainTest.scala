object MainTest {
  def main(args: Array[String]): Unit = {
    val result = Main.add(2, 3)
    assert(result == 5, s"Expected 5, got $result")
    println("All tests passed!")
  }
}
