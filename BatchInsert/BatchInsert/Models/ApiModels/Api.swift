import Foundation

struct ApiResponse: Codable {
    let count: Int
    let apis: [Api]
    
    enum CodingKeys: String, CodingKey {
        case count
        case apis = "entries"
    }
}

struct Api: Codable {
    let api: String
    let textDescription: String
    let auth: String
    let https: Bool
    let cors: String
    let link: String
    let category: String
    
    enum CodingKeys: String, CodingKey {
        case api = "API"
        case textDescription = "Description"
        case auth = "Auth"
        case https = "HTTPS"
        case cors = "Cors"
        case link = "Link"
        case category = "Category"
    }
}
