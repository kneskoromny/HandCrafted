import FirebaseAnalytics
import SwiftUI

final class ProfileViewModel: ObservableObject {
    
    enum AccountState {
        case auth, unAuth
    }
    // TODO: хранить польз данные для использования на разных экранах
    @AppStorage("user") private var userData: Data?
    
    @Published var loginData = LoginData()
    @Published var user = User()
    @Published var alertItem: AlertItem?
    @Published var accountState: AccountState = .unAuth
    @Published var isLoading = false
    
    var orders: [Order] = []
    
    private let authManager = AuthManager()
    private let dbManager = DatabaseManager()
    private let storageManager = StorageManager()
    
    init() {
        accountState = authManager.isAuthUser ? .auth : .unAuth
    }
    
    func registerUser()  {
        isLoading = true
        authManager.register(
            withEmail: loginData.email,
            password: loginData.password) { [weak self] error in
                guard let self else { return }
                if error == nil {
                    print(#function, "mytest - success")
                    user = User(
                        email: loginData.email,
                        password: loginData.password
                    )
                    self.dbManager.saveUser(self.user) { error in
                        self.isLoading = false
                        if error == nil {
                            self.accountState = .auth
                        } else {
                            // TODO: Обработать ошибки Firebase
                            self.alertItem = AlertContext.invalidResponse
                        }
                    }
                } else {
                    self.isLoading = false
                    // TODO: Обработать ошибки Firebase
                    self.alertItem = AlertContext.invalidResponse
                }
            }
    }
    
    func loginUser() {
        isLoading = true
        Task {
            do {
                let _ = try await authManager.login(
                    withEmail: loginData.email,
                    password: loginData.password
                )
                let user = try await dbManager.getUser()
                await MainActor.run {
                    self.isLoading = false
                    if let user {
                        self.user = user
                        self.accountState = .auth
                    } else {
                        self.alertItem = AlertContext.invalidUserData
                    }
                }
            } catch {
                print(#function, "mytest - error: \(error)")
            }
        }
    }
    
    func logoutUser() {
        isLoading = true
        Task {
            do {
                try await authManager.logout()
                await MainActor.run {
                    isLoading = false
                    self.user = User()
                    self.loginData = LoginData()
                    self.accountState = .unAuth
                }
            } catch {
                print(#function, "mytest - error: \(error)")
            }
        }
    }
    
    func saveUser() {
        isLoading = true
        dbManager.saveUser(user) { [weak self] error in
            self?.isLoading = false
            if error == nil {
                print(#function, "mytest - success")
                self?.alertItem = AlertContext.userSaveSuccess
            } else {
                // TODO: Обработать ошибки Firebase
                self?.alertItem = AlertContext.invalidResponse
            }
        }
        //        Analytics.logEvent(AnalyticsEventSelectContent, parameters: [
        //          AnalyticsParameterItemID: "id- testId",
        //          AnalyticsParameterItemName: "testId",
        //          AnalyticsParameterContentType: "cont",
        //        ])
    }
    
    func getUserInfo() {
        isLoading = true
        Task {
            do {
                let user = try await dbManager.getUser()
                let orders = try await dbManager.getOrderList()
                
                await MainActor.run {
                    self.isLoading = false
                    if let user {
                        self.user = user
                    } else {
                        self.alertItem = AlertContext.invalidUserData
                    }
                    self.orders = orders
                }
            } catch {
                print(#function, "mytest - error: \(error.localizedDescription)")
            }
        }
    }
    
    func saveAvatar(data: Data?) {
        isLoading = true
        storageManager.saveAvatar(data: data) { [weak self] result in
            guard let self else { return }
            self.isLoading = false
            switch result {
            case .success(let urlString):
                self.user.avatarUrl = urlString
                self.saveUser()
            case .failure(let error):
                // TODO: Обработать ошибки Firebase
                self.alertItem = AlertContext.invalidResponse
            }
            
        }
    }
    
    func sendPasswordReset(completion: @escaping () -> Void) {
        isLoading = true
        authManager.sendPasswordReset(withEmail: loginData.email) { [weak self] error in
            self?.isLoading = false
            if error == nil {
                completion()
            } else {
                // TODO: Обработать ошибки Firebase
                self?.alertItem = AlertContext.invalidResponse
            }
        }
    }
    
}
