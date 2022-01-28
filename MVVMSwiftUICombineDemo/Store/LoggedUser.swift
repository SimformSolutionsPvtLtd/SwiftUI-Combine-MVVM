//
//  LoggedUser.swift
//  MVVMSwiftUICombineDemo
//
//  Created by Simform Solutions on 28/01/22.
//

import Foundation
import Firebase

struct LoggedUser: Codable, Equatable {
    
    var user: User
    var bookmarks: [String:User] = [:]
    
    init(user: User) {
        self.user = user
    }
    
    public static func == (lhs: LoggedUser, rhs: LoggedUser) -> Bool {
        return lhs.user.id == rhs.user.id
    }
    
    
    var toDict: [String:Any] {
        return [
            "first_name": user.firstName,
            "last_name": user.lastName,
            "email": user.email,
        ]
    }
}
