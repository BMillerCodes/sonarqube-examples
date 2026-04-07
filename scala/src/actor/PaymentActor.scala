package actor

import akka.actor.{Actor, ActorRef, ActorSystem, Props}
import model.{Order, OrderStatus}

class PaymentActor extends Actor {
  private var processedCount = 0
  private var failedCount = 0
  private val processedOrders = scala.collection.mutable.ListBuffer[Long]()
  
  override def receive: Receive = {
    case ProcessPayment(order) =>
      try {
        if (order.amount <= 0) {
          throw new IllegalArgumentException("Invalid amount")
        }
        processedCount += 1
        processedOrders.append(order.id)
        sender() ! PaymentSuccess(order.id, order.amount)
      } catch {
        case e: Exception =>
          failedCount += 1
          sender() ! PaymentFailure(order.id, e.getMessage)
      }
      
    case GetStats =>
      sender() ! Stats(processedCount, failedCount, processedOrders.toList)
      
    case ResetStats =>
      processedCount = 0
      failedCount = 0
      processedOrders.clear()
  }
  
  override def postStop(): Unit = {
    println(s"PaymentActor stopped. Processed: $processedCount, Failed: $failedCount")
  }
}

case class ProcessPayment(order: Order)
case class PaymentSuccess(orderId: Long, amount: Double)
case class PaymentFailure(orderId: Long, error: String)
case object GetStats
case object ResetStats
case class Stats(processed: Int, failed: Int, orderIds: List[Long])

object PaymentActor {
  def props(): Props = Props[PaymentActor]()
  
  private var actorSystem: ActorSystem = _
  private var paymentActor: ActorRef = _
  
  def init(system: ActorSystem): ActorRef = {
    actorSystem = system
    paymentActor = system.actorOf(PaymentActor.props(), "payment-actor")
    paymentActor
  }
  
  def getActor: ActorRef = paymentActor
  
  def shutdown(): Unit = {
    if (actorSystem != null) {
      actorSystem.terminate()
      actorSystem = null
      paymentActor = null
    }
  }
}
