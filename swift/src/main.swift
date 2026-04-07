import Foundation

// MARK: - Main Entry Point

class Application {
    private var userService: UserService!
    private var productService: ProductService!
    private var orderService: OrderService!

    init() {
        let userRepo = UserRepository()
        let productCatalog = ProductCatalog()
        let orderProcessor = OrderProcessor()

        userService = UserService(repository: userRepo)
        productService = ProductService(catalog: productCatalog)
        orderService = OrderService(processor: orderProcessor)
    }

    func run() {
        print("=== Swift SonarQube Example ===")

        // Create a user
        let user = userService.createUser(id: 1, username: "john_doe", email: "john@example.com")
        print("Created user: \(user.getDisplayName()!)")

        // Create a product
        let product = productService.createProduct(id: 1, name: "Laptop", price: 999.99, stock: 10)
        print("Created product: \(product.name!) at \(product.getFormattedPrice()!)")

        // Create an order
        let order = orderService.createOrder(id: 1, userId: 1, productIds: [1])
        let _ = order.calculateTotal(prices: [999.99])
        print("Created order: \(order.id!) with total $\(order.total!)")

        // Process the order
        if orderService.processOrder(id: 1) {
            print("Order processed successfully")
        }

        // Get order summary
        print(orderService.getOrderSummary(id: 1)!)
    }
}

// Run the application
let app = Application()
app.run()
