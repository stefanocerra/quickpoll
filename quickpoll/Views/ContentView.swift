//
//  ContentView.swift
//  quickpoll
//
//  Created by Sandro Darnuzer on 25.08.22.
//

import SwiftUI

struct ContentView: View {
    
    enum Tab {
        case groups
        case settings
    }
    
    @EnvironmentObject var userViewModel: UserViewModel
    
    @State var selection: Tab = .groups
    
    var body: some View {
        
        if userViewModel.user != nil {
            TabView(selection: $selection) {
                GroupView()
                    .tabItem {
                        Image(systemName: "person.3.fill")
                        Text("Gruppen")
                    }
                    .tag(Tab.groups)
                SettingsView()
                    .tabItem {
                        Image(systemName: "gear")
                        Text("Einstellungen")
                    }
                    .tag(Tab.settings)
            }
        } else {
            LoginView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(UserViewModel())
            .previewInterfaceOrientation(.portrait)
    }
}
