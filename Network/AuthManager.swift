import FirebaseCore
import FirebaseAuth
import FirebaseDatabase
import Foundation

final class AuthManager {
    
    var isAuthUser: Bool {
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
    
    func login(withEmail email: String, password: String) async throws {
        do {
            _ = try await Auth.auth().signIn(withEmail: email, password: password)
        } catch {
            throw error
        }
    }
    
    func logout() async throws {
        do {
            let _ = try Auth.auth().signOut()
        } catch {
            throw error
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
