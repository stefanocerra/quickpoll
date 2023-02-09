//
//  PollViewModel.swift
//  quickpoll
//
//  Created by Sandro Darnuzer on 03.09.22.
//

import Foundation

class PollViewModel: ObservableObject {
    
    @Published var polls: [Poll]?
    @Published var voted: Bool?
    
    private let db = DatabaseManager.instance
    private let auth = AuthManager.instance

    
    func getPolls(group: PollGroup) async {
        let polls = await db.getData(collection: "polls", as: Poll.self, search: [
            DatabaseQuery(field: "group", compareOperator: .isEqualTo, value: group.id ?? "")
        ])
        
        DispatchQueue.main.async {
            self.polls = polls
        }
    }
    
    func createPoll(group: PollGroup, options: [String]) async {
        
        let results: [String : Int] = options.reduce([:]) { partialResult, option in
            var result = partialResult
            result[option] = 0
            return result
        }
        
        let poll = Poll(date: Date.now, results: results, group: group.id ?? "", users: [])
        
        let document = await db.createDocument(collection: "polls", data: poll)
        
        if document != nil {
            print("success")
        }
        
    }
}
