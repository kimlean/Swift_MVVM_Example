import Foundation

class UserViewModel {
    var onUsersUpdated: (() -> Void)?
    
    private(set) var users: [User] = [] {
        didSet {
            onUsersUpdated?()
        }
    }
    
    private var userService: UserService
    
    init(userService: UserService = UserService.shared) {
        self.userService = userService
    }
    
    // Fetch users from API
    func loadUsers() {
        userService.fetchUsers { [weak self] result in
            switch result {
            case .success(let users):
                self?.users = users
            case .failure(let error):
                print("Failed to fetch users: \(error)")
            }
        }
    }
    
    // Add a new user
    func addUser(name: String, email: String) {
        userService.createUser(name: name, email: email) { [weak self] result in
            switch result {
            case .success(let user):
                self?.users.append(user)
            case .failure(let error):
                print("Failed to create user: \(error)")
            }
        }
    }
    
    // Delete a user by ID
    func deleteUser(userId: Int) {
        userService.deleteUser(userId: userId) { [weak self] result in
            switch result {
            case .success:
                self?.users.removeAll { $0.id == userId }
            case .failure(let error):
                print("Failed to delete user: \(error)")
            }
        }
    }
}
