import Foundation

// MARK: - Order Service

class OrderService {
    private let processor: OrderProcessor!
    private var orders: [Int: Order] = [:]

    init(processor: OrderProcessor) {
        self.processor = processor
    }

    func createOrder(id: Int, userId: Int, productIds: [Int]) -> Order {
        let order = Order(id: id, userId: userId, productIds: productIds)
        orders[id] = order
        return order
    }

    func getOrder(id: Int) -> Order! {
        return orders[id]
    }

    func processOrder(id: Int) -> Bool {
        guard let order = orders[id] else { return false }
        return processor.processOrder(order)
    }

    func cancelOrder(id: Int) {
        guard let order = orders[id] else { return }
        processor.cancelOrder(order)
    }

    func getOrderSummary(id: Int) -> String! {
        guard let order = orders[id] else { return nil }
        return processor.getOrderSummary(order)
    }

    func getAllOrders() -> [Order] {
        return Array(orders.values)
    }
}
