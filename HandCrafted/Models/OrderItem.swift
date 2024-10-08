import Foundation

struct OrderItem: Codable, Hashable, Identifiable {
    
    var id = UUID().uuidString
    let product: Product
    let quantity: Int
    
}
