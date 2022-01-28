//
//  LastReadingBookRepository.swift
//  Peek
//
//  Created by Vishal Patel on 01/09/21.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct LastReadingBookRepository {
    
    static let shared = LastReadingBookRepository()
    private let auth = Auth.auth()
    private let firestore = Firestore.firestore()
    
    func fetchLastReadingBookOfUser(completion: @escaping (Result<LastReadingBook, PeekError>) -> ()) {
        guard let uid = auth.currentUser?.uid else {
            //completion(.failure(PeekError.customError("User Id not found")))
            return
        }
        firestore.collection(FirestoreCollections.lastReadingBook.rawValue)
            .document(uid)
            .addSnapshotListener { (querySnapshot, error) in
            if let error = error {
                print(error.localizedDescription);
                completion(.failure(PeekError.commonError(error)))
                return
            }
            guard let data = try? querySnapshot?.data(as: LastReadingBook.self) else {
                completion(.failure(PeekError.customError("dont have any last book")))
                return
            }
            completion(.success(data))
        }
        
    }
    
    func saveLastReadingBookOfUser(data: [String:Any]) {
        guard let uid = auth.currentUser?.uid else {
            //completion(.failure(PeekError.customError("User Id not found")))
            return
        }
        firestore.collection(FirestoreCollections.lastReadingBook.rawValue)
        .document(uid).setData(data, merge: true)
    }
}
