import SwiftUI

final class BasketViewModel: ObservableObject {
    
    @Published var productList: [Product] = []
    @Published var isLoading: Bool = false
    
    
    
}
