import FirebaseCore
import FirebaseAuth
import FirebaseDatabase
import Foundation

final class AuthManager {
    
    init() {
        Auth.auth().useAppLanguage()
    }
    
    func createUser(
        withEmail email: String,
        password: String,
        completion: @escaping (Error?) -> Void
    ) {
        Auth.auth().createUser(withEmail: email, password: password) { _, error in
            completion(error)
        }
    }
    
    func signIn(
        withEmail email: String,
        password: String,
        completion: @escaping (Error?) -> Void
    ) {
        Auth.auth().signIn(withEmail: email, password: password) { _, error in
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
