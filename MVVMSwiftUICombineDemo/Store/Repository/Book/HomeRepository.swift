//
//  BookRepository.swift
//  MVVMSwiftUICombineDemo
//
//  Created by Simform Solutions on 28/01/22.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth
import Firebase

struct HomeRepository {
    
    private let firetore = Firestore.firestore()
    
    // MARK: Fetch book from firebase databse.
    func fetchBooks(completion: @escaping (Result<[Book], AppError>) -> ()) {
        firetore.collection(FirestoreCollections.books.rawValue)
            .addSnapshotListener({ (querySnapshot, error) in
            if let error = error {
                print(error.localizedDescription);
                completion(.failure(AppError.commonError(error)))
                return
            }
            guard let documents = querySnapshot?.documents else {return}

            let books = documents.compactMap { (queryDocumentSnapshot) -> Book? in
                return try? queryDocumentSnapshot.data(as: Book.self)
            }
            completion(.success(books))
        })
    }
}
