import Foundation

struct Category: Codable, Hashable, Identifiable {
    
    var id = UUID()
    let name: String
    let description: String?
    let imageUrl: String?
    
}
