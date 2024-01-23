//
//  UserClass.swift
//  Project13-15
//
//  Created by Ramanan on 24/01/23.
//

import Foundation

class UserClass: ObservableObject {
    @Published var userData = [User]()
    let path = FileManager.documentsDirectory.appendingPathComponent("userlogs")
    
    init() {
        do {
            let data = try Data(contentsOf: path)
            let decodedValue = try JSONDecoder().decode([User].self, from: data)
            userData.append(contentsOf: decodedValue)
        }
        catch {
            userData = []
        }
    }
}
