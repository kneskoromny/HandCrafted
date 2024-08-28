import FirebaseAuth
import FirebaseCore
import FirebaseStorage
import Foundation

final class StorageManager {
    
    private let ref = Storage.storage().reference()
    private let avatarsPath = "images/avatars"
    
    func saveAvatar(
        data: Data?,
        completion: @escaping (Result<String, any Error>) -> Void
    ) {
        guard
            let id = Auth.auth().currentUser?.uid,
        let data
        else {
            print(#function, "krl_debug: no id or no data")
            return
        }
        let avatarRef = ref.child(avatarsPath).child(id)
        avatarRef.putData(
            data,
            metadata: nil
        ) { (metadata, error) in
            if let error {
                print(#function, "krl_debug error: \(error.localizedDescription)")
                completion(.failure(error))
            } else {
                avatarRef.downloadURL { (url, error) in
                    guard let url, error == nil else {
                        print(#function, "krl_debug error: \(error?.localizedDescription)")
                        completion(.failure(error!))
                        return
                    }
                    print(#function, "krl_debug url str: \(url.absoluteString)")
                    completion(.success(url.absoluteString))
                }
                
            }
        }
    }
}
