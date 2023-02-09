//
//  GroupView.swift
//  quickpoll
//
//  Created by Stefano Cerra on 26.08.22.
//

import SwiftUI

struct GroupView: View {
    
    @EnvironmentObject var groupViewModel: GroupViewModel
    
    @State private var showAddPopover = false
    @State private var showJoinPopover = false
    
    var body: some View {
        NavigationView {
            GroupList(groups: groupViewModel.groups)
                .navigationTitle("Gruppen")
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Menu {
                            Button {
                                showJoinPopover.toggle()
                            } label: {
                                Label("Code scannen", systemImage: "qrcode")
                            }
                            
                            Button {
                            
                            } label: {
                                Label("Code eingeben", systemImage: "character.cursor.ibeam")
                            }
                        } label: {
                            Label("Gruppe beitreten", systemImage: "person.2.crop.square.stack.fill")
                        }
                        
                    }
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            showAddPopover.toggle()
                        } label: {
                            Label("Gruppe hinzufügen", systemImage: "plus")
                        }
                        
                    }
                }
                .task {
                    await groupViewModel.getGroups()
                }
                .refreshable {
                    Task {
                        await groupViewModel.getGroups()
                    }
                }
                .popover(isPresented: $showAddPopover) {
                    GroupForm(showPopover: $showAddPopover)
                }
                .popover(isPresented: $showJoinPopover) {
                    JoinGroupForm(showPopover: $showJoinPopover)
                }
                .alert("Fehler", isPresented: Binding.constant(groupViewModel.errorMessage != nil)) {
                    Button("OK") {
                        groupViewModel.errorMessage = nil
                    }
                } message: {
                    Text(groupViewModel.errorMessage ?? "")
                }
        }

    }
}

struct GroupView_Previews: PreviewProvider {
    static var previews: some View {
        GroupView()
            .environmentObject(GroupViewModel())
    }
}
