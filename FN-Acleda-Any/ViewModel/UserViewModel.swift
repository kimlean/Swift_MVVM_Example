import Foundation

class UserViewModel {
    // Closure to notify the ViewController when the data is updated
    var onUsersUpdated: (() -> Void)?
    
    // Store users in the ViewModel
    private(set) var users: [User] = [] {
        didSet {
            onUsersUpdated?()
        }
    }
    
    // Reference to the data service
    private var userService: UserService
    
    // Initialize the ViewModel with the service
    init(userService: UserService = UserService.shared) {
        self.userService = userService
    }
    
    // Fetch data from the API using UserService
    func loadUsers() {
        userService.fetchUsers { [weak self] result in
            switch result {
            case .success(let users):
                self?.users = users
            case .failure(let error):
                print("Failed to fetch users: \(error)")
                // Handle the error as necessary (e.g., show an alert)
            }
        }
    }
}
