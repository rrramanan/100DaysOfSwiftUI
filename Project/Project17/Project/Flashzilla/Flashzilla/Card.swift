//
//  Card.swift
//  Flashzilla
//
//  Created by Ramanan on 08/02/23.
//

import Foundation

struct Card: Codable, Identifiable, Hashable {
    var id : UUID
    let prompt: String
    let answer: String
    
    static let example = Card(id: UUID(), prompt: "Who played the 13th Doctor in Doctor Who?", answer: "Jodie Whittaker")
}
