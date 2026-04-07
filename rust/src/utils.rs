//! Utils module - Utility functions
//! Code smells: weak hashing, expect() abuse

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
/// Code smell: expect() instead of proper error handling
pub fn format_currency(amount: f64) -> String {
    format!("${:.2}", amount)
}

/// Truncate a string to a maximum length
pub fn truncate(s: &str, max_len: usize) -> String {
    if s.len() <= max_len {
        s.to_string()
    } else {
        format!("{}...", &s[..max_len])
    }
}