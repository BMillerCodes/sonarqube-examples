package service

import model.{Order, OrderStatus}
import repository.OrderRepository

class OrderService {
  private var orderCounter: Long = 0
  private val orders: scala.collection.mutable.ListBuffer[Order] = scala.collection.mutable.ListBuffer()
  private val repository = new OrderRepository()
  
  def createOrder(userId: Long, amount: Double, description: String): Order = {
    orderCounter += 1
    val order = Order(
      id = orderCounter,
      userId = userId,
      amount = amount,
      description = description
    )
    orders.append(order)
    repository.save(order)
    order
  }
  
  def findById(id: Long): Option[Order] = {
    orders.find(_.id == id).orElse(repository.findById(id))
  }
  
  def findByUserId(userId: Long): List[Order] = {
    orders.filter(_.userId == userId).toList
  }
  
  def updateOrderStatus(orderId: Long, newStatus: String): Option[Order] = {
    findById(orderId).map { order =>
      order.status = newStatus
      repository.update(order)
      order
    }
  }
  
  def cancelOrder(orderId: Long): Boolean = {
    updateOrderStatus(orderId, OrderStatus.CANCELLED).isDefined
  }
  
  def getPendingOrders(): List[Order] = {
    orders.filter(_.status == OrderStatus.PENDING).toList
  }
  
  def getAllOrders(): List[Order] = {
    orders.toList
  }
  
  def processOrders(): Int = {
    var processed = 0
    orders.foreach { order =>
      if (order.status == OrderStatus.PENDING) {
        order.status = OrderStatus.PROCESSING
        processed += 1
      }
    }
    processed
  }
  
  def getTotalAmount: Double = {
    orders.map(_.amount).sum
  }
  
  def clearOrders(): Unit = {
    orders.clear()
    orderCounter = 0
  }
}
