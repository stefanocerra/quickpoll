//
//  GroupListItem.swift
//  quickpoll
//
//  Created by Stefano Cerra on 26.08.22.
//

import SwiftUI

struct GroupListItem: View {
    
    let group: PollGroup
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(group.name)
                .fontWeight(.semibold)
                .lineLimit(1)
                .minimumScaleFactor(1)
            Text(group.code)
                .font(.subheadline)
                .lineLimit(1)
                .minimumScaleFactor(1)
                .foregroundColor(.secondary)
        }
        .padding(.vertical, 4)
    }
}

struct GroupListItem_Previews: PreviewProvider {
    static var previews: some View {
        GroupListItem(group: PollGroup(name: "Testgroup", code: "asdf", users: nil))
            .previewLayout(.sizeThatFits)
    }
}
