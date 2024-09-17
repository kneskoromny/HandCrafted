import Foundation

struct Category: Codable, Hashable, Identifiable {
    
    var id: Int
    let name: String
    let description: String?
    let imageUrl: String?
    
}
