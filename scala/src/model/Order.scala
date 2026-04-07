package model

class Order(
  var id: Long,
  var userId: Long,
  var amount: Double,
  var description: String
) {
  var status: String = OrderStatus.PENDING
  var createdAt: Long = System.currentTimeMillis()
  var items: List[String] = List()
  
  def this() = this(0, 0, 0.0, "")
  
  def addItem(item: String): Unit = {
    items = items :+ item
  }
  
  def removeItem(item: String): Unit = {
    items = items.filter(_ != item)
  }
  
  def calculateTotal: Double = {
    amount
  }
  
  def isValid: Boolean = {
    amount > 0 && userId > 0 && !description.isEmpty
  }
  
  override def toString: String = s"Order(id=$id, userId=$userId, amount=$amount, status=$status)"
}

object OrderStatus {
  val PENDING = "PENDING"
  val PROCESSING = "PROCESSING"
  val COMPLETED = "COMPLETED"
  val CANCELLED = "CANCELLED"
}

object Order {
  def apply(id: Long, userId: Long, amount: Double, description: String): Order = {
    new Order(id, userId, amount, description)
  }
  
  def unapply(order: Order): Option[(Long, Long, Double, String)] = {
    Some((order.id, order.userId, order.amount, order.description))
  }
}
