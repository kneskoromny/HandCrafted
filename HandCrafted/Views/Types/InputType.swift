import UIKit

enum InputType {
    
    case name
    case birthDate
    case city
    case phone
    case email
    case password
    case confirm
    
    var placeholder: String {
        switch self {
        case .name:
            return "Имя"
        case .birthDate:
            return "Дата рождения"
        case .city:
            return "Город проживания"
        case .phone:
            return "Номер телефона"
        case .email:
            return "E-mail"
        case .password:
            return "Пароль"
        case .confirm:
            return "Подтверждение пароля"
        }
    }
    
    var textContentType: UITextContentType {
        switch self {
        case .name:
            return .givenName
        case .birthDate:
            return .birthdate
        case .city:
            return .addressCity
        case .phone:
            return .telephoneNumber
        case .email:
            return .username
        case .password, .confirm:
            return .password
        }
    }
    
    var keyboardType: UIKeyboardType {
        switch self {
        case .birthDate:
            return .numberPad
        case .phone:
            return .phonePad
        default:
            return .asciiCapable
        }
    }

}

extension InputType {
   
    func format(_ text: String) -> String {
        switch self {
        case .birthDate:
            let mask = "##.##.####"
            return getTextMasked(mask, text: text)
        case .phone:
            let mask = "+# (###) ###-##-##"
            let updated = text.count <= 2 ? "7" : text
            return getTextMasked(mask, text: updated)
        default:
            return text
        }
    }
    // TODO: продолжить здесь с настройки правил валидации
    func validate(_ text: String) throws {
        switch self {
        case .name, .city, .phone, .confirm:
            return
        case .birthDate:
            throw InputValidateError.invalidBirthDate
        case .email:
            throw InputValidateError.invalidEmail
        case .password:
            throw InputValidateError.invalidPassword
        }
    }
    
}

private extension InputType {
    
    func getTextMasked(_ mask: String, text: String) -> String {
        let cleanText = text
            .components(separatedBy: CharacterSet.decimalDigits.inverted)
            .joined()
        var toDisplay = ""
        var index = cleanText.startIndex
        for char in mask where index < cleanText.endIndex {
            if char == "#" {
                toDisplay.append(cleanText[index])
                index = cleanText.index(after: index)
            } else {
                toDisplay.append(char)
            }
        }
        return toDisplay
    }
    
}
