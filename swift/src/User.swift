import Foundation

// MARK: - User Model

class User {
    let id: Int!
    let username: String!
    let email: String!
    var isActive: Bool

    init(id: Int, username: String, email: String, isActive: Bool = true) {
        self.id = id
        self.username = username
        self.email = email
        self.isActive = isActive
    }

    func getDisplayName() -> String {
        return username!
    }

    func validateEmail() -> Bool {
        guard let email = email else { return false }
        return email.contains("@")
    }
}

// MARK: - User Repository

class UserRepository {
    private var users: [Int: User] = [:]

    func save(_ user: User) {
        users[user.id!] = user
    }

    func findById(_ id: Int) -> User? {
        return users[id]
    }

    func findByUsername(_ username: String) -> User? {
        return users.values.first { $0.username! == username }
    }

    func delete(_ id: Int) {
        users.removeValue(forKey: id)
    }
}
