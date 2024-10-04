import SwiftUI

final class OrderItem: Identifiable, ObservableObject {
    
    let product: Product
    @Published var quantity: Int
    @Published var totalPrice: Int = 0
    
    lazy var onePiecePrice: Int = {
        if
            let _ = product.selectedSize?.isInSale,
            let salePrice = product.price.sale {
            return salePrice
        } else {
            return product.price.standard
        }
    }()
    
    init(product: Product, quantity: Int) {
        self.product = product
        self.quantity = quantity
        self.totalPrice = onePiecePrice
    }
    
}

struct OrderItemDto: Codable {
    
    let product: Product
    let quantity: Int
}
