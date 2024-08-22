import FirebaseCore
import FirebaseAuth
import FirebaseDatabase
import Foundation

final class AuthManager {
    
    var isAuthorizedUser: Bool {
        return Auth.auth().currentUser != nil
    }
    
    init() {
        Auth.auth().useAppLanguage()
    }
    
    func register(
        withEmail email: String,
        password: String,
        completion: @escaping (Error?) -> Void
    ) {
        Auth.auth().createUser(withEmail: email, password: password) { _, error in
            completion(error)
        }
    }
    
    func login(
        withEmail email: String,
        password: String,
        completion: @escaping (Error?) -> Void
    ) {
        Auth.auth().signIn(withEmail: email, password: password) { _, error in
          completion(error)
        }
    }
    
    func logout(completion: @escaping (Error?) -> Void) {
        do {
            try Auth.auth().signOut()
            completion(nil)
        } catch let error {
            completion(error)
        }
    }
    
    func sendPasswordReset(
        withEmail email: String,
        completion: @escaping (Error?) -> Void
    ) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
          completion(error)
        }
    }
    
}
