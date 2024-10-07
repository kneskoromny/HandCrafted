import Foundation

struct Order: Codable, Hashable, Identifiable  {
    
    let id: String
    let userId: String
    let status: Int
    var totalPrice: Int
    var date: String
    
    let items: [OrderItem]
    
}
