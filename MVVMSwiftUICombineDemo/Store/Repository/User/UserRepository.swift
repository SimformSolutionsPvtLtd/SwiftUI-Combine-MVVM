//
//  UserRepository.swift
//  MVVMSwiftUICombineDemo
//
//  Created by Simform Solutions on 28/01/22.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseStorage
import FirebaseAuth

struct UserRepository {
    
    private let auth = Auth.auth()
    private let firestore = Firestore.firestore()
    private let storage = Storage.storage()
    
    func fetchUser(_ uid: String, completion: @escaping (Result<User, AppError>) -> ()) {
        firestore.collection(FirestoreCollections.users.rawValue)
            .document(uid)
            .getDocument(completion: { (snapshot, err) in
            if let err = err { print(err.localizedDescription); return }
            do {
                guard let user = try snapshot?.data(as: User.self) else {
                    debugPrint("uID: \(uid)")
                    completion(.failure(AppError.customError("Could not fetch user")))
                    return
                }
                
                completion(.success(user))
            } catch let error {
                completion(.failure(AppError.commonError(error)))
            }
        })
    }
    
}
