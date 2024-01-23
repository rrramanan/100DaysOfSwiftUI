//
//  UserData.swift
//  Project7-9
//
//  Created by Ramanan on 29/11/22.
//

import Foundation

struct UserData: Identifiable, Codable, Equatable {
    var id =  UUID()
    var Title: String
    var Details: String
    var Count: Int
}
