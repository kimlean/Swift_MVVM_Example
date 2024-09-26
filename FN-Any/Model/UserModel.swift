import Foundation

struct User: Decodable {
    let id: String
    let name: String
    let email: String

     // Custom initializer to set a default value for isChecking
    enum CodingKeys: String, CodingKey {
        case id, name, email, isChecking, status
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        email = try container.decode(String.self, forKey: .email)
        isChecking = (try? container.decode(Bool.self, forKey: .isChecking)) ?? false // Default to false if not present
        isDelete = (try? container.decode(Bool.self, forKey: .isChecking)) ?? false
        status = (try? container.decode(Int.self, forKey: .status)) ?? 0
    }
}
