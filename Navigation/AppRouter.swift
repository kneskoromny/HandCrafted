import SwiftUI

final class AppRouter: ObservableObject {
    
    @Published var navPath = NavigationPath()
    @Published var selectedTab: Tab = .account

    public enum Tab: Hashable {
        case catalog
        case cart
        case account
    }

    func navigate(to destination: AppDestination) {
        navPath.append(destination)
    }
    
    func navigateBack() {
        navPath.removeLast()
    }
    
    func navigateToRoot() {
        navPath.removeLast(navPath.count)
    }
    
    func switchTab(to tab: Tab) {
        if selectedTab != tab {
            navPath = NavigationPath()
        }
        selectedTab = tab
    }
    
}
