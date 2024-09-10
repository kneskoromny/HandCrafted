import FirebaseAuth
import FirebaseCore
import FirebaseDatabase

final class DatabaseManager {
    
    private enum Const {
        static let dbUrl = "https://handcrafted-af31d-default-rtdb.europe-west1.firebasedatabase.app/"
        static let usersPath = "users"
        static let productsPath = "products"
        static let categoriesPath = "categories"
    }
    private let ref = Database.database(url: Const.dbUrl).reference()
    
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
    
    func getCategoryList() async throws -> [Category] {
        let snapshot = try await ref.child(Const.categoriesPath).getData()
        var categories: [Category] = []
        
        for child in snapshot.children {
            if let childSnapshot = child as? DataSnapshot,
               let dict = childSnapshot.value as? [String: Any],
               let name = dict["name"] as? String {
                
                let description = dict["description"] as? String
                let imageUrl = dict["imageUrl"] as? String
                
                
                let category = Category(
                    name: name,
                    description: description,
                    imageUrl: imageUrl
                )
                categories.append(category)
            }
        }
        return categories
    }
    
    func getProductList() async throws -> [Product] {
        let snapshot = try await ref.child(Const.productsPath).getData()
        var products: [Product] = []
        
        for child in snapshot.children {
            if let childSnapshot = child as? DataSnapshot,
               let dict = childSnapshot.value as? [String: Any],
               let categoryName = dict["categoryName"] as? String,
               let name = dict["name"] as? String,
               let fabric = dict["fabric"] as? String,
               let color = dict["color"] as? String,
               let size = dict["size"] as? String,
               let description = dict["description"] as? String,
               let price = dict["price"] as? Int,
               let isFavorite = dict["isFavorite"] as? Bool,
               let isSale = dict["isSale"] as? Bool {
                
                let imageUrl = dict["imageUrl"] as? String
                let product = Product(
                    categoryName: categoryName,
                    name: name,
                    fabric: fabric,
                    color: color,
                    size: size,
                    description: description,
                    imageUrl: imageUrl,
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

// MARK: - Mock Methods

extension DatabaseManager {
    
    static func getMockCategoryList() async -> [Category] {
        sleep(1)
        return MockData.categories
    }
    
    static func getMockProductList() async -> [Product] {
        sleep(1)
        return MockData.products
    }
    
}
