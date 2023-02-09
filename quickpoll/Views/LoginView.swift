//
//  LoginView.swift
//  quickpoll
//
//  Created by Sandro Darnuzer on 01.09.22.
//

import SwiftUI

struct LoginView: View {
    
    enum LoginState: String {
        case login = "Einloggen"
        case register = "Registrieren"
    }
    
    @EnvironmentObject var userViewModel: UserViewModel
    
    @State var email = ""
    @State var password = ""
    @State var repassword = ""
    
    @State var loginState: LoginState = .login
    
    var body: some View {
        VStack {
            
            Text(loginState.rawValue)
                .font(.largeTitle)
                .fontWeight(.bold)
            
            VStack(spacing: 12) {
                TextField("Email", text: $email)
                    .keyboardType(.emailAddress)
                    .disableAutocorrection(true)
                    .padding(8)
                    .background(.quaternary)
                    .cornerRadius(8)
                
                SecureField("Password", text: $password)
                    .padding(8)
                    .background(.quaternary)
                    .cornerRadius(8)
                
                if loginState == .register {
                    SecureField("Repeat Password", text: $repassword)
                        .padding(8)
                        .background(.quaternary)
                        .cornerRadius(8)
                }
                
                HStack {
                    Button(loginState.rawValue) {
                        Task {
                            switch loginState {
                            case .login:
                                await userViewModel.login(email: email, password: password)
                            case .register:
                                await userViewModel.register(email: email, password: password, repassword: repassword)
                            }
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    
                    Button(loginState == .login ? "Registrieren" : "Einloggen") {
                        switchState()
                    }
                    .buttonStyle(.bordered)
                }
                .padding(.top)
                
                if let errorMessage = userViewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                }
                
            }
            .padding(.horizontal, 50)
        }

            
    }
    
    func switchState() {
        switch loginState {
        case .login:
            loginState = .register
        case .register:
            loginState = .login
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(UserViewModel())
    }
}
