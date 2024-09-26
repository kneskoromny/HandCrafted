enum AppDestination: Codable, Hashable, Identifiable {
    
    var id: AppDestination { self }
    
    // Каталог
    case list(category: Category)
    case detail(product: Product)

    // Профиль
    case orders
    case favorites
    case shippingAddresses
    case paymentMethods
    case settings

    // Регистрация
    case signIn
    case forgotPassword
    case recoveryRequested
    
}
