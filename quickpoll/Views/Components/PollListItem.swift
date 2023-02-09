//
//  PollListItem.swift
//  quickpoll
//
//  Created by Stefano Cerra on 01.09.22.
//

import SwiftUI

struct PollListItem: View {
    
//    @State var edges = UIApplication.shared.windows.first?.safeAreaInsets
    
    @State var question: PollItem
    
    var body: some View {
        HStack {
            Text(question.title)
                .fontWeight(.semibold)
                .foregroundColor(Color.black.opacity(0.7))

            Spacer()

            ZStack {
                Circle()
                    .stroke(question.checked ? Color.accentColor :
                            Color.gray, lineWidth: 1)
                    .frame(width: 25, height: 25)
                if (question.checked) {
                    Image.init(systemName: "checkmark.circle.fill")
                        .font(.system(size: 25))
                        .foregroundColor(.accentColor)
                    
                }
            }
        }
        .padding(.horizontal)
        .contentShape(Rectangle())
        .onTapGesture(perform: {
            question.checked.toggle()
        })
    }
}

struct PollListItem_Previews: PreviewProvider {
    static var previews: some View {
        PollListItem(question: PollItem(id: UUID().uuidString, title: "Test", checked: false))
    }
}
