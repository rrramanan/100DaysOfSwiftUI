//
//  User.swift
//  Project10-12
//
//  Created by Ramanan on 19/12/22.
//

import Foundation

struct User: Codable, Identifiable {
    var id: String
    var name: String
    var age: Int
    var isActive: Bool
    var company: String
    var email: String
    var about: String
    var registered: Date
    
    var formattedDate: String {
        return registered.formatted(date: .long, time: .standard)
    }
    
    var tags: [String]
    var friends: [Friends]
}

struct Friends: Codable, Identifiable {
    var id: String
    var name: String
}
