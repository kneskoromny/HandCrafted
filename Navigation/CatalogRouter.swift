import SwiftUI

final class CatalogRouter: ObservableObject {
    
    public enum Destination: Codable, Hashable {
        case list(_ productList: [Product])
        case detail(_ product: Product)
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

