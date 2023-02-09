//
//  DatabaseQuery.swift
//  quickpoll
//
//  Created by Sandro Darnuzer on 01.09.22.
//

import Foundation

struct DatabaseQuery {
    let field: String
    let value: Any
    let values: [Any]
    let compareOperator: CompareOperator
    
    init(field: String, compareOperator: CompareOperator, value: Any) {
        self.field = field
        self.compareOperator = compareOperator
        self.value = value
        self.values = []
    }
    
    init(field: String, compareOperator: CompareOperator, values: [Any]) {
        self.field = field
        self.compareOperator = compareOperator
        self.values = values
        self.value = ""
    }
    
}
