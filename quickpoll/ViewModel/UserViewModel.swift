//
//  UserViewModel.swift
//  quickpoll
//
//  Created by Sandro Darnuzer on 01.09.22.
//

import Foundation
import FirebaseAuth

class UserViewModel: ObservableObject {
    @Published var user: User?
    @Published var errorMessage: String?
    
    private let auth = AuthManager.instance
    
    init() {
        getUser()
    }
    
    func getUser() {
        self.user = auth.getUser()
    }
    
    func register(email: String, password: String, repassword: String) async {
        do {
            errorMessage = nil
            let user = try await auth.register(email: email, password: password, repassword: repassword)
            DispatchQueue.main.async {
                self.user = user
            }
        } catch let error as AuthError {
            DispatchQueue.main.async {
                self.errorMessage = error.message
            }
        } catch {
            print(error)
        }
    }
    
    func login(email: String, password: String) async {
        do {
            errorMessage = nil
            let user = try await auth.login(email: email, password: password)
            DispatchQueue.main.async {
                self.user = user
            }
        } catch let error as AuthError {
            DispatchQueue.main.async {
                self.errorMessage = error.message
            }
        } catch {
            print(error)
        }
    }
    
    func logout() {
        do {
            try auth.logout()
            self.user = nil
        } catch {
            print(error)
        }
    }
}
