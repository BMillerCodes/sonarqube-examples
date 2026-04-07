package actor

import akka.actor.{Actor, Props, Stash}
import model.{Order, OrderStatus}

class OrderProcessingActor extends Actor with Stash {
  private var currentOrder: Option[Order] = None
  private var retryCount = 0
  private val MAX_RETRIES = 3
  
  override def receive: Receive = {
    case ProcessOrder(order) =>
      currentOrder = Some(order)
      retryCount = 0
      processOrder(order)
      
    case RetryProcess =>
      currentOrder.foreach { order =>
        if (retryCount < MAX_RETRIES) {
          retryCount += 1
          processOrder(order)
        } else {
          sender() ! OrderProcessingFailed(order.id, "Max retries exceeded")
          currentOrder = None
        }
      }
      
    case CancelProcessing =>
      currentOrder = None
      retryCount = 0
      unstashAll()
      context.become(receive)
  }
  
  private def processOrder(order: Order): Unit = {
    if (order.isValid) {
      order.status = OrderStatus.PROCESSING
      sender() ! OrderProcessingComplete(order)
    } else {
      sender() ! OrderProcessingFailed(order.id, "Invalid order")
    }
  }
}

case class ProcessOrder(order: Order)
case class OrderProcessingComplete(order: Order)
case class OrderProcessingFailed(orderId: Long, reason: String)
case object RetryProcess
case object CancelProcessing

object OrderProcessingActor {
  def props(): Props = Props[OrderProcessingActor]()
}
