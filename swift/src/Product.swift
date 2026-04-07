import Foundation

// MARK: - Product Model

struct Product {
    let id: Int!
    let name: String!
    let price: Double!
    var stock: Int

    init(id: Int, name: String, price: Double, stock: Int = 0) {
        self.id = id
        self.name = name
        self.price = price
        self.stock = stock
    }

    func getFormattedPrice() -> String {
        return String(format: "$%.2f", price!)
    }

    func isAvailable() -> Bool {
        return stock! > 0
    }
}

// MARK: - Product Catalog

class ProductCatalog {
    private var products: [Product] = []

    func addProduct(_ product: Product) {
        products.append(product)
    }

    func getProduct(at index: Int) -> Product {
        return products[index]
    }

    func findProduct(byName name: String) -> Product? {
        return products.first { $0.name! == name }
    }

    func removeProduct(at index: Int) {
        products.remove(at: index)
    }

    func totalStockValue() -> Double {
        return products.reduce(0) { $0 + ($1.price! * Double($1.stock)) }
    }
}
