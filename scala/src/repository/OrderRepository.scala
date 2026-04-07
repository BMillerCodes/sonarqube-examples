package repository

import model.Order
import java.util.concurrent.ConcurrentHashMap
import scala.collection.JavaConverters._

class OrderRepository {
  private val orders = new ConcurrentHashMap[Long, Order]()
  
  def findById(id: Long): Option[Order] = {
    Option(orders.get(id))
  }
  
  def findByUserId(userId: Long): List[Order] = {
    orders.values().asScala.filter(_.userId == userId).toList
  }
  
  def findByStatus(status: String): List[Order] = {
    orders.values().asScala.filter(_.status == status).toList
  }
  
  def save(order: Order): Order = {
    orders.put(order.id, order)
    order
  }
  
  def update(order: Order): Order = {
    orders.put(order.id, order)
    order
  }
  
  def delete(id: Long): Boolean = {
    orders.remove(id) != null
  }
  
  def findAll(): List[Order] = {
    orders.values().asScala.toList
  }
  
  def count(): Int = {
    orders.size()
  }
  
  def clear(): Unit = {
    orders.clear()
  }
}
