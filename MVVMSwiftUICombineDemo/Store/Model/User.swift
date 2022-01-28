//
//  User.swift
//  MVVMSwiftUICombineDemo
//
//  Created by Simform Solutions on 28/01/22.
//

import Foundation
import FirebaseFirestoreSwift

struct User: Codable, Equatable, Identifiable, Hashable {
    
    static func ==(lhs: User, rhs: User) -> Bool {
        return lhs.id! == rhs.id!
    }
    
    @DocumentID var id: String?
    let firstName: String
    let lastName: String
    let username: String
    let email: String

    var fullName: String {
        "\(firstName) \(lastName)"
    }
    
    enum CodingKeys: String, CodingKey {
        case id, email, username
        case firstName = "first_name"
        case lastName = "last_name"
       
    }
    
    static var mock: [User] {
        [
            User(id: "0", firstName: "John", lastName: "Doe", username: "john", email: "john@test.com")
        ]
    }
}
