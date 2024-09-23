struct MockData {
    
    // Примеры категорий
    static let categories: [Category] = [
        Category(
            id: 1,
            name: "Футболки",
            description: "Описание футболок",
            imageUrl: "https://example.com/images/tshirt1.png"
        ),
        Category(
            id: 2,
            name: "Брюки",
            description: "Описание брюк",
            imageUrl: "https://example.com/images/tshirt1.png"
        ),
        Category(
            id: 3,
            name: "Куртки",
            description: "Описание курток",
            imageUrl: "https://example.com/images/tshirt1.png"
        ),
        Category(
            id: 4,
            name: "Платья",
            description: "Описание платьев",
            imageUrl: "https://example.com/images/tshirt1.png"
        ),
        Category(
            id: 5,
            name: "Толстовки",
            description: "Описание толстовок",
            imageUrl: "https://example.com/images/tshirt1.png"
        )
    ]

    // Примеры товаров
    // Пример мок-данных для размера
    static let mockSizes: [Size] = [
        Size(name: "S/L", isInStock: true, isInSale: false, list: ["S", "L"]),
        Size(name: "M", isInStock: true, isInSale: true, list: ["M"])
    ]

    // Пример мок-данных для цены
    static let mockPrice = Price(standard: 6800, sale: 4800)
    
    static let mockColor = ProductColor(name: "Белый", list: ["Белый, Серый, Коричневый"])

    // Пример мок-данных для продукта
    static let mockProduct = Product(
        categoryName: "Футболки",
        name: "Футболка Basic",
        fabric: "Хлопок",
        composition: "Хлопок 100%",
        color: mockColor,
        sizes: mockSizes,
        description: "Удобная и легкая футболка из 100% хлопка. Подходит для повседневной носки.",
        imageUrls: [],
        price: mockPrice,
        isFavorite: true,
        isSale: true
    )

}
