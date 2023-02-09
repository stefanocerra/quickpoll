//
//  PollList.swift
//  quickpoll
//
//  Created by Stefano Cerra on 01.09.22.
//

import SwiftUI

struct PollList: View {
    
    var groupName = "TestGroup"
    
//    @State var showQuestion = false
    
    @State var questions = [
        PollItem(title: "Test", checked: false),
        PollItem(title: "Test", checked: false),
        PollItem(title: "Test", checked: false),
        PollItem(title: "Test", checked: false),
        PollItem(title: "Test", checked: false)
    ]
    
    var body: some View {
        VStack(spacing: 18) {
            HStack {
                Text("Abstimmung: " + groupName)
                    .font(.title2)
                    .fontWeight(.heavy)
                    .foregroundColor(.black)
                
                Spacer()
                
                Button(action: {
//                    withAnimation{showQuestion.toggle()}
                }, label: {
                    Text("Done")
                        .fontWeight(.heavy)
                        .foregroundColor(.accentColor)
                })
            }
            .padding([.horizontal, .top])
            .padding(.bottom, 10)
            
            ForEach(questions) { question in
                PollListItem(question: question)
            }
            
            
        }
        .padding(.bottom, 10)
        .padding(.top, 10)
        .padding(.bottom, 50)
        .background(.green)
        .cornerRadius(35)
    }
}

struct PollList_Previews: PreviewProvider {
    static var previews: some View {
        PollList()
    }
}
