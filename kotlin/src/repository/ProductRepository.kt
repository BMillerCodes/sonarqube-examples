package com.example.repository

import com.example.model.Product

class ProductRepository {
    private val products = mutableListOf<Product>()

    fun findById(id: Long): Product? {
        return products.find { it.id == id }
    }

    fun findAll(): List<Product> {
        return products.toList()
    }

    fun save(product: Product) {
        val index = products.indexOfFirst { it.id == product.id }
        if (index >= 0) {
            products[index] = product
        } else {
            products.add(product)
        }
    }

    fun delete(id: Long) {
        products.removeIf { it.id == id }
    }
}
