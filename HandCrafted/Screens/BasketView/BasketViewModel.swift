import SwiftUI

final class BasketViewModel: ObservableObject {
    // TODO: продолжить с дебага сохраненных товаров
    // не сохраняется кол-во товара из корзины
    // неправильная общая цена в сохраненном товаре (если несколько)
    @AppStorage("savedOrderItems") var savedOrderItems: [OrderItemDto]?
    
    @Published var orderItems: [OrderItem] = []
    
    @Published var isLoading = false
    @Published var isAlertPresented = false
    
    var selectedItem: OrderItem?
    
    init() {
        if let savedOrderItems {
            let orderItems = savedOrderItems.map { 
                OrderItem(product: $0.product, quantity: $0.quantity)
            }
            self.orderItems = orderItems
            orderItems.forEach { item in
                print(#function, "mytest - init item: \(item.product.name), quantity: \(item.quantity)")
            }
        } else {
            print(#function, "mytest - order items not found")
        }
    }
    
    func increaseQuantity() {
        guard 
            let selectedItem,
            let orderItem = orderItems
            .first(where: {
                $0.product == selectedItem.product
            })
        else {
            print(#function, "mytest - orderItem not found")
            return
        }
        orderItem.quantity += 1
        print(#function, "mytest - item: \(orderItem.product.name), quantity: \(orderItem.quantity)")
        // TODO: перезаписать в AppStorage
    }
    
    func reduceQuantity() {
        guard
            let selectedItem,
            let orderItem = orderItems
            .first(where: {
                $0.product == selectedItem.product
            })
        else {
            print(#function, "mytest - orderItem not found")
            return
        }
        orderItem.quantity -= 1
        print(#function, "mytest - item: \(orderItem.product.name), quantity: \(orderItem.quantity)")
        // TODO: перезаписать в AppStorage
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
        let item = OrderItem(product: product, quantity: 1)
        orderItems.append(item)
        orderItems.forEach { item in
            print(#function, "mytest - item: \(item.product.name), quantity: \(item.quantity)")
        }
    }
    
    func removeOrderItem() {
        guard 
            let selectedItem,
            let index = orderItems
            .firstIndex(where: { 
                $0.product == selectedItem.product
            }) else {
            print(#function, "mytest - orderItem not found")
            return
        }
        let item = orderItems[index]
        orderItems.remove(at: index)
        print(#function, "mytest - removing product: \(item.product.name), quantity: \(item.quantity), index: \(index)")
        self.selectedItem = nil
    }
    
    func removeAllProducts() {
        orderItems.removeAll()
    }
    
    func saveOrderItems() {
        guard !orderItems.isEmpty else {
            return
        }
        if savedOrderItems?.isEmpty == false {
            savedOrderItems?.removeAll()
        }
        let savedOrderItems = orderItems.compactMap {
            OrderItemDto(product: $0.product, quantity: $0.quantity)
        }
        self.savedOrderItems = savedOrderItems
        print(#function, "mytest - save \(savedOrderItems.count) items")
    }
    
}
