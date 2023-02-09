//
//  SettingsView.swift
//  quickpoll
//
//  Created by Stefano Cerra on 26.08.22.
//

import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject var userViewModel: UserViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    Section {
                        HStack {
                            Text("Benutzername:")
                            Spacer()
                            Text(userViewModel.user?.email ?? "")
                                .foregroundColor(.secondary)
                        }
                    }
                    Section {
                        Button() {
                            userViewModel.logout()
                        } label: {
                            Text("Ausloggen")
                                .foregroundColor(.white)
                                .padding(.vertical, 14)
                        }
                        .frame(maxWidth: .infinity)
                        .background(Color.red)
                        .cornerRadius(8)
                        .padding(.horizontal, -20)
                        .listRowBackground(Color.clear)
                    }

                }
                .listStyle(.insetGrouped)
            }
            .navigationTitle("Einstellungen")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(UserViewModel())
    }
}
