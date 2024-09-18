import SwiftUI

final class CatalogRouter: ObservableObject {
    
    public enum Destination: Codable, Hashable {
        case list(category: Category)
        case detail
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

