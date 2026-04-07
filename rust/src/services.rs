//! Services module - Business logic layer
//! Code smells: global mutable state, expect() abuse

use crate::models::{Order, Product, User};
use std::collections::HashMap;
use std::sync::Mutex;

// Code smell: global mutable state
static USER_SERVICE_STORAGE: Mutex<Vec<User>> = Mutex::new(Vec::new());
static PRODUCT_SERVICE_STORAGE: Mutex<Vec<Product>> = Mutex::new(Vec::new());

pub struct UserService {}

impl UserService {
    pub fn new() -> Self {
        UserService {}
    }

    pub fn create_user(&self, username: &str, email: &str) -> User {
        let user = User::new(username, email);
        let mut storage = USER_SERVICE_STORAGE.lock().expect("Lock poisoned");
        storage.push(user.clone());
        user
    }

    pub fn find_user(&self, id: u64) -> Option<User> {
        let storage = USER_SERVICE_STORAGE.lock().expect("Lock poisoned");
        storage.iter().find(|u| u.id == id).cloned()
    }

    pub fn all_users(&self) -> Vec<User> {
        let storage = USER_SERVICE_STORAGE.lock().expect("Lock poisoned");
        storage.clone()
    }
}

pub struct ProductService {}

impl ProductService {
    pub fn new() -> Self {
        ProductService {}
    }

    pub fn create_product(&self, name: &str, price: f64) -> Product {
        let product = Product::new(name, price);
        let mut storage = PRODUCT_SERVICE_STORAGE.lock().expect("Lock poisoned");
        storage.push(product.clone());
        product
    }

    pub fn find_product(&self, id: u64) -> Option<Product> {
        let storage = PRODUCT_SERVICE_STORAGE.lock().expect("Lock poisoned");
        storage.iter().find(|p| p.id == id).cloned()
    }
}

pub struct OrderService {
    orders: HashMap<u64, Order>,
}

impl OrderService {
    pub fn new() -> Self {
        OrderService {
            orders: HashMap::new(),
        }
    }

    pub fn create_order(&mut self, user_id: u64, product_ids: Vec<u64>, total: f64) -> Order {
        let order = Order::new(user_id, product_ids, total);
        self.orders.insert(order.id, order.clone());
        order
    }

    pub fn get_order(&self, id: u64) -> Option<&Order> {
        self.orders.get(&id)
    }
}