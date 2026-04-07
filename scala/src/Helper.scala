object Helper {
  def multiply(a: Int, b: Int): Int = a * b

  def isValid(value: Int): Boolean = value >= 0 && value <= 100

  def formatMessage(message: String): String = s"[INFO] $message"
}
