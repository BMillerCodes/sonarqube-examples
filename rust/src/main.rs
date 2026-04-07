//! SonarQube Rust Example - Real-world patterns with intentional code smells

mod models;
mod services;
mod utils;

use models::{User, Product, Order};
use services::{UserService, ProductService};
use std::sync::Mutex;

// Global mutable state (code smell: global mutable state)
static USER_CACHE: Mutex<Vec<User>> = Mutex::new(Vec::new());

fn main() {
    println!("SonarQube Rust Example");
    println!("=====================");

    // Create a user
    let user = User::new("johndoe", "john@example.com");
    println!("Created user: {:?}", user);

    // Create a product
    let product = Product::new("Laptop", 999.99);
    println!("Created product: {:?}", product);

    // Create an order
    let order = Order::new(user.id, vec![product.id], 999.99);
    println!("Created order: {:?}", order);

    // Demonstrate services
    let user_service = UserService::new();
    user_service.create_user("alice", "alice@example.com");

    let product_service = ProductService::new();
    product_service.create_product("Mouse", 29.99);

    println!("\nAll examples completed successfully!");
}