enum AppDestination: Codable, Hashable, Identifiable {
    
    var id: AppDestination { self }
    
    // Каталог
    case list(category: Category)
    case productDetail(_ product: Product)

    // Профиль
    case orders
    case orderDetail(_ order: Order)
    case favorites
    case shippingAddresses
    case paymentMethods
    case settings

    // Регистрация
    case register
    case forgotPassword
    case recoveryRequested
    
}
