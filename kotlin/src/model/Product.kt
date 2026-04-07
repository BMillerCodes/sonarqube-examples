package com.example.model

data class Product(
    val id: Long,
    val name: String,
    val price: Double,
    var stock: Int = 0
)

class Order {
    lateinit var orderId: String
    lateinit var userId: String
    lateinit var items: List<Product>
    var totalAmount: Double = 0.0

    fun calculateTotal() {
        totalAmount = items!!.sumOf { it.price }
    }

    fun getOrderId(): String = orderId
}
