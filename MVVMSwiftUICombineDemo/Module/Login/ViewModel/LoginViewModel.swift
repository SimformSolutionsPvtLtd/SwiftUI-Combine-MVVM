//
//  LoginViewModel.swift
//  MVVMSwiftUICombineDemo
//
//  Created by Simform Solutions on 28/01/22.
//

import Foundation

enum LoginInput {
    case login
}

class LoginViewModel: ViewModel {
    
    @Published var loginEmail = "demo@simformsolutions.com"
    @Published var loginPassword = "AdminTest@123"
    
    //MARK: STATES
    @Published var isLoading: Bool = false
    @Published var apiError: AppError? {
        didSet { isError = apiError != nil }
    }
    @Published var isError: Bool = false
    @Published var isAuthenticated: Bool = false
    
    var repository: LoginRepository
    
    init() {
        repository = LoginRepository()
    }
    
    func trigger(_ input: LoginInput) {
        switch input {
        case .login:
            handleLogin()
        }
    }
    
    private func handleLogin() {
        isLoading.toggle()
        DispatchQueue.main.async { [weak self] in
            guard let `self` = self else { return }
            self.isAuthenticated.toggle()
            self.repository.login(email: self.loginEmail, password: self.loginPassword) { (error) in
                self.isLoading.toggle()
                if let error = error {
                    self.apiError = error
                    return
                }
                self.isAuthenticated.toggle()
            }
        }
    }
    
}
