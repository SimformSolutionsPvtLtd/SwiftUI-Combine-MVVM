//
//  Book.swift
//  MVVMSwiftUICombineDemo
//
//  Created by Simform Solutions on 28/01/22.
//

import Foundation
import FirebaseFirestoreSwift
import Firebase

struct Book: Codable, Hashable, Identifiable {
    
    static func ==(lhs: Book, rhs: Book) -> Bool {
        return lhs.title == rhs.title
    }
    
    @DocumentID var id: String?
    let title: String
    var price: Float
    let author: String
    
    static func getMock() -> Book {
        Book(id: "\((0...150).randomElement() ?? 0)", title: "SwiftUI", price: 11.49, author: "Simform")
    }
    
}
