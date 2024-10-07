import SwiftUI

// FIXME: Не работает
// при быстром сворачивании прил не успевает записать в дефолтс

// TODO: Не сделано
// настроить идентификатор заказа учитывая город и тд (более понятная форма)

final class BasketViewModel: ObservableObject {
    
    @AppStorage("savedOrderItems") var savedOrderItems: [OrderItem]?
    
    @Published var productItems: [ProductItem] = []
    @Published var totalPrice = 0
    @Published var isLoading = false
    @Published var isAlertPresented = false
    
    var alertType: AlertType?
    var selectedItem: ProductItem?
    
    var isAuthUser: Bool {
        return authManager.isAuthUser
    }
    
    // MARK: - Managers
    
    private let authManager = AuthManager()
    private let dbManager = DatabaseManager()
    
    init() {
        loadOrdersFromStorage()
        calculateTotalPrice()
    }
    
    func increaseQuantity() {
        guard 
            let selectedItem,
            let orderItem = productItems
            .first(where: {
                $0.product == selectedItem.product
            })
        else {
            print(#function, "mytest - orderItem not found")
            return
        }
        orderItem.quantity += 1
        orderItem.calculatePrice()
        print(#function, "mytest - item: \(orderItem.product.name), quantity: \(orderItem.quantity)")
        // TODO: перезаписать в AppStorage
    }
    
    func reduceQuantity() {
        guard
            let selectedItem,
            let orderItem = productItems
            .first(where: {
                $0.product == selectedItem.product
            })
        else {
            print(#function, "mytest - orderItem not found")
            return
        }
        orderItem.quantity -= 1
        orderItem.calculatePrice()
        print(#function, "mytest - item: \(orderItem.product.name), quantity: \(orderItem.quantity)")
        // TODO: перезаписать в AppStorage
    }
    
    func addProduct(_ product: Product) {
        let item = ProductItem(product: product, quantity: 1)
        productItems.append(item)
        productItems.forEach { item in
            print(#function, "mytest - item: \(item.product.name), quantity: \(item.quantity)")
        }
    }
    
    func removeOrderItem() {
        guard 
            let selectedItem,
            let index = productItems
            .firstIndex(where: {
                $0.product == selectedItem.product
            }) else {
            print(#function, "mytest - orderItem not found")
            return
        }
        let item = productItems[index]
        productItems.remove(at: index)
        print(#function, "mytest - removing product: \(item.product.name), quantity: \(item.quantity), index: \(index)")
        self.selectedItem = nil
    }
    
    func saveOrderItems() {
        guard !productItems.isEmpty else {
            return
        }
        if savedOrderItems?.isEmpty == false {
            savedOrderItems?.removeAll()
        }
        let savedOrderItems = productItems.compactMap {
            OrderItem(
                product: $0.product,
                quantity: $0.quantity
            )
        }
        self.savedOrderItems = savedOrderItems
        print(#function, "mytest - save \(savedOrderItems.count) items")
    }
    
    func calculateTotalPrice() {
        self.totalPrice = productItems.reduce(0) { partialResult, item in
            item.totalPrice + partialResult
        }
    }
    
}

// MARK: - Network

extension BasketViewModel {
    
    func loadUser() {
        isLoading = true
        Task {
            do {
                let _ = try await dbManager.getUser()
                await MainActor.run {
                    self.isLoading = false
                }
            } catch {
                print(#function, "mytest - error: \(error.localizedDescription)")
            }
        }
    }
    
    func sendOrder() {
        guard 
            let user = dbManager.user,
            let orderId = getOrderId(user: user)
        else {
            print(#function, "mytest - no user")
            return
        }
        let orderItems = productItems
            .compactMap {
                OrderItem(
                    product: $0.product,
                    quantity: $0.quantity
                )
            }
        let date = Date().formatted(date: .numeric, time: .omitted)
        let order = Order(
            id: orderId,
            userId: user.id ?? "",
            status: OrderStatus.created.rawValue,
            totalPrice: totalPrice,
            date: date,
            items: orderItems
        )
        isLoading = true
        Task {
            do {
                try dbManager.saveOrder(order)
                await MainActor.run {
                    productItems.removeAll()
                    savedOrderItems = nil
                    selectedItem = nil
                    isLoading = false
                }
            } catch {
                print(#function, "mytest - error: \(error.localizedDescription)")
            }
        }
    }
}

// MARK: - Private Methods

private extension BasketViewModel {
   
    func loadOrdersFromStorage() {
        if let savedOrderItems {
            let productItems = savedOrderItems.map {
                ProductItem(product: $0.product, quantity: $0.quantity)
            }
            self.productItems = productItems
            productItems.forEach { item in
                print(#function, "mytest - init item: \(item.product.name), quantity: \(item.quantity)")
            }
        } else {
            print(#function, "mytest - stored order items not found")
        }
    }
    
    func getOrderId(user: User) -> String? {
        let converted = user.city?.replacingOccurrences(of: "\"", with: "").uppercased()
        // TODO: добавить год к айди заказа
        guard
            let orderNumber = (1...1000).randomElement(),
            let cityId = converted?.prefix(3) else {
            print(#function, "mytest - no user")
            return nil
        }
        return "\(cityId) - \(orderNumber)"
    }
}
