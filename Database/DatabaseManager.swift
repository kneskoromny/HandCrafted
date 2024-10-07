import FirebaseAuth
import FirebaseCore
import FirebaseDatabase

final class DatabaseManager {
    
    private enum Const {
        static let dbUrl = "https://handcrafted-af31d-default-rtdb.europe-west1.firebasedatabase.app/"
        static let usersPath = "users"
        static let productsPath = "products"
        static let categoriesPath = "categories"
        static let orders = "orders"
    }
    private let ref = Database.database(url: Const.dbUrl).reference()
    
}

// MARK: - User Methods

extension DatabaseManager {
    
    func saveUser(
        _ user: User,
        completion: @escaping (Error?) -> Void
    ) {
        guard let id = Auth.auth().currentUser?.uid else { return }
        var copy = user
        copy.id = id
        do {
            try ref.child("\(Const.usersPath)/\(id)").setValue(from: copy)
            completion(nil)
        } catch let error {
            print(#function, "mytest - error: \(error)")
            completion(error)
        }
    }

    func getUser() async throws -> User? {
        // Получаем текущий ID пользователя
        guard let id = Auth.auth().currentUser?.uid else {
            return nil
        }
        let snapshot = try await ref.child(Const.usersPath).child(id).getData()
        guard let value = snapshot.value as? [String: Any?] else {
            print(#function, "mytest - no dict or no id in fb snapshot")
            return nil
        }
        let local = User(
            id: value["id"] as? String,
            name: value["name"] as? String,
            email: value["email"] as? String,
            password: value["password"] as? String,
            birthday: value["birthday"] as? String,
            avatarUrl: value["avatarUrl"] as? String,
            isSalesSubOn: value["isSalesSubOn"] as? Bool ?? false,
            isNewArrivalsSubOn: value["isNewArrivalsSubOn"] as? Bool ?? false
        )
        
        return local
    }
    
}

// MARK: - Category Methods

extension DatabaseManager {
    
    func getCategoryList() async throws -> [Category] {
        let snapshot = try await ref.child(Const.categoriesPath).getData()
        var categories: [Category] = []
        
        for child in snapshot.children {
            if let childSnapshot = child as? DataSnapshot,
               let dict = childSnapshot.value as? [String: Any],
               let name = dict["name"] as? String,
               let id = dict["id"] as? Int {
                
                let description = dict["description"] as? String
                let imageUrl = dict["imageUrl"] as? String
                
                let category = Category(
                    id: id,
                    name: name,
                    description: description,
                    imageUrl: imageUrl
                )
                categories.append(category)
            }
        }
        return categories.sorted(by: { $0.id < $1.id })
    }
    
}

// MARK: - Product Methods

extension DatabaseManager {
    
    func getProductList() async throws -> [Product] {
        let snapshot = try await ref.child(Const.productsPath).getData()
        var products: [Product] = []
        
        for child in snapshot.children {
            if let childSnapshot = child as? DataSnapshot,
               let dict = childSnapshot.value as? [String: Any],
               
               // Основные поля продукта
               let categoryName = dict["categoryName"] as? String,
               let name = dict["name"] as? String,
               
               let fabric = dict["fabric"] as? String,
               let composition = dict["composition"] as? String,
               
               let colorDict = dict["color"] as? [String: Any],
               let colorName = colorDict["name"] as? String,
               let colorList = colorDict["list"] as? [String],
                
               let description = dict["description"] as? String,
               
               // Поле цены (вложенный объект)
               let priceDict = dict["price"] as? [String: Any],
               let standardPrice = priceDict["standard"] as? Int {
                
                // Обработка опциональной распродажной цены
                let salePrice = priceDict["sale"] as? Int
                
                // Поле размеров (массив объектов)
                let sizesArray = dict["sizes"] as? [[String: Any]] ?? []
                var sizes: [Size] = []
                for sizeDict in sizesArray {
                    if let name = sizeDict["name"] as? String,
                       let isInStock = sizeDict["isInStock"] as? Bool,
                       let isInSale = sizeDict["isInSale"] as? Bool,
                       let list = sizeDict["list"] as? [String] {
                        let size = Size(name: name, isInStock: isInStock, isInSale: isInSale, list: list)
                        sizes.append(size)
                    }
                }
                
                // Поле изображений
                let imageUrls = dict["imageUrls"] as? [String]
                
                // Поля статуса
                let isFavorite = dict["isFavorite"] as? Bool ?? false
                let isSale = dict["isSale"] as? Bool ?? false
                
                // Создание объекта Price
                let price = Price(standard: standardPrice, sale: salePrice)
                
                let color = ProductColor(name: colorName, list: colorList)
                
                // Создание объекта Product
                let product = Product(
                    categoryName: categoryName,
                    name: name,
                    fabric: fabric,
                    composition: composition,
                    color: color,
                    selectedSize: sizes.first,
                    sizes: sizes,
                    description: description,
                    imageUrls: imageUrls,
                    price: price,
                    isFavorite: isFavorite,
                    isSale: isSale
                )
                
                products.append(product)
            }
        }
        
        return products
    }
}

// MARK: - Order Methods

extension DatabaseManager {
    
    func saveOrder(_ order: OrderDto) throws {
        try ref.child("\(Const.orders)/\(order.id)").setValue(from: order)
    }
    
}
