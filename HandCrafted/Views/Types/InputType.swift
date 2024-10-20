import UIKit

enum InputType {
    
    case name
    case birthDate
    case city
    case phone
    case email
    case password
    case confirm
    
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
            var updated = text.count <= 2 ? "7" : text
            return getTextMasked(mask, text: updated)
        default:
            return text
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
