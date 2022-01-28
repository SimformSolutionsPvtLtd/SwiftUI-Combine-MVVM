//
//  HomeView.swift
//  MVVMSwiftUICombineDemo
//
//  Created by Simform Solutions on 28/01/22.
//

import SwiftUI
import FirebaseAuth

struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel = ViewModelProvider.makeViewModel(.homeViewModel) {
        HomeViewModel()
    }
    
    var body: some View {
        NavigationView {
            List(viewModel.searchedBooks) { book in
                HStack(alignment: .top) {
                    Image("bookshelf")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 45).padding(.trailing)
                    VStack(alignment: .leading) {
                        Text(book.title)
                            .font(.headline)
                        Text("by \(book.author)")
                            .font(.subheadline)
                        Text("$ \(book.price, specifier: "%.2f")")
                            .font(.subheadline)
                    }
                    Spacer()
                }
            }
            .navigationTitle(Strings.books)
            .toolbar(content: {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button(action: {
                        viewModel.trigger(.signOut)
                    }, label: {
                        Image("logout")
                    })
                }
            })
            .loading(show: viewModel.isLoading)
            .onAppear {
                viewModel.trigger(.fetchData)
            }
            
        }.searchable(text: $viewModel.searchText, placement: .navigationBarDrawer(displayMode: .always)) {
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
