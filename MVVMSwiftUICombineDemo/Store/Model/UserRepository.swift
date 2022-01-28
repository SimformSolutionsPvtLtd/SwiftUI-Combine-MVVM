//
//  UserRepository.swift
//  Peek
//
//  Created by Peek Team on 07/03/2021.
//

import Foundation
import Firebase
import FirebaseFirestore

struct UserRepository {
    static let shared = UserRepository()
    private let auth = Auth.auth()
    private let firestore = Firestore.firestore()
    private let storage = Storage.storage()
    
    func fetchUser(_ uid: String, completion: @escaping (Result<User, PeekError>) -> ()) {
        firestore.collection(FirestoreCollections.users.rawValue)
            .document(uid)
            .getDocument(completion: { (snapshot, err) in
            if let err = err { print(err.localizedDescription); return }
            do {
                guard let user = try snapshot?.data(as: User.self) else {
                    debugPrint("uID: \(uid)")
                    completion(.failure(PeekError.customError("Could not fetch user")))
                    return
                }
                
                completion(.success(user))
            } catch let error {
                completion(.failure(PeekError.commonError(error)))
            }
        })
    }
    
    func fetchAuthor(_ id: String, isFromMobile: Bool, completion: @escaping (Result<PeekAuthor, PeekError>) -> ()) {
        if isFromMobile {
            firestore.collection(FirestoreCollections.users.rawValue)
                .document(id)
                .getDocument(completion: { (snapshot, err) in
                if let err = err { print(err.localizedDescription); return }
                do {
                    guard let author = try snapshot?.data(as: PeekAuthor.self) else {
                        completion(.failure(PeekError.customError("Could not fetch author")))
                        return
                    }
                    
                    completion(.success(author))
                } catch let error {
                    completion(.failure(PeekError.commonError(error)))
                }
            })
        } else {
            firestore.collection(FirestoreCollections.authors.rawValue)
                .document(id)
                .getDocument(completion: { (snapshot, err) in
                if let err = err { print(err.localizedDescription); return }
                do {
                    guard let author = try snapshot?.data(as: PeekAuthor.self) else {
                        completion(.failure(PeekError.customError("Could not fetch author")))
                        return
                    }
                    
                    completion(.success(author))
                } catch let error {
                    completion(.failure(PeekError.commonError(error)))
                }
            })
        }
        
    }
    
    func fetchPublisher(_ id: String, completion: @escaping (Result<Publisher, PeekError>) -> ()) {
        firestore.collection(FirestoreCollections.publishers.rawValue)
            .document(id)
            .getDocument(completion: { (snapshot, err) in
            if let err = err { print(err.localizedDescription); return }
            do {
                guard let publisher = try snapshot?.data(as: Publisher.self) else {
                    completion(.failure(PeekError.customError("Could not fetch publisher")))
                    return
                }
                completion(.success(publisher))
            } catch let error {
                completion(.failure(PeekError.commonError(error)))
            }
        })
    }
    
    func checkAppVersionAndBuild(completion: @escaping (Result<Bool, PeekError>) -> ()) {
        firestore.collection(FirestoreCollections.iOSbuildVersions.rawValue)
            .addSnapshotListener{ (snapshot, err) in
            if let err = err { print(err.localizedDescription); return }
            do {
                if (snapshot?.documents.count ?? 0) > 0 {
                    if let data = snapshot?.documents.last {
                        let dataDict = data.data()
                        if let versionNumber = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String , let buildNumber = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String {
                            let versionLive = dataDict["version"] as? String
                            let buildLive = dataDict["build"] as? String
                            if versionNumber == versionLive {
                                if (Int(buildNumber) ?? 0) >= (Int(buildLive ?? "0") ?? 0) {
                                    completion(.success(true))
                                } else {
                                    completion(.success(false))
                                }
                            } else {
                                completion(.success(false))
                            }
                        }
                    }
                } else {
                    completion(.success(false))
                }
            }
        }
    }
    
    func fetchTableNameFromUid(uID: String, email: String, completion: @escaping (Result<String, PeekError>) -> ()) {
        let data = ["user_id": uID, "email": email]
        Functions.functions().httpsCallable(StripeHTTPSFunctions.checkForUserTable).call(data) { (result, err) in
            if let err = err {
                debugPrint(err.localizedDescription)
                return
            }
            if let tblName = result?.data as? String {
                completion(.success(tblName))
            }
        }
    }
    
    
    func deleteUser(withID id: String, completion: @escaping (PeekError?) -> ()) {
        firestore.collection(FirestoreCollections.users.rawValue).document(id).delete { (err) in
            if let err = err {
                completion(PeekError.commonError(err))
                return
            }
            completion(.none)
        }
    }
    
    
    func editUser(withID id: String, data: [String:Any], completion: @escaping (PeekError?) -> ()) {
        if let image = data["image"] as? UIImage {
            let storageRef: StorageReference = storage.reference().child("users").child(id).child("avatar")
            Storage.uploadImage(image: image, reference: storageRef) { (result) in
                switch result {
                case .success(let profileImageURL):
                    var newData = data
                    newData["profile_image_url"] = profileImageURL
                    newData.removeValue(forKey: "image")
                    Firestore.firestore().collection(FirestoreCollections.users.rawValue)
                        .document(id).setData(newData, merge: true) { (err) in
                        if let err = err {
                            print(err.localizedDescription)
                            completion(PeekError.commonError(err))
                            return
                        }
                        completion(.none)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    completion(PeekError.commonError(error))
                }
            }
        } else {
            Firestore.firestore().collection(FirestoreCollections.users.rawValue)
                .document(id).setData(data, merge: true) { (err) in
                    if let err = err {
                        completion(PeekError.commonError(err))
                        return
                    }
                    completion(.none)
                }
        }
    }
}
