//
//  GroupDetailView.swift
//  quickpoll
//
//  Created by Stefano Cerra on 26.08.22.
//

import SwiftUI

struct GroupDetailView: View {
    
    @StateObject var pollViewModel = PollViewModel()
    
    @State var showNewScreen = false
    @State var showPollForm = false
    
    @State private var polls: [Poll]?
    
    let group: PollGroup
    
    var groupMembers = "Stefano, Joel, Sandro"
    
    var body: some View {
        VStack {
//            HStack {
//                Text("Teilnehmer: " + groupMembers)
//                    .font(.subheadline)
//                    .foregroundColor(.secondary)
//                    .lineLimit(2)
//                    .padding(.leading, 20)
//                    .padding(.trailing, 20)
//                    .padding(.top, 2)
//                    
//                Spacer()
//            }
            
            GroupDetailList(polls: pollViewModel.polls)
        }
        .task {
            await pollViewModel.getPolls(group: group)
        }
        .navigationTitle(group.name)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    showNewScreen.toggle()
                } label: {
                    Image(systemName: "info.circle")
                }

            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    showPollForm.toggle()
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        .popover(isPresented: $showNewScreen) {
            GroupDetailInfoScreen(group: group)
        }
        .popover(isPresented: $showPollForm) {
            PollForm(showPopover: $showPollForm, group: group)
        }
        .environmentObject(pollViewModel)
    }
}

struct GroupDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            GroupDetailView(group: PollGroup(name: "Test", code: "abc", users: ["asdf"]))
        }
        
    }
}
