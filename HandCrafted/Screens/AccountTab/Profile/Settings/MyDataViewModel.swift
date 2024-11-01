import SwiftUI

final class MyDataViewModel: ObservableObject {
    
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
    
    // TODO: это надо брать из подписки на User
    @Published var registerData = RegisterData()
    @Published var errorData = ErrorData()
    @Published var isLoading = false
    @Published var isDisabled = true
}
