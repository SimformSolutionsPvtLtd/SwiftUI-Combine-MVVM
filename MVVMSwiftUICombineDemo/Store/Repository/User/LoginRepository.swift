//
//  LoginRepository.swift
//  MVVMSwiftUICombineDemo
//
//  Created by Simform Solutions on 28/01/22.
//

import Foundation
import FirebaseFirestore
import Firebase
import FirebaseAuth
import FirebaseStorage

struct LoginRepository {
    
    private let auth = Auth.auth()
    private let firetore = Firestore.firestore()
    private let storage = Storage.storage()
    
    func login(email: String, password: String, completion: @escaping (AppError?) -> ()) {
        auth.signIn(withEmail: email, password: password) { (result, error) in
            if let error = error {
                completion(AppError.commonError(error))
                return
            }
            completion(.none)
        }
    }
    
}
