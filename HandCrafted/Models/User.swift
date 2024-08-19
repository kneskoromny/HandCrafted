import Foundation

struct User: Codable {
    
    var firstName = ""
    var lastName = ""
    var email = ""
    var password = ""
    var birthday = ""
    
    var isSalesSubOn: Bool = false
    var isNewArrivalsSubOn: Bool = false
    
}
