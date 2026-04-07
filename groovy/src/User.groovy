/**
 * User domain class with validation
 * Code smell: unused variable tracking
 */
class User {
    Long id
    String username
    String email
    String password
    Date createdAt
    boolean active = true

    // Code smell: unused field
    int loginCount = 0
    int failedLoginAttempts = 0

    User() {
        this.createdAt = new Date()
    }

    User(Long id, String username, String email) {
        this()
        this.id = id
        this.username = username
        this.email = email
    }

    String getDisplayName() {
        return "${username} <${email}>"
    }

    boolean isValid() {
        return username && email && password
    }
}

/**
 * User service with CRUD operations
 * Code smell: unused loop variable
 */
class UserService {
    def users = [:]
    Long nextId = 1L

    Long createUser(String username, String email, String password) {
        def user = new User(nextId++, username, email)
        user.password = password
        users[user.id] = user
        return user.id
    }

    User getUser(Long id) {
        return users[id]
    }

    List<User> getAllUsers() {
        // Code smell: unused loop variable
        users.values().each { user ->
            println "User: ${user.username}"
        }
        return users.values().toList()
    }

    boolean updateUser(Long id, Map updates) {
        def user = users[id]
        if (!user) return false

        updates.each { key, value ->
            user[key] = value
        }
        return true
    }

    boolean deleteUser(Long id) {
        return users.remove(id) != null
    }
}

/**
 * User repository for data access
 * Code smell: empty catch blocks
 */
class UserRepository {
    def db = [:]

    void save(User user) {
        try {
            db[user.id] = user
        } catch (Exception e) {
            // Code smell: empty catch block
        }
    }

    User findById(Long id) {
        try {
            return db[id]
        } catch (Exception e) {
            // Code smell: empty catch block
            return null
        }
    }

    List<User> findAll() {
        try {
            return db.values().toList()
        } catch (Exception e) {
            // Code smell: empty catch block
            return []
        }
    }

    void delete(Long id) {
        try {
            db.remove(id)
        } catch (Exception e) {
            // Code smell: empty catch block
        }
    }
}