//
//  AuthError.swift
//  quickpoll
//
//  Created by Sandro Darnuzer on 01.09.22.
//

import Foundation

enum AuthError: Error {
    case emailAlreadyInUse
    case invalidEmail
    case passwordDontMatch
    case wrongPassword
    case weakPassword
    
    var message: String {
        switch self {
        case .emailAlreadyInUse:
            return "Email wird bereits genutzt"
        case .invalidEmail:
            return "Ungültige Email"
        case .passwordDontMatch:
            return "Passwörter stimmen nicht überrein"
        case .wrongPassword:
            return "Falsches Passwort"
        case .weakPassword:
            return "Passwort ist zu schwach"
        }
    }
}
