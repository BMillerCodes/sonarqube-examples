//! Models module - Data structures for the application
//! Code smells: clone() overuse, expect() abuse

use std::sync::atomic::{AtomicU64, Ordering};

static NEXT_ID: AtomicU64 = AtomicU64::new(1);

#[derive(Debug, Clone)]
pub struct User {
    pub id: u64,
    pub username: String,
    pub email: String,
    pub active: bool,
}

impl User {
    pub fn new(username: &str, email: &str) -> Self {
        let id = NEXT_ID.fetch_add(1, Ordering::Relaxed);
        User {
            id,
            username: username.to_string(),
            email: email.to_string(),
            active: true,
        }
    }

    pub fn deactivate(&mut self) {
        self.active = false;
    }

    pub fn get_display_name(&self) -> String {
        // Code smell: clone() on String unnecessarily
        format!("{} ({})", self.username.clone(), self.email.clone())
    }
}

#[derive(Debug, Clone)]
pub struct Product {
    pub id: u64,
    pub name: String,
    pub price: f64,
    pub in_stock: bool,
}

impl Product {
    pub fn new(name: &str, price: f64) -> Self {
        let id = NEXT_ID.fetch_add(1, Ordering::Relaxed);
        Product {
            id,
            name: name.to_string(),
            price,
            in_stock: true,
        }
    }

    pub fn apply_discount(&mut self, discount: f64) {
        self.price = (self.price - discount).abs();
    }
}

#[derive(Debug, Clone)]
pub struct Order {
    pub id: u64,
    pub user_id: u64,
    pub product_ids: Vec<u64>,
    pub total: f64,
    pub status: OrderStatus,
}

#[derive(Debug, Clone)]
pub enum OrderStatus {
    Pending,
    Confirmed,
    Shipped,
    Delivered,
}

impl Order {
    pub fn new(user_id: u64, product_ids: Vec<u64>, total: f64) -> Self {
        let id = NEXT_ID.fetch_add(1, Ordering::Relaxed);
        Order {
            id,
            user_id,
            product_ids,
            total,
            status: OrderStatus::Pending,
        }
    }

    pub fn confirm(&mut self) {
        self.status = OrderStatus::Confirmed;
    }

    pub fn ship(&mut self) {
        // Code smell: expect() instead of proper error handling
        if let OrderStatus::Confirmed = self.status {
            self.status = OrderStatus::Shipped;
        } else {
            panic!("Order must be confirmed before shipping!");
        }
    }
}