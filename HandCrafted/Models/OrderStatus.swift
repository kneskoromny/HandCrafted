enum OrderStatus: Int, CaseIterable {
    
    case created
    case confirmed
    case inProcess
    case ready
    case delivered
    
    var description: String {
        switch self {
        case .created:
            return "Создан"
        case .confirmed:
            return "Подтвержден"
        case .inProcess:
            return "В процессе"
        case .ready:
            return "Готов"
        case .delivered:
            return "Доставлен"
        }
    }
    
}
