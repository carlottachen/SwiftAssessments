//
//  Item.swift
//  ShoppingList
//
//  Created by Carlotta Chen on 1/21/22.
//

import Foundation

class Item: Codable {
    var name: String
    var notes: String?
    var purchased: Bool
    
    init(name: String, notes: String?, purchased: Bool = false){
        self.name = name
        self.notes = notes
        self.purchased = purchased
    }
}

extension Item: Equatable {
    static func == (lhs: Item, rhs: Item) -> Bool {
        return lhs.name == rhs.name && lhs.notes == rhs.notes && lhs.purchased == rhs.purchased
    }
}
