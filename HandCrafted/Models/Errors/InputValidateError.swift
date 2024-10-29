import Foundation

enum InputValidateError: Error {
    
    case invalidBirthDate
    case invalidEmail
    case invalidPassword
}

extension InputValidateError: LocalizedError {
    
    var errorDescription: String? {
        switch self {
        case .invalidBirthDate:
            return "Ошибка в дате рождения"
        case .invalidEmail:
            return "Ошибка в адресе почты"
        case .invalidPassword:
            return "Минимум 8 символов: латинские буквы и цифры"
        }
    }
    
}
