//
//  VoteViewModel.swift
//  quickpoll
//
//  Created by Sandro Darnuzer on 04.09.22.
//

import Foundation
import Firebase

class VoteViewModel: ObservableObject {
    @Published var hasVoted: Bool = false
    @Published var results: [Double] = []
    
    private var listener: ListenerRegistration?
    
    private let db = DatabaseManager.instance
    private let auth = AuthManager.instance
    
    func checkVote(poll: Poll) async {
        let poll = await db.getDocument(collection: "polls", documentId: poll.id ?? "", as: Poll.self)
        let user = auth.getUser()?.uid
        
        guard let poll = poll, let user = user else {
            return
        }

        DispatchQueue.main.async {
            self.hasVoted = poll.users.contains(user)
        }
    }
    
    func getResults(poll: Poll) {
        self.listener = db.listenDocument(collection: "polls", documentId: poll.id ?? "", as: Poll.self) { [weak self] poll in
            let results = poll.results.values.map { Double($0) }
            
            if let self = self {
                DispatchQueue.main.async {
                    self.results = results
                }
            }
        }
    }
    
    func cancelResults() {
        if let listener = listener {
            listener.remove()
        }
    }
    
    func vote(poll: Poll, answer: String) async {
        
        let poll = await db.getDocument(collection: "polls", documentId: poll.id ?? "", as: Poll.self)
        
        guard let poll = poll else {
            return
        }
        
        let userId = auth.getUser()?.uid ?? ""
        
        var users = Set(poll.users)
        
        users.insert(userId)
        
        var results = poll.results
        
        if let option = results[answer] {
            results[answer] = option + 1
        }
        
        await db.updateDocument(collection: "polls", documentId: poll.id ?? "", data: [
            "users": Array(users),
            "results": results
        ])
    }
    
}
