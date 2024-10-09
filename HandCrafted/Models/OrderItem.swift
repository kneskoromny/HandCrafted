import Foundation

struct OrderItem: Codable, Hashable, Identifiable {
    
    var id = UUID().uuidString
    let product: Product
    let quantity: Int
    
}

extension OrderItem {
    
    private var onePiecePrice: Int {
        if
            let _ = product.selectedSize?.isInSale,
            let salePrice = product.price.sale {
            return salePrice
        } else {
            return product.price.standard
        }
    }
    
    var totalPrice: Int {
        if quantity == 1 {
            return onePiecePrice
        } else {
            let calculatedPrice = product.price.standard * (quantity - 1)
            return onePiecePrice + calculatedPrice
        }
    }
    
}
