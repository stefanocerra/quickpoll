//
//  PollItem.swift
//  quickpoll
//
//  Created by Stefano Cerra on 01.09.22.
//

import Foundation

struct PollItem: Identifiable {
    var id = UUID().uuidString
    var title: String
    var checked: Bool
}
