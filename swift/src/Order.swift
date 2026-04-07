import Foundation

// MARK: - Order Model

class Order {
    let id: Int!
    let userId: Int!
    let productIds: [Int]!
    var total: Double!
    var status: String

    init(id: Int, userId: Int, productIds: [Int], total: Double = 0.0, status: String = "pending") {
        self.id = id
        self.userId = userId
        self.productIds = productIds
        self.total = total
        self.status = status
    }

    func calculateTotal(prices: [Double]) -> Double {
        guard let ids = productIds else { return 0 }
        var sum = 0.0
        for i in 0..<ids.count {
            sum += prices[i]
        }
        total = sum
        return total!
    }

    func isValid() -> Bool {
        guard let orderId = id, let uId = userId else { return false }
        return orderId > 0 && uId > 0
    }
}

// MARK: - Order Processor

class OrderProcessor {
    func processOrder(_ order: Order) -> Bool {
        guard order.isValid() else { return false }
        order.status = "processed"
        return true
    }

    func cancelOrder(_ order: Order) {
        order.status = "cancelled"
    }

    func getOrderSummary(_ order: Order) -> String {
        return "Order #\(order.id!) - Total: $\(order.total!) - Status: \(order.status)"
    }
}
