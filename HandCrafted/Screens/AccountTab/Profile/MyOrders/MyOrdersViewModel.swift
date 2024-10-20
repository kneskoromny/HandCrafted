import SwiftUI

final class MyOrdersViewModel: ObservableObject {
    
    @Published var isLoading = false
    
    var orders: [Order] = []
    
    private let dbManager = DatabaseManager()
    
    func getOrders() {
        isLoading = true
        Task {
            do {
                let orders = try await dbManager.getOrderList()
                
                await MainActor.run {
                    self.isLoading = false
                    self.orders = orders
                }
            } catch {
                print(#function, "mytest - error: \(error.localizedDescription)")
            }
        }
    }
    
}
