//! Models module - Data structures for the application
//! Code smells: clone() overuse, unwrap() abuse

pub mod models {
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
            // Code smell: using unwrap() on atomic load
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
            // Code smell: unwrap() on arithmetic that could fail
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
}

pub mod services {
    use crate::models::{Order, Product, User};
    use std::collections::HashMap;

    // Code smell: global mutable state
    static USER_SERVICE_STORAGE: std::sync::Mutex<Option<Vec<User>>> = std::sync::Mutex::new(None);
    static PRODUCT_SERVICE_STORAGE: std::sync::Mutex<Option<Vec<Product>>> = std::sync::Mutex::new(None);

    pub struct UserService {
        // Code smell: storing users in memory without proper cleanup
    }

    impl UserService {
        pub fn new() -> Self {
            UserService {}
        }

        pub fn create_user(&self, username: &str, email: &str) -> User {
            let user = User::new(username, email);
            // Code smell: unwrap() on mutex lock could panic
            let mut storage = USER_SERVICE_STORAGE.lock().unwrap();
            if let Some(ref mut users) = *storage {
                users.push(user.clone());
            } else {
                *storage = Some(vec![user.clone()]);
            }
            user
        }

        pub fn find_user(&self, id: u64) -> Option<User> {
            let storage = USER_SERVICE_STORAGE.lock().unwrap();
            if let Some(ref users) = *storage {
                users.iter().find(|u| u.id == id).cloned()
            } else {
                None
            }
        }

        pub fn all_users(&self) -> Vec<User> {
            let storage = USER_SERVICE_STORAGE.lock().unwrap();
            if let Some(ref users) = *storage {
                users.clone()
            } else {
                vec![]
            }
        }
    }

    pub struct ProductService {
        // Code smell: global mutable state
    }

    impl ProductService {
        pub fn new() -> Self {
            ProductService {}
        }

        pub fn create_product(&self, name: &str, price: f64) -> Product {
            let product = Product::new(name, price);
            let mut storage = PRODUCT_SERVICE_STORAGE.lock().unwrap();
            if let Some(ref mut products) = *storage {
                products.push(product.clone());
            } else {
                *storage = Some(vec![product.clone()]);
            }
            product
        }

        pub fn find_product(&self, id: u64) -> Option<Product> {
            let storage = PRODUCT_SERVICE_STORAGE.lock().unwrap();
            if let Some(ref products) = *storage {
                products.iter().find(|p| p.id == id).cloned()
            } else {
                None
            }
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
            // Code smell: expect() instead of handling potential issues
            self.orders.insert(order.id, order.clone());
            order
        }

        pub fn get_order(&self, id: u64) -> Option<&Order> {
            self.orders.get(&id)
        }
    }
}

pub mod utils {
    /// Validate email format
    /// Code smell: overly simplistic validation
    pub fn validate_email(email: &str) -> bool {
        email.contains('@') && email.contains('.')
    }

    /// Hash password using simple algorithm
    /// Code smell: weak hashing algorithm
    pub fn hash_password(password: &str) -> String {
        // Code smell: using unsafe conversion
        format!("{:x}", password.as_bytes().iter().fold(0u64, |acc, b| acc.wrapping_add(*b as u64)))
    }

    /// Format currency value
    /// Code smell: unwrap() on format
    pub fn format_currency(amount: f64) -> String {
        format!("${:.2}", amount)
    }
}