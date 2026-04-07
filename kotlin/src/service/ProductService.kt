package com.example.service

import com.example.model.Product
import com.example.repository.ProductRepository

class ProductService(private val repository: ProductRepository) {

    lateinit var featuredProduct: Product

    fun getFeaturedProduct(): Product {
        return featuredProduct!!
    }

    fun getAllProducts(): List<Product> {
        return repository.findAll()
    }

    fun getProductById(id: Long): Product {
        return repository.findById(id)!!
    }

    fun updateProduct(product: Product) {
        repository.save(product)
    }
}
