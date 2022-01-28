//
//  LoginView.swift
//  MVVMSwiftUICombineDemo
//
//  Created by Simform Solutions on 28/01/22.
//


import SwiftUI


struct LoginView: View {
    @ObservedObject var viewModel: LoginViewModel = ViewModelProvider.makeViewModel(.loginViewModel) {
        LoginViewModel()
    }
    let showBackButton: Bool = false
    var loginEmail: String?
    var body: some View {
        VStack(spacing:0) {
            DefaultHeader(hideDivider: true, showBack: showBackButton)
            VStack(spacing: 32) {
                HStack {
                    VStack(alignment: .leading) {
                        HStack {
                            Spacer()
                            Image("simform").resizable().frame(width: 80, height: 80)
                            Spacer()
                        }
                        Text(Strings.welcomeBack).font(.title).foregroundColor(.black).padding(.top)
                        Text(Strings.signInToContinue).font(.title3).foregroundColor(Color(UIColor.lightGray)).padding(.top, 1)
                    }.padding(.horizontal)
                }.padding(.top)
                TextFieldSection(viewModel: viewModel).padding(.horizontal)
                AppButton(title: Strings.signIn, feedback: .success, action: {viewModel.trigger(.login)}).padding(.horizontal)
            }
            Spacer()
        }
        .loading(show: viewModel.isLoading)
        .onChange(of: viewModel.isAuthenticated) { value in
            if value {
                UIApplication.shared.connectedScenes
                        .filter({$0.activationState == .foregroundActive})
                        .compactMap({$0 as? UIWindowScene})
                        .first?.windows
                        .filter({$0.isKeyWindow}).first?.rootViewController = UIHostingController(rootView: HomeView())
            }
        }
        .onAppear {
            viewModel.loginEmail = loginEmail ?? ""
        }
        .alert(isPresented: $viewModel.isError) { () -> Alert in
            Alert(title: Text(Strings.authenticationError), message: Text(viewModel.apiError!.localizedDescription), dismissButton: .default(Text(Strings.ok)))
        }
    }
}




struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

private struct TextFieldSection: View {
    @ObservedObject var viewModel: LoginViewModel
    
    var body: some View {
        VStack(alignment: .trailing) {
            DefaultTextField(title: Strings.email, icon: "email", value: $viewModel.loginEmail, keyboardType: .emailAddress)
            DefaultTextField(title: Strings.yourPassword, icon: "lock", isSecure: true, value: $viewModel.loginPassword)
        }
    }
}
