//
//  Poll.swift
//  quickpoll
//
//  Created by Sandro Darnuzer on 04.09.22.
//

import Foundation
import FirebaseFirestoreSwift

struct Poll: Identifiable, Codable {
    @DocumentID var id: String?
    let date: Date
    let results: [String : Int]
    let group: String
    let users: [String]
}
