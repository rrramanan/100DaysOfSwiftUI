//
//  Datacontroller.swift
//  Bookworm
//
//  Created by Ramanan on 12/12/22.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "Bookworm")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load \(error.localizedDescription) ")
            }
        }
    }
}
