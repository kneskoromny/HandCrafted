enum OrderStatus: Int {
    
    case created
    case payed
    case inProcess
    case ready
    case delivered
    case canceled
    
    var description: String {
        switch self {
        case .created:
            return "Создан"
        case .payed:
            return "Оплачен"
        case .inProcess:
            return "В процессе"
        case .ready:
            return "Готов"
        case .delivered:
            return "Доставлен"
        case .canceled:
            return "Отменен"
        }
    }
    
}
