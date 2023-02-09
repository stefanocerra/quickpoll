//
//  quickpollApp.swift
//  quickpoll
//
//  Created by Sandro Darnuzer on 25.08.22.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseAuth

@main
struct quickpollApp: App {
    
    @StateObject var userViewModel = UserViewModel()
    @StateObject var groupViewModel = GroupViewModel()
    
    init() {
        FirebaseApp.configure()
        
        #if EMULATORS
            Auth.auth().useEmulator(withHost:"localhost", port:9099)
        
            let settings = Firestore.firestore().settings
            settings.host = "localhost:8080"
            settings.isPersistenceEnabled = false
            settings.isSSLEnabled = false
            Firestore.firestore().settings = settings
        #endif
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(userViewModel)
                .environmentObject(groupViewModel)
        }
    }
}
