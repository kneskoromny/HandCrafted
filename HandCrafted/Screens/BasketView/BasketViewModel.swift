import SwiftUI

final class BasketViewModel: ObservableObject {
    
    @Published var orderItems: [OrderItem]
    
    @Published var isLoading = false
    @Published var isAlertPresented = false
    
    init(orderItems: [OrderItem]) {
        self.orderItems = orderItems
    }
    
    func increaseQuantity(orderItem: OrderItem) {
        guard let orderItem = orderItems
            .first(where: {$0.product == orderItem.product })
        else {
            return
        }
        orderItem.quantity += 1
    }
    
    func reduceQuantity(orderItem: OrderItem) {
        guard let orderItem = orderItems
            .first(where: {$0.product == orderItem.product })
        else {
            return
        }
        orderItem.quantity -= 1
    }
    
    func calculatePrice(orderItem: OrderItem) {
        guard let orderItem = orderItems
            .first(where: {$0.product == orderItem.product })
        else {
            return
        }
        if orderItem.quantity == 1 {
            orderItem.totalPrice = orderItem.onePiecePrice
        } else {
            let onePiecePrice = orderItem.onePiecePrice
            let calculatedPrice = orderItem.product.price.standard * (orderItem.quantity - 1)
            orderItem.totalPrice = onePiecePrice + calculatedPrice
        }
    }
    
    func addProduct(_ product: Product) {
        let item = OrderItem(product: product)
        orderItems.append(item)
    }
    
    func removeOrderItem(_ item: OrderItem) {
        guard let index = orderItems
            .firstIndex(where: { $0.product == item.product }) else {
            return
        }
        orderItems.remove(at: index)
        print(#function, "mytest - items count: \(orderItems.count)")

    }
    
    func removeAllProducts() {
        orderItems.removeAll()
    }
    
}
