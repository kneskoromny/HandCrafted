struct LoginData {
    var email = ""
    var password = ""
    var confirmPassword = ""
}

struct User: Codable {
    var id: String?
    var name: String?
    var email: String?
    var password: String? // не должно быть здесь
    var birthday: String?
    
    var isSalesSubOn: Bool = false
    var isNewArrivalsSubOn: Bool = false
    
}
