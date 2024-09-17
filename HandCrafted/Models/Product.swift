import Foundation

import Foundation

// Модель для размера
struct Size: Codable, Hashable {
    let name: String
    let isInStock: Bool
    let isInSale: Bool
    let list: [String]
}

// Модель для цены
struct Price: Codable, Hashable {
    let standard: Int
    let sale: Int?
}

// Модель цвета
struct ProductColor: Codable, Hashable {
    let name: String
    let list: [String]
}

// Модель продукта
struct Product: Codable, Hashable, Identifiable {
    
    var id = UUID()
    let categoryName: String
    let name: String
    let fabric: String
    let composition: String
    let color: ProductColor
    var sizes: [Size]
    let description: String
    var imageUrls: [String]?
    let price: Price
    
    var isFavorite: Bool
    var isSale: Bool
}
