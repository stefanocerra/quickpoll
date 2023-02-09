//
//  PollView.swift
//  quickpoll
//
//  Created by Stefano Cerra on 01.09.22.
//

import SwiftUI



struct PollView: View {
    
    @StateObject var voteViewModel = VoteViewModel()
    
    let poll: Poll
    
    @State private var selected = ""
    
    var body: some View {
        VStack {
            
            if voteViewModel.hasVoted {
                PieDiagram(values: voteViewModel.results)
                    .padding()
                    .onAppear {
                        voteViewModel.getResults(poll: poll)
                    }
                    .onDisappear {
                        voteViewModel.cancelResults()
                    }
            } else {
                ScrollView {
                    ForEach(Array(poll.results.keys), id: \.self) { option in
                        HStack {
                            Text(option)
                            Spacer()
                            Image(systemName: option == selected ? "checkmark.circle.fill" : "circle")
                                .resizable()
                                .foregroundColor(.accentColor)
                                .frame(width: 16, height: 16)
                        }
                        .padding()
                        .background(option == selected ? .tertiary : .quaternary)
                        .cornerRadius(12)
                        .padding(.horizontal)
                        .onTapGesture {
                            selected = option
                        }
                    }
                    Divider()
                    Button("Speichern") {
                        if selected.isEmpty { return }
                        Task {
                            await voteViewModel.vote(poll: poll, answer: selected)
                            await voteViewModel.checkVote(poll: poll)
                        }
                    }
                    .padding(.top)
                }
            }
            
        }
        .task {
            await voteViewModel.checkVote(poll: poll)
        }
        .navigationTitle("Abstimmung")
    }
}

struct PollView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PollView(poll: Poll(id: "asdf", date: .now, results: ["opt 1": 0, "opt 2": 0], group: "asdf", users: [""]))
        }
    }
}
