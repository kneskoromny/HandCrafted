import SwiftUI

final class AccountViewModel: ObservableObject {
    
    private let authManager = AuthManager()
    
    func getAccountState() -> AccountState {
        return authManager.isAuthUser ? .auth : .unAuth
    }
    
}
