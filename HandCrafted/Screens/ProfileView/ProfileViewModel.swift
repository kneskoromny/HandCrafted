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
    
    private let authManager = AuthManager()
    private let dbManager = DatabaseManager()
    
    init() {
        accountState = authManager.isAuthorizedUser ? .auth : .unAuth
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
        authManager.login(
            withEmail: loginData.email,
            password: loginData.password) { [weak self] error in
                guard let self else { return }
                if error == nil {
                    self.dbManager.getUser { user in
                        self.isLoading = false
                        if let user {
                            self.user = user
                            self.accountState = .auth
                        } else {
                            self.alertItem = AlertContext.invalidUserData
                        }
                    }
                } else {
                    self.isLoading = false
                    // TODO: Обработать ошибки Firebase
                    self.alertItem = AlertContext.invalidResponse
                }
            }
    }
    
    func logoutUser() {
        isLoading = true
        authManager.logout { [weak self] error in
            guard let self else { return }
            isLoading = false
            if error == nil {
                self.user = User()
                self.loginData = LoginData()
                self.accountState = .unAuth
            } else {
                // TODO: Обработать ошибки Firebase
                self.alertItem = AlertContext.invalidResponse
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
    
    func getUser() {
        isLoading = true
        dbManager.getUser { [weak self] user in
            self?.isLoading = false
            if let user {
                self?.user = user
            } else {
                self?.alertItem = AlertContext.invalidUserData
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
