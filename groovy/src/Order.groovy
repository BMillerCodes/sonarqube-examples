/**
 * Order domain class
 */
class Order {
    Long id
    Long userId
    List<Long> itemIds
    Double totalAmount
    String status
    Date createdAt

    Order() {
        this.createdAt = new Date()
        this.status = 'PENDING'
    }

    Order(Long id, Long userId, Double totalAmount) {
        this()
        this.id = id
        this.userId = userId
        this.totalAmount = totalAmount
    }

    boolean isShippable() {
        return status == 'CONFIRMED'
    }

    String getSummary() {
        return "Order #${id}: ${totalAmount} (${status})"
    }
}

/**
 * Order service
 * Code smell: empty catch blocks, unused variables
 */
class OrderService {
    def orders = [:]
    Long nextId = 1L

    // Code smell: unused variable
    int maxOrderSize = 100

    Long createOrder(Long userId, List<Long> itemIds, Double total) {
        // Code smell: empty catch block
        try {
            if (!itemIds || itemIds.isEmpty()) {
                throw new IllegalArgumentException("Items cannot be empty")
            }
        } catch (Exception e) {
            // Code smell: empty catch block
        }

        def order = new Order(nextId++, userId, total)
        order.itemIds = itemIds
        orders[order.id] = order
        return order.id
    }

    Order getOrder(Long id) {
        return orders[id]
    }

    boolean confirmOrder(Long id) {
        def order = orders[id]
        if (!order) return false

        order.status = 'CONFIRMED'
        return true
    }

    boolean shipOrder(Long id) {
        def order = orders[id]
        if (!order) return false

        if (order.status != 'CONFIRMED') {
            return false
        }

        order.status = 'SHIPPED'
        return true
    }

    List<Order> getOrdersByUser(Long userId) {
        orders.values().findAll { it.userId == userId }
    }
}