//
//  GroupModel.swift
//  quickpoll
//
//  Created by Sandro Darnuzer on 26.08.22.
//

import Foundation
import FirebaseFirestoreSwift

struct PollGroup: Codable, Identifiable {
    @DocumentID var id: String?
    let name: String
    let code: String
    let users: [String]?
}
