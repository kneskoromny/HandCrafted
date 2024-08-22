import FirebaseAuth
import FirebaseCore
import FirebaseDatabase

final class DatabaseManager {
    
    private let ref = Database.database(url: "https://handcrafted-af31d-default-rtdb.europe-west1.firebasedatabase.app/").reference()
    private let usersPath = "users"
    
    init() {
        
    }
    
    func saveUser(
        _ user: User,
        completion: @escaping (Error?) -> Void
    ) {
        guard let id = Auth.auth().currentUser?.uid else { return }
        let user = User(
            id: id,
            name: user.name,
            email: user.email,
            password: user.password,
            birthday: user.birthday,
            isSalesSubOn: user.isSalesSubOn,
            isNewArrivalsSubOn: user.isNewArrivalsSubOn
        )
        do {
            try ref.child("\(usersPath)/\(id)").setValue(from: user)
            completion(nil)
        } catch let error {
            print(#function, "mytest - error: \(error)")
            completion(error)
        }
    }
    
    func getUser(completion: ((User?) -> Void)?) {
        guard let id = Auth.auth().currentUser?.uid else { 
            completion?(nil)
            return
        }
        ref.child(usersPath).child(id).observeSingleEvent(of: .value, with: { snapshot in
            guard 
                let value = snapshot.value as? [String: Any?]
            else {
                print(#function, "mytest - no dict or no id in fb snapshot")
                completion?(nil)
                return
            }
            let local = User(
                id: value["id"] as? String,
                name: value["name"] as? String,
                email: value["email"] as? String,
                password: value["password"] as? String,
                birthday: value["birthday"] as? String,
                isSalesSubOn: value["isSalesSubOn"] as? Bool ?? false,
                isNewArrivalsSubOn: value["isNewArrivalsSubOn"] as? Bool ?? false
            )
            completion?(local)
        })
    }

}
