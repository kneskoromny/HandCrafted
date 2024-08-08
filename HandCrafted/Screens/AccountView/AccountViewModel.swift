import FirebaseAnalytics
import SwiftUI

final class AccountViewModel: ObservableObject {
    
    enum AccountState {
        case auth, unAuth
    }
    // TODO: исправить на SwiftData
    @AppStorage("user") private var userData: Data?
    
    @Published var user = User()
    @Published var alertItem: AlertItem?
    @Published var accountState: AccountState = .unAuth
    @Published var isLoading = false
    
    var isValidForm: Bool {
        guard !user.firstName.isEmpty && !user.lastName.isEmpty && !user.email.isEmpty else {
            alertItem = AlertContext.invalidForm
            return false
        }
        guard user.email.isValidEmail else {
            alertItem = AlertContext.invalidEmail
            return false
        }
        return true
    }
    
    func saveChanges() {
        Analytics.logEvent(AnalyticsEventSelectContent, parameters: [
          AnalyticsParameterItemID: "id- testId",
          AnalyticsParameterItemName: "testId",
          AnalyticsParameterContentType: "cont",
        ])
        guard isValidForm else {
            return
        }
        do {
            let data = try JSONEncoder().encode(user)
            userData = data
            alertItem = AlertContext.userSaveSuccess
        } catch {
            alertItem = AlertContext.invalidUserData
        }
    }
    
    func checkAccountState() {
        guard let userData else {
            return
        }
        do {
            user = try JSONDecoder().decode(User.self, from: userData)
            accountState = .auth
        } catch {
            alertItem = AlertContext.invalidUserData
        }
    }
    
    func retrieveUser() {
        guard let userData else {
//            alertItem = AlertContext.invalidUserData
            return
        }
        do {
            user = try JSONDecoder().decode(User.self, from: userData)
            
        } catch {
            alertItem = AlertContext.invalidUserData
        }
    }
    
}

