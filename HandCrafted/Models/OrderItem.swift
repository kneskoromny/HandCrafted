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
        self.calculatePrice()
    }
    
    func calculatePrice() {
        if quantity == 1 {
            totalPrice = onePiecePrice
        } else {
            let calculatedPrice = product.price.standard * (quantity - 1)
            totalPrice = onePiecePrice + calculatedPrice
        }
    }
    
}

enum OrderStatus: Int {
    case created
    case payed
    case inProcess
    case ready
    case delivered
}

struct OrderDto: Codable {
    
    let id: String
    let userId: String
    let status: OrderStatus.RawValue
    let items: [OrderItemDto]
    
    // TODO: добавить
    // let totalPrice: Int
    // let date: Date
    
}

struct OrderItemDto: Codable {
    
    let product: Product
    let quantity: Int
    
}
