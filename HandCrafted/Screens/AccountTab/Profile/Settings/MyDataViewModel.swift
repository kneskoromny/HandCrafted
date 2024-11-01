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
    @Published var isAlertPresented = false
    
    var isFormReady: Bool {
        return userData.isFilled && !errorData.isErrored
    }
    
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
    
    func updateUser() {
        guard let registered = dbManager.user else { return }
        let updated = User(
            id: registered.id,
            name: userData.name,
            birthDate: userData.birthDate,
            city: userData.city,
            phone: userData.phone,
            email: userData.email
        )
        guard registered != updated else {
            print(#function, "mytest - users are same")
            self.isDisabled = true
            return
        }
        print(#function, "mytest - users are different")
        isLoading = true
        do {
            try self.dbManager.saveUser(updated)
            self.isLoading = false
            self.isDisabled = true
        } catch let error {
            self.isLoading = false
            self.isDisabled = true
            print(#function, "mytest - save user error: \(error)")
        }
    }
}
