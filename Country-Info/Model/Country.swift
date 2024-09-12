import Foundation

// MARK: - Country
struct Country: Decodable {
    
    // MARK: - Country
    let name: NameDetails?
    let capital: [String]?
    let region: String?
    let population: Int?
}


/// MARK: - Name
struct NameDetails: Codable {
    let common, official: String?
}

