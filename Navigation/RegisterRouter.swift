import SwiftUI

final class RegisterRouter: ObservableObject {
    
    public enum Destination: Codable, Hashable {
        case signIn
        case forgotPassword
        case recoveryRequested
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
