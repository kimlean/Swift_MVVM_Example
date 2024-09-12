import Foundation

class NetworkHelper {
    
    // Singleton instance (optional)
    static let shared = NetworkHelper()
    
    // Function for GET request
    func get<T: Decodable>(url: URL, completion: @escaping (Result<T, Error>) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        executeRequest(request: request, completion: completion)
    }
    
    // Function for POST request
    func post<T: Decodable>(url: URL, body: [String: Any], completion: @escaping (Result<T, Error>) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
        } catch let error {
            completion(.failure(error))
            return
        }
        
        executeRequest(request: request, completion: completion)
    }
    
    // Function for DELETE request
    func delete(url: URL, completion: @escaping (Result<Void, Error>) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        executeRequest(request: request) { (result: Result<Data, Error>) in
            switch result {
            case .success(_):
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    // Generic function to execute any request
    private func executeRequest<T: Decodable>(request: URLRequest, completion: @escaping (Result<T, Error>) -> Void) {
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "DataError", code: -1, userInfo: nil)))
                return
            }
            
            // Decode the response data
            do {
                let decodedResponse = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedResponse))
            } catch let decodingError {
                completion(.failure(decodingError))
            }
        }
        task.resume()
    }
    
    // Overload for Void response type (used for DELETE)
    private func executeRequest(request: URLRequest, completion: @escaping (Result<Data, Error>) -> Void) {
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "DataError", code: -1, userInfo: nil)))
                return
            }
            
            completion(.success(data))
        }
        task.resume()
    }
}
