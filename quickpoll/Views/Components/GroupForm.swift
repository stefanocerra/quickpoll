//
//  GroupForm.swift
//  quickpoll
//
//  Created by Sandro Darnuzer on 02.09.22.
//

import SwiftUI

struct GroupForm: View {
    
    @EnvironmentObject var groupViewModel: GroupViewModel
    
    @State private var groupName = ""
    @Binding var showPopover: Bool
    
    var body: some View {
        VStack {
            HStack {
                Text("Gruppe erstellen")
                    .font(.title)
                Spacer()
                Button("Fertig") {
                    Task {
                        await groupViewModel.createGroup(name: groupName)
                        groupName = ""
                        showPopover.toggle()
                        await groupViewModel.getGroups()
                    }
                }
            }
            .padding()
            VStack(alignment: .leading) {
                Text("Gruppenname")
                    .opacity(0.7)
                TextField("Essen...", text: $groupName)
                    .padding(10)
                    .padding(.leading, 04)
                    .background(.quaternary)
                    .cornerRadius(8)
            }
            .padding(.horizontal)
        }
    }
}

struct GroupForm_Previews: PreviewProvider {
    static var previews: some View {
        GroupForm(showPopover: .constant(false))
            .environmentObject(GroupViewModel())
    }
}
