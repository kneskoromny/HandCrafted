import Foundation

struct Product: Codable, Hashable {
    
    let categoryName: String
    let name: String
    let fabric: String
    let color: String
    let size: String
    let description: String
    var imageUrl: String?
    let price: Int
    
    var isFavorite: Bool
    var isSale: Bool
    
}
