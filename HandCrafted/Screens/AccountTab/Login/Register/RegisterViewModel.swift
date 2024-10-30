import SwiftUI

final class RegisterViewModel: ObservableObject {
    
    struct RegisterData {
        
        var name: String = ""
        var birthDate: String = ""
        var city: String = ""
        var phone: String = ""
        var email: String = ""
        
        var password: String = ""
        var confirm: String = ""
        
        // TODO: оптимизировать
        var isFilled: Bool {
            return name != "" && birthDate != "" && city != "" && phone != "" && email != "" && password != "" && confirm != ""
        }
        
    }
    
    struct ErrorData {
        
        var name: String = ""
        var birthDate: String = ""
        var city: String = ""
        var phone: String = ""
        var email: String = ""
        
        var password: String = ""
        var confirm: String = ""
        
        // TODO: оптимизировать
        var isErrored: Bool {
            return name != "" || birthDate != "" || city != "" || phone != "" || email != "" || password != "" || confirm != ""
        }
        
    }
    
    @Published var registerData = RegisterData()
    @Published var errorData = ErrorData()
    @Published var isLoading = false
    @Published var isAlertPresented = false
    
    var isFormReady: Bool {
        return registerData.isFilled && !errorData.isErrored
    }
    
    private let authManager = AuthManager()
    private let dbManager = DatabaseManager()
    
    func registerUser(completion: (() -> Void)?)  {
        isLoading = true
        authManager.register(email: registerData.email, password: registerData.password) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let response):
                let user = User(
                    id: response.user.uid,
                    name: registerData.name,
                    birthDate: registerData.birthDate,
                    city: registerData.city,
                    phone: registerData.phone,
                    email: registerData.email
                )
                do {
                    try self.dbManager.saveUser(user)
                    self.isLoading = false
                    completion?()
                } catch let error {
                    self.isLoading = false
                    print(#function, "mytest - save user error: \(error)")
                }
            case .failure(let error):
                self.isLoading = false
                print(#function, "mytest - register error: \(error)")
            }
        }
    }
    
}
