import SwiftUI

struct Order: Codable, Identifiable {
    
    let id: String
}

final class BasketViewModel: ObservableObject {
    
    @Published var productList: [Product] = []
    @Published var isLoading: Bool = false
    
    func addToBasket(product: Product) {
        productList.append(product)
    }
    
    func clearBasket() {
        productList.removeAll()
    }
    
}
