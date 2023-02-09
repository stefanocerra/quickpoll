//
//  GroupList.swift
//  quickpoll
//
//  Created by Stefano Cerra on 26.08.22.
//

import SwiftUI

struct GroupList: View {
    
    let groups: [PollGroup]?
    
    var body: some View {
        if let groups = groups {
            List {
                ForEach(groups) { group in
                    NavigationLink {
                        GroupDetailView(group: group)
                    } label: {
                        GroupListItem(group: group)
                    }

                }
            }
        } else {
            Text("Keine Gruppen")
        }
    }
}

struct GroupList_Previews: PreviewProvider {
    static var previews: some View {
        GroupList(groups: [
            PollGroup(name: "Testgroup 1", code: "asdf", users: nil),
            PollGroup(name: "Testgroup 2", code: "fasd", users: nil),
            PollGroup(name: "Testgroup 3", code: "qwer", users: nil),
        ])
    }
}
