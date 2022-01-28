//
//  HomeViewModel.swift
//  MVVMSwiftUICombineDemo
//
//  Created by Simform Solutions on 28/01/22.
//

import SwiftUI
import Combine
import FirebaseAuth

enum HomeInput {
    case fetchData
    case signOut
    case clearError
}

class HomeViewModel: ViewModel {
    //MARK: STATES
    @Published var isLoading: Bool = false
    @Published var apiError: AppError? {
        didSet { isError = apiError != nil }
    }
    @Published var isError: Bool = false
    @Published var books: [Book] = []
    @Published var searchedBooks = [Book]()
    @Published var searchText = ""
    
    var repository: HomeRepository
    private var cancellableSet: Set<AnyCancellable> = []
    
    init() {
        repository = HomeRepository()
        $searchText.receive(on: DispatchQueue.main)
            .sink { [weak self] value in
            guard let `self` = self else {
                return
            }
            self.applyFilter(value: value)
        }.store(in: &cancellableSet)
    }
    
    private func applyFilter(value: String) {
        if value.isEmpty {
            self.searchedBooks = self.books
        } else {
            self.searchedBooks = self.books.filter { $0.title.localizedCaseInsensitiveContains(value) }
        }
    }
    
    func trigger(_ input: HomeInput) {
        switch input {
        case .fetchData:
            handleFetchData()
        case .signOut:
            handleSignOut()
        case .clearError:
            handleClearError()
        }
    }
    
    
    private func handleFetchData() {
        self.isLoading = true
        repository.fetchBooks { result in
            self.isLoading = false
            switch result {
            case .success(let books):
                self.books = books
                self.applyFilter(value: self.searchText)
            case .failure(let error):
                self.apiError = error
            }
        }
    }
    
    private func handleClearError() {
        searchText = ""
        books = []
        searchedBooks = []
    }
    
    
    private func handleSignOut() {
        do {
            try Auth.auth().signOut()
            handleClearError()
            UIApplication.shared.connectedScenes
                    .filter({$0.activationState == .foregroundActive})
                    .compactMap({$0 as? UIWindowScene})
                    .first?.windows
                    .filter({$0.isKeyWindow}).first?.rootViewController = UIHostingController(rootView: LoginView(loginEmail: "demo@simformsolutions.com").navigationBarHidden(true).navigationBarBackButtonHidden(false))
        } catch let error {
            print(error.localizedDescription)
        }
    }
}
