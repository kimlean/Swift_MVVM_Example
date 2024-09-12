import Foundation

class UserService {
    
    // Singleton instance (optional)
    static let shared = UserService()
    
    // Fetch users using the GET request
    func fetchUsers(completion: @escaping (Result<[User], Error>) -> Void) {
        let url = URL(string: "https://jsonplaceholder.typicode.com/users")!
        
        NetworkHelper.shared.get(url: url, completion: completion)
    }
    
    // Create a user using the POST request
    func createUser(name: String, email: String, completion: @escaping (Result<User, Error>) -> Void) {
        let url = URL(string: "https://jsonplaceholder.typicode.com/users")!
        let body: [String: Any] = ["name": name, "email": email]
        
        NetworkHelper.shared.post(url: url, body: body, completion: completion)
    }
    
    // Delete a user using the DELETE request
    func deleteUser(userId: Int, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = URL(string: "https://jsonplaceholder.typicode.com/users/\(userId)")!
        
        NetworkHelper.shared.delete(url: url, completion: completion)
    }
}
