import FirebaseAuth
import FirebaseCore
import FirebaseDatabase

// TODO: Не сделано
// подумать над реализацией подписки на User

final class DatabaseManager {
    
    private enum Const {
        static let dbUrl = "https://handcrafted-af31d-default-rtdb.europe-west1.firebasedatabase.app/"
        static let usersPath = "users"
        static let productsPath = "products"
        static let categoriesPath = "categories"
        static let orders = "orders"
    }
    private let ref = Database.database(url: Const.dbUrl).reference()
    
    var user: User?
    
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
        guard
            let value = snapshot.value as? [String: Any?],
            let id = value["id"] as? String,
            let name = value["name"] as? String,
            let email = value["email"] as? String,
            let birthday = value["birthday"] as? String,
            let city = value["city"] as? String
        else {
            return nil
        }
        let password =  value["password"] as? String
        let avatarUrl = value["avatarUrl"] as? String
        let isSalesSubOn = value["isSalesSubOn"] as? Bool ?? false
        let isNewArrivalsSubOn = value["isNewArrivalsSubOn"] as? Bool ?? false
        
        let user = User(
            id: id,
            name: name,
            email: email,
            birthday: birthday,
            city: city,
            password: password,
            avatarUrl: avatarUrl,
            isSalesSubOn: isSalesSubOn,
            isNewArrivalsSubOn: isNewArrivalsSubOn
        )
        self.user = user
        return user
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
               let dict = childSnapshot.value as? [String: Any] {
                let product = try parseProduct(from: dict)
                products.append(product)
            }
        }
        return products
    }
}

// MARK: - Order Methods

extension DatabaseManager {
    
    func saveOrder(_ order: Order) throws {
        try ref.child(Const.orders).child(order.userId).child(order.id).setValue(from: order)
    }
    
    func getOrderList() async throws -> [Order] {
        var orders: [Order] = []
        guard let userId = Auth.auth().currentUser?.uid else {
            return orders
        }
        let snapshot = try await ref.child(Const.orders).child(userId).getData()
        
        for child in snapshot.children {
            if let orderSnapshot = child as? DataSnapshot,
               let orderDict = orderSnapshot.value as? [String: Any],
               let id = orderDict["id"] as? String,
               let userId = orderDict["userId"] as? String,
               let status = orderDict["status"] as? Int,
               let totalPrice = orderDict["totalPrice"] as? Int,
               let date = orderDict["date"] as? String,
               let itemsArray = orderDict["items"] as? [[String: Any]] {
                
                var orderItems: [OrderItem] = []
                
                for itemDict in itemsArray {
                    if let itemId = itemDict["id"] as? String,
                       let productDict = itemDict["product"] as? [String: Any],
                       let quantity = itemDict["quantity"] as? Int {
                        
                        // Парсим продукт
                        let product = try parseProduct(from: productDict)
                        
                        // Создаем OrderItem
                        let orderItem = OrderItem(id: itemId, product: product, quantity: quantity)
                        orderItems.append(orderItem)
                    }
                }
                
                // Создаем Order
                let order = Order(
                    id: id,
                    userId: userId,
                    status: status,
                    totalPrice: totalPrice,
                    date: date,
                    items: orderItems
                )
                orders.append(order)
            }
        }
        return orders
    }
    
}

// MARK: - Private Methods

private extension DatabaseManager {
    
    func parseProduct(from dict: [String: Any]) throws -> Product {
        guard
            let categoryName = dict["categoryName"] as? String,
            let name = dict["name"] as? String,
            let fabric = dict["fabric"] as? String,
            let composition = dict["composition"] as? String,
            let colorDict = dict["color"] as? [String: Any],
            let colorName = colorDict["name"] as? String,
            let colorList = colorDict["list"] as? [String],
            let description = dict["description"] as? String,
            let priceDict = dict["price"] as? [String: Any],
            let standardPrice = priceDict["standard"] as? Int
        else {
            throw NSError(
                domain: "",
                code: -1,
                userInfo: [NSLocalizedDescriptionKey: "Ошибка парсинга продукта"]
            )
        }
        
        let salePrice = priceDict["sale"] as? Int
        
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
        let imageUrls = dict["imageUrls"] as? [String]
        let isFavorite = dict["isFavorite"] as? Bool ?? false
        let isSale = dict["isSale"] as? Bool ?? false
        let price = Price(standard: standardPrice, sale: salePrice)
        let color = ProductColor(name: colorName, list: colorList)
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
        return product
    }
    
}
