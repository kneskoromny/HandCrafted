import FirebaseAnalytics
import SwiftUI

enum AccountState {
    case auth, unAuth
}

final class ProfileViewModel: ObservableObject {
    
    // TODO: хранить польз данные для использования на разных экранах
    @AppStorage("user") private var userData: Data?
    
    
    @Published var user:  User?
    @Published var alertItem: AlertItem?
    @Published var isLoading = false
    
    var ordersCount: Int = 0
    
    private let authManager = AuthManager()
    private let dbManager = DatabaseManager()
    private let storageManager = StorageManager()
    
    func logoutUser(completion: (() -> Void)?) {
        isLoading = true
        Task {
            do {
                try await authManager.logout()
                await MainActor.run {
                    isLoading = false
                    self.user = nil
                    completion?()
                }
            } catch {
                print(#function, "mytest - error: \(error)")
            }
        }
    }
    
    func getUserInfo() {
        isLoading = true
        Task {
            do {
                let user = try await dbManager.getUser()
                let ordersCount = try await dbManager.getOrdersCount()
                
                await MainActor.run {
                    self.isLoading = false
                    if let user {
                        self.user = user
                    } else {
                        self.alertItem = AlertContext.invalidUserData
                    }
                    self.ordersCount = ordersCount
                }
            } catch {
                print(#function, "mytest - error: \(error.localizedDescription)")
            }
        }
    }
    
    func sendPasswordReset(completion: @escaping () -> Void) {
//        isLoading = true
//        authManager.sendPasswordReset(withEmail: loginData.email) { [weak self] error in
//            self?.isLoading = false
//            if error == nil {
//                completion()
//            } else {
//                // TODO: Обработать ошибки Firebase
//                self?.alertItem = AlertContext.invalidResponse
//            }
//        }
    }
    
}
