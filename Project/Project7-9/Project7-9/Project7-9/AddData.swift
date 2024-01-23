//
//  AddData.swift
//  Project7-9
//
//  Created by Ramanan on 29/11/22.
//

import Foundation

class AddData: ObservableObject {
    @Published var items = [UserData]() {
        didSet {
            let encoder = JSONEncoder()
            if let encodedItems = try? encoder.encode(items) {
                UserDefaults.standard.set(encodedItems, forKey: "HabitData")
            }
        }
    }
 
    init() {
        if let loadItems = UserDefaults.standard.data(forKey: "HabitData") {
            if let decodedItems = try? JSONDecoder().decode([UserData].self, from: loadItems) {
                items = decodedItems
                return
            }
        }
        
        items = []
    }
    
}
