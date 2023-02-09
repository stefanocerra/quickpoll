//
//  GroupDetailList.swift
//  quickpoll
//
//  Created by Stefano Cerra on 02.09.22.
//

import SwiftUI

struct GroupDetailList: View {
    
    let polls: [Poll]?
    
    var body: some View {
        VStack {        
            if let polls = polls {
                List {
                    ForEach(polls) { poll in
                        NavigationLink {
                            PollView(poll: poll)
                        } label: {
                            GroupDetailListItem(poll: poll)
                        }
                        
                    }
                }
            } else {
                Text("Noch keine Abstimmungen.")
            }
        }
        
    }
}

struct GroupDetailList_Previews: PreviewProvider {
    static var previews: some View {
        GroupDetailList(polls: nil)
    }
}
