//
//  MVVMSwiftUICombineDemoApp.swift
//  MVVMSwiftUICombineDemo
//
//  Created by Simform Solutions on 28/01/22.
//

import SwiftUI
import Firebase
import FirebaseAuth

@main
struct MVVMSwiftUICombineDemoApp: App {

    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            if Auth.auth().currentUser != nil {
                HomeView()
            } else {
                LoginView(loginEmail: "demo@simformsolutions.com").navigationBarHidden(true).navigationBarBackButtonHidden(false)
            }
        }
    }
}
