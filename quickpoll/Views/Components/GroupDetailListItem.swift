//
//  GroupDetailListItem.swift
//  quickpoll
//
//  Created by Stefano Cerra on 02.09.22.
//

import SwiftUI

struct GroupDetailListItem: View {
    
    let poll: Poll
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(poll.date.formatted(.dateTime))
        }
        .padding(.vertical, 4)
    }
}

struct GroupDetailListItem_Previews: PreviewProvider {
    static var previews: some View {
        GroupDetailListItem(poll: Poll(date: Date.now, results: ["asdf": 0], group: "asdf", users: []))
    }
}
