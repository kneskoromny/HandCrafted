import SwiftUI

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
            return "Номер телефона c привязкой к мессенджерам"
        case .email:
            return "E-mail"
        case .password:
            return "Пароль"
        case .confirm:
            return "Подтверждение пароля"
        }
    }
    
    var autocapitalization: TextInputAutocapitalization {
        switch self {
        case .name, .city:
            return .words
        default:
            return .never
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
            return .default
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
    
    func isValid(_ text: String) throws -> Bool {
        if text == "" {
            throw InputValidateError.reqField
        }
        let clean = text.components(
            separatedBy: CharacterSet.decimalDigits.inverted
        ).joined()
        switch self {
        case .name, .city:
            let validSymbols =
            "абвгдеёжзийклмнопрстуфхцчшщъыьэюя" +
            "АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ" +
            "`-"
            let allowedCharacters = CharacterSet(charactersIn: validSymbols)
            let characterSet = CharacterSet(charactersIn: text)
            if !allowedCharacters.isSuperset(of: characterSet) {
                throw InputValidateError.notKirillic
            } else {
                return true
            }
        case .phone:
            if clean.count != 11 {
                throw InputValidateError.phone
            } else {
                return true
            }
        case .birthDate:
            let formatter = DateFormatter()
            formatter.dateFormat = "dd.MM.yyyy"
            if formatter.date(from: text) == nil || clean.count != 8 {
                throw InputValidateError.birthDate
            } else {
                return true
            }
        case .email:
            let predicate = NSPredicate(
                format: "SELF MATCHES %@",
                "[a-zA-Z0-9\\+\\.\\_\\%\\-\\+]{1,256}" +
                "\\@" +
                "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" +
                "(" +
                "\\." +
                "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" +
                ")+"
            )
            if !(5...60).contains(text.count) && !predicate.evaluate(with: text) {
                throw InputValidateError.email
            } else {
                return true
            }
        case .password:
            let predicate = NSPredicate(
                format: "SELF MATCHES %@",
                "(?=.*[0-9a-zA-Z]).{6,}"
            )
            if !(6...70).contains(text.count) && !predicate.evaluate(with: text) {
                throw InputValidateError.password
            } else {
                return true
            }
        case .confirm:
            return false
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
