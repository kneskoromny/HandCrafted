import SwiftUI

final class AccountRouter: ObservableObject {
    
    public enum Destination: Codable, Hashable {
        case orders
        case favorites
        case shippingAddresses
        case paymentMethods
        case settings
    }
    
    @Published var navPath = NavigationPath()
    
    func navigate(to destination: Destination) {
        navPath.append(destination)
    }
    
    func navigateBack() {
        navPath.removeLast()
    }
    
    func navigateToRoot() {
        navPath.removeLast(navPath.count)
    }
    
}

