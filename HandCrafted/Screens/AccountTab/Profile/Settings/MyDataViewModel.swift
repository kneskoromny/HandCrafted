import SwiftUI

final class MyDataViewModel: ObservableObject {
    
    struct UserData {
        var name: String = ""
        var birthDate: String = ""
        var city: String = ""
        var phone: String = ""
        var email: String = ""
        
        // TODO: оптимизировать
        var isFilled: Bool {
            return name != "" && birthDate != "" && city != "" && phone != "" && email != ""
        }
    }
    
    struct ErrorData {
        var name: String = ""
        var birthDate: String = ""
        var city: String = ""
        var phone: String = ""
        var email: String = ""
        
        // TODO: оптимизировать
        var isErrored: Bool {
            return name != "" || birthDate != "" || city != "" || phone != "" || email != ""
        }
    }
    
    @Published var userData = UserData()
    @Published var errorData = ErrorData()
    @Published var isLoading = false
    @Published var isDisabled = true
    
    private var dbManager = DatabaseManager()
    
    func getUser() {
        guard let user = dbManager.user else {
            print(#function, "mytest - no user in db manager")
            return
        }
        userData.name = user.name
        userData.birthDate = user.birthDate
        userData.city = user.city
        userData.phone = user.phone
        userData.email = user.email
    }
}
