import FirebaseAnalytics
import SwiftUI

enum AccountState {
    case auth, unAuth
}

final class ProfileViewModel: ObservableObject {
    
    struct UserData {
        var name: String = ""
        var email: String = ""
        var ordersCount: Int = 0
    }
    
    @Published var userData = UserData()
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
                    self.userData = UserData()
                    self.dbManager.removeLocalUser()
                    completion?()
                }
            } catch {
                print(#function, "mytest - error: \(error)")
            }
        }
    }
    
    func getUser() {
        isLoading = true
        Task {
            do {
                let user = try await dbManager.getUser()
                let ordersCount = try await dbManager.getOrdersCount()
                
                await MainActor.run {
                    self.isLoading = false
                    if let user {
                        self.userData.name = user.name
                        self.userData.email = user.email
                        self.userData.ordersCount = ordersCount
                    } else {
                        self.alertItem = AlertContext.invalidUserData
                    }
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
