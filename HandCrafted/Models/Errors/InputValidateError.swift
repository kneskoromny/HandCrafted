import Foundation

enum InputValidateError: Error {
    
    case reqField
    case notKirillic
    case phone
    case birthDate
    case email
    case password
    case confirm
}

extension InputValidateError: LocalizedError {
    
    var errorDescription: String? {
        switch self {
            
        case .reqField:
            return "Обязательное поле"
        case .notKirillic:
            return "Текст содержит не кириллицу или введены недопустимые символы"
        case .phone:
            return "Ошибка в номере телефона"
        case .birthDate:
            return "Ошибка в дате рождения"
        case .email:
            return "Ошибка в адресе почты"
        case .password:
            return "Минимум 6 символов: латинские буквы, цифры или спецсимволы"
        case .confirm:
            return "Пароли не совпадают"
        }
    }
    
}
