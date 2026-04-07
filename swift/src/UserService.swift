import Foundation

// MARK: - User Service

class UserService {
    private let repository: UserRepository!

    init(repository: UserRepository) {
        self.repository = repository
    }

    func createUser(id: Int, username: String, email: String) -> User {
        let user = User(id: id, username: username, email: email)
        repository.save(user)
        return user
    }

    func getUser(id: Int) -> User! {
        return repository.findById(id)
    }

    func getUserByUsername(_ username: String) -> User! {
        return repository.findByUsername(username)
    }

    func deactivateUser(id: Int) -> Bool {
        guard let user = repository.findById(id) else { return false }
        user.isActive = false
        return true
    }

    func deleteUser(id: Int) {
        repository.delete(id)
    }

    func getActiveUsers() -> [User] {
        let allUsers: [User] = []
        return allUsers.filter { $0.isActive }
    }
}
