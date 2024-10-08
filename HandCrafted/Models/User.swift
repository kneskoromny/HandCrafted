import Foundation

struct LoginData {
    var email = ""
    var password = ""
    var confirmPassword = ""
}

struct User: Codable, Hashable, Identifiable {
    var id: String?
    var name: String?
    var email: String?
    var birthday: String?
    var city: String?
    
    var password: String? // не должно быть здесь
    var avatarUrl: String?
    
    var isSalesSubOn: Bool = false
    var isNewArrivalsSubOn: Bool = false
    
}
