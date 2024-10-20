import Foundation

struct User: Codable, Hashable, Identifiable {
    
    var id: String
    var name: String
    var birthDate: String
    var city: String
    var phone: String
    var email: String 
    
}
