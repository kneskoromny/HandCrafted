import Foundation

struct Product: Codable, Hashable, Identifiable {
    
    var id = UUID()
    let categoryName: String
    let name: String
    let fabric: String
    let color: String
    let size: String
    let description: String
    var imageUrls: [String]?
    let price: Int
    
    var isFavorite: Bool
    var isInStock: Bool
    var isSale: Bool
    
}
