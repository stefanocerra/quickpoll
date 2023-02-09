//
//  AuthManager.swift
//  quickpoll
//
//  Created by Sandro Darnuzer on 01.09.22.
//

import Foundation
import FirebaseAuth

class AuthManager {
    
    static let instance = AuthManager()
    private let auth = Auth.auth()
    
    private init() { }
    
    private func validatePassword(password: String, repassword: String) -> Bool {
        return password == repassword
    }
    
    func register(email: String, password: String, repassword: String) async throws -> User {
        
        guard validatePassword(password: password, repassword: repassword) else {
            throw AuthError.passwordDontMatch
        }
        
        do {
            let result = try await auth.createUser(withEmail: email, password: password)
            return result.user
        } catch AuthErrorCode.invalidEmail {
            throw AuthError.invalidEmail
        } catch AuthErrorCode.emailAlreadyInUse {
            throw AuthError.emailAlreadyInUse
        } catch AuthErrorCode.weakPassword {
            throw AuthError.weakPassword
        }
    }
    
    func login(email: String, password: String) async throws -> User {
        do {
            let result = try await auth.signIn(withEmail: email, password: password)
            return result.user
        } catch AuthErrorCode.invalidEmail {
            throw AuthError.invalidEmail
        } catch AuthErrorCode.wrongPassword {
            throw AuthError.wrongPassword
        }
    }
    
    func getUser() -> User? {
        return auth.currentUser
    }
    
    func logout() throws {
        try auth.signOut()
    }
}
