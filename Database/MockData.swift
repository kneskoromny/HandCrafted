struct MockData {
    
    // Примеры категорий
    static let categories: [Category] = [
        Category(
            name: "Футболки",
            description: "Описание футболок",
            imageUrl: "https://example.com/images/tshirt1.png"
        ),
        Category(
            name: "Брюки",
            description: "Описание брюк",
            imageUrl: "https://example.com/images/tshirt1.png"
        ),
        Category(
            name: "Куртки",
            description: "Описание курток",
            imageUrl: "https://example.com/images/tshirt1.png"
        ),
        Category(
            name: "Платья",
            description: "Описание платьев",
            imageUrl: "https://example.com/images/tshirt1.png"
        ),
        Category(
            name: "Толстовки",
            description: "Описание толстовок",
            imageUrl: "https://example.com/images/tshirt1.png"
        )
    ]

    // Примеры товаров
    static let products: [Product] = [
        // Футболки
        Product(
            categoryName: "Футболки",
            name: "Футболка Basic",
            fabric: "Хлопок",
            color: "Белый",
            size: "M",
            description: "Удобная и легкая футболка из 100% хлопка. Подходит для повседневной носки.",
            imageUrls: ["https://example.com/images/tshirt1.png"],
            price: 1500,
            isFavorite: false,
            isInStock: true,
            isSale: false
        ),
        Product(
            categoryName: "Футболки",
            name: "Футболка Graphic",
            fabric: "Хлопок",
            color: "Синий",
            size: "L",
            description: "Футболка с ярким принтом. Создана для тех, кто любит выделяться.",
            imageUrls: ["https://example.com/images/tshirt2.png"],
            price: 1800,
            isFavorite: true,
            isInStock: false,
            isSale: true
        ),
        Product(
            categoryName: "Футболки",
            name: "Футболка Long Sleeve",
            fabric: "Хлопок",
            color: "Черный",
            size: "S",
            description: "Футболка с длинным рукавом для прохладной погоды.",
            imageUrls: ["https://example.com/images/tshirt3.png"],
            price: 2000,
            isFavorite: false,
            isInStock: true,
            isSale: false
        ),

        // Джинсы
        Product(
            categoryName: "Джинсы",
            name: "Джинсы Slim Fit",
            fabric: "Деним",
            color: "Синий",
            size: "L",
            description: "Модные джинсы с узким кроем, идеально подчеркивающие фигуру.",
            imageUrls: ["https://example.com/images/jeans1.png"],
            price: 3500,
            isFavorite: true,
            isInStock: true,
            isSale: true
        ),
        Product(
            categoryName: "Джинсы",
            name: "Джинсы Regular Fit",
            fabric: "Деним",
            color: "Черный",
            size: "M",
            description: "Классические джинсы с прямым кроем для удобства и стиля.",
            imageUrls: ["https://example.com/images/jeans2.png"],
            price: 3200,
            isFavorite: false,
            isInStock: false,
            isSale: false
        ),
        Product(
            categoryName: "Джинсы",
            name: "Джинсы Ripped",
            fabric: "Деним",
            color: "Светло-синий",
            size: "XL",
            description: "Джинсы с эффектом потертости и разрывами для стильного образа.",
            imageUrls: ["https://example.com/images/jeans3.png"],
            price: 3800,
            isFavorite: false,
            isInStock: false,
            isSale: true
        ),

        // Куртки
        Product(
            categoryName: "Куртки",
            name: "Куртка Парка",
            fabric: "Полиэстер",
            color: "Черный",
            size: "XL",
            description: "Теплая и стильная куртка парка для холодной погоды.",
            imageUrls: ["https://example.com/images/parka1.png"],
            price: 8500,
            isFavorite: false,
            isInStock: true,
            isSale: false
        ),
        Product(
            categoryName: "Куртки",
            name: "Куртка Бомбер",
            fabric: "Нейлон",
            color: "Зеленый",
            size: "M",
            description: "Легкая куртка-бомбер для прохладных вечеров.",
            imageUrls: ["https://example.com/images/bomber1.png"],
            price: 4800,
            isFavorite: true,
            isInStock: true,
            isSale: true
        ),
        Product(
            categoryName: "Куртки",
            name: "Куртка Кожаная",
            fabric: "Натуральная кожа",
            color: "Коричневый",
            size: "L",
            description: "Классическая кожаная куртка для стильных мужчин.",
            imageUrls: ["https://example.com/images/leatherjacket1.png"],
            price: 12000,
            isFavorite: false,
            isInStock: false,
            isSale: false
        ),

        // Платья
        Product(
            categoryName: "Платья",
            name: "Платье Casual",
            fabric: "Вискоза",
            color: "Красный",
            size: "S",
            description: "Легкое и элегантное платье для повседневных прогулок.",
            imageUrls: ["https://example.com/images/dress1.png"],
            price: 4200,
            isFavorite: false,
            isInStock: true,
            isSale: true
        ),
        Product(
            categoryName: "Платья",
            name: "Платье Вечернее",
            fabric: "Шелк",
            color: "Черный",
            size: "M",
            description: "Элегантное вечернее платье для особых случаев.",
            imageUrls: ["https://example.com/images/dress2.png"],
            price: 9600,
            isFavorite: true,
            isInStock: false,
            isSale: false
        ),
        Product(
            categoryName: "Платья",
            name: "Платье Солнце",
            fabric: "Хлопок",
            color: "Желтый",
            size: "L",
            description: "Летнее платье с ярким дизайном и удобным кроем.",
            imageUrls: ["https://example.com/images/dress3.png"],
            price: 3800,
            isFavorite: false,
            isInStock: false,
            isSale: true
        ),

        // Толстовки
        Product(
            categoryName: "Толстовки",
            name: "Толстовка Hoodie",
            fabric: "Хлопок/Полиэстер",
            color: "Серый",
            size: "M",
            description: "Удобная толстовка с капюшоном для спорта и активного отдыха.",
            imageUrls: ["https://example.com/images/hoodie1.png"],
            price: 2900,
            isFavorite: true,
            isInStock: true,
            isSale: false
        ),
        Product(
            categoryName: "Толстовки",
            name: "Толстовка Oversize",
            fabric: "Хлопок",
            color: "Белый",
            size: "L",
            description: "Мягкая толстовка оверсайз для комфортного отдыха.",
            imageUrls: ["https://example.com/images/hoodie2.png"],
            price: 3200,
            isFavorite: false,
            isInStock: false,
            isSale: true
        ),
        Product(
            categoryName: "Толстовки",
            name: "Толстовка Классическая",
            fabric: "Хлопок",
            color: "Черный",
            size: "XL",
            description: "Классическая толстовка для повседневного ношения.",
            imageUrls: ["https://example.com/images/hoodie3.png"],
            price: 3100,
            isFavorite: true,
            isInStock: true,
            isSale: false
        )
    ]
}
