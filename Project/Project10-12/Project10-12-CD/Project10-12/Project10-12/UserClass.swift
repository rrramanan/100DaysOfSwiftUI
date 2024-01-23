//
//  UserData.swift
//  Project10-12
//
//  Created by Ramanan on 20/12/22.
//

import Foundation
import CoreData

class UserClass: ObservableObject {
    @Published var allUsers = [User]()
    let container = NSPersistentContainer(name: "UserCore")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("-------- \(error.localizedDescription)")
            }
        }
    }
    
}
