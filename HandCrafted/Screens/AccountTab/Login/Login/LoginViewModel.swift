import SwiftUI

final class LoginViewModel: ObservableObject {
    
    struct LoginData {
        var email = ""
        var password = ""
        var confirmPassword = ""
    }
    
    struct ErrorData {
        var email = ""
        var password = ""
        var confirmPassword = ""
    }
    
    @Published var loginData = LoginData()
    @Published var errorData = ErrorData()
    @Published var isLoading = false
    @Published var isDisabled = false
    
    private let authManager = AuthManager()
    private let dbManager = DatabaseManager()
    
    func getAccountState() -> AccountState {
        return authManager.isAuthUser ? .auth : .unAuth
    }
    
    func loginUser(completion: (() -> Void)?) {
        isLoading = true
        Task {
            do {
                let _ = try await authManager.login(
                    withEmail: loginData.email,
                    password: loginData.password
                )
                if let _ = try await dbManager.getUser() {
                    await MainActor.run {
                        self.isLoading = false
                        completion?()
                    }
                } else {
                    print(#function, "mytest - get db user error")
                }
            } catch {
                print(#function, "mytest - login error: \(error)")
            }
        }
    }
    
}
