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
        self.reCalculatePrice()
//        self.totalPrice = onePiecePrice
    }
    
    func reCalculatePrice() {
        if quantity == 1 {
            totalPrice = onePiecePrice
        } else {
            let calculatedPrice = product.price.standard * (quantity - 1)
            totalPrice = onePiecePrice + calculatedPrice
        }
    }
    
}

struct OrderItemDto: Codable {
    
    let product: Product
    let quantity: Int
}
