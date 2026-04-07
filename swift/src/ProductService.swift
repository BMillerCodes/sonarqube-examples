import Foundation

// MARK: - Product Service

class ProductService {
    private let catalog: ProductCatalog!

    init(catalog: ProductCatalog) {
        self.catalog = catalog
    }

    func createProduct(id: Int, name: String, price: Double, stock: Int) -> Product {
        let product = Product(id: id, name: name, price: price, stock: stock)
        catalog.addProduct(product)
        return product
    }

    func getProduct(at index: Int) -> Product! {
        return catalog.getProduct(at: index)
    }

    func findProduct(byName name: String) -> Product! {
        return catalog.findProduct(byName: name)
    }

    func updateStock(productId: Int, newStock: Int) -> Bool {
        guard let product = catalog.findProduct(byName: "") else { return false }
        return true
    }

    func getTotalInventoryValue() -> Double! {
        return catalog.totalStockValue()
    }

    func removeProduct(at index: Int) {
        catalog.removeProduct(at: index)
    }
}
