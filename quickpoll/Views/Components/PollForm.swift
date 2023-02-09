//
//  PollForm.swift
//  quickpoll
//
//  Created by Sandro Darnuzer on 03.09.22.
//

import SwiftUI

struct PollForm: View {
    
    @EnvironmentObject var pollViewModel: PollViewModel
        
    @State private var options: [String] = []
    
    @Binding var showPopover: Bool
    
    @State private var showField = false
    @State private var optionText = ""
    
    let group: PollGroup
    
    @FocusState private var isFocus: Bool
    
    var body: some View {
        VStack {
            HStack {
                Text("Umfrage erstellen")
                    .font(.title)
                Spacer()
                Button("Fertig") {
                    Task {
                        await pollViewModel.createPoll(group: group, options: options)
                        await pollViewModel.getPolls(group: group)
                        showPopover = false
                    }
                }
            }
            .padding()
            
            List {
                ForEach(options, id: \.self) { option in
                    Text(option)
                }
                .onDelete { indexSet in
                    options.remove(atOffsets: indexSet)
                }
                
                if showField {
                    TextField("new item...", text: $optionText)
                        .focused($isFocus)
                }

            }
            .listStyle(.inset)
            .onTapGesture {
                
                if showField {
                    if !optionText.isEmpty {
                        options.append(optionText)
                    }
                    optionText = ""
                    isFocus = false
                    showField = false
                } else {
                    showField = true
                    isFocus = true
                }
                
            }
        }
    }
}

struct PollForm_Previews: PreviewProvider {
    static var previews: some View {
        PollForm(showPopover: .constant(true), group: PollGroup(name: "test", code: "df", users: ["asd"]))
            .environmentObject(PollViewModel())
    }
}
