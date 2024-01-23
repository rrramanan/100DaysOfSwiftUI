//
//  UserClass.swift
//  Project16-18
//
//  Created by Ramanan on 21/02/23.
//

import Foundation

struct DiceValuesStorage: Codable, Identifiable {
    var id = UUID()
    var diceValue: String
}

struct DiceSideStorage: Codable, Identifiable {
    var id = UUID()
    var diceSideValue: String
}

class UserClass: ObservableObject {
    @Published var diceValuesArray = [Int]()
    @Published var diceValuesStorage_Array = [DiceValuesStorage]()
    @Published var diceSideStorage_Array = [DiceSideStorage]()
    
    let diceValuePath = FileManager.documentDirectory.appendingPathComponent("dicevalue")
    let diceSidePath = FileManager.documentDirectory.appendingPathComponent("diceside")
    
    init() {
        load_diceSide()
        load_diceValue()
    }
    
    func load_diceValue() {
        do {
            let data = try Data(contentsOf: diceValuePath)
            diceValuesStorage_Array = try JSONDecoder().decode([DiceValuesStorage].self, from: data)
        } catch {
            diceValuesStorage_Array = []
        }
    }
    
    func load_diceSide() {
        do {
            let data = try Data(contentsOf: diceSidePath)
            diceSideStorage_Array = try JSONDecoder().decode([DiceSideStorage].self, from: data)
        } catch {
            diceSideStorage_Array = []
        }
    }
    
    func save_diceValue() {
        do {
            let data = try JSONEncoder().encode(diceValuesStorage_Array)
            try data.write(to:diceValuePath, options: [.atomic, .completeFileProtection])
         
        } catch {
            print("Unable to save dice value")
        }
    }
    
    func save_diceSide() {
        do {
            let data = try JSONEncoder().encode(diceSideStorage_Array)
            try data.write(to:diceSidePath, options: [.atomic, .completeFileProtection])
         
        } catch {
            print("Unable to save dice side")
        }
    }
    
}
