import Foundation

class UserService {
    
    // Singleton pattern if needed (optional)
    static let shared = UserService()
    
    // Function to fetch users from a remote endpoint
    func fetchUsers(completion: @escaping (Result<[User], Error>) -> Void) {
        // Mock API endpoint
        let url = URL(string: "https://jsonplaceholder.typicode.com/users")!
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            // Error handling
            if let error = error {
                completion(.failure(error))
                return
            }
            
            // Ensure data is non-nil
            guard let data = data else {
                completion(.failure(NSError(domain: "DataError", code: -1, userInfo: nil)))
                return
            }
            
            // Decode the data into User objects
            do {
                let users = try JSONDecoder().decode([User].self, from: data)
                completion(.success(users))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume() // Start the network request
    }
}
