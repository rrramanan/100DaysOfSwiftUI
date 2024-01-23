//
//  Prospect.swift
//  HotProspects
//
//  Created by Ramanan on 31/01/23.
//

import SwiftUI

class Prospect: Identifiable, Codable, Comparable, Equatable {
    var id = UUID()
    var name = "Anonymous"
    var emailAddress = ""
    fileprivate(set) var isContacted = false
    
    static func <(lhs: Prospect, rhs: Prospect) -> Bool {
        lhs.name < rhs.name
    }
    
    static func == (lhs: Prospect, rhs: Prospect) -> Bool {
        lhs.id == rhs.id
    }
}

@MainActor class Prospects: ObservableObject {
    @Published private(set) var people: [Prospect]
    let saveKey = "SavedData"
    let path = FileManager.documentDirectory.appendingPathComponent("prospect.json")
    
    init() {
        /*
        if let data = UserDefaults.standard.data(forKey: saveKey) {
            if let decoded = try? JSONDecoder().decode([Prospect].self, from: data) {
                people = decoded
                return
            }
        }
         
         //no saved data!
         //people = []
        */
        
        do {
            let data = try Data(contentsOf: path)
            people = try JSONDecoder().decode([Prospect].self, from: data)
        } catch {
            people = []
        }
    }
    
    private func save() {
        do {
            let encoded = try JSONEncoder().encode(people)
            try encoded.write(to: path, options: [.atomic, .completeFileProtection])
        } catch {
            print("unable to save data")
        }
        
        /*
        if let encoded = try? JSONEncoder().encode(people) {
            UserDefaults.standard.set(encoded, forKey: saveKey)
        }
        */
    }
    
    func add(_ prosepect: Prospect) {
        people.append(prosepect)
        save()
    }
    
    func toggle(_ prospect: Prospect) {
        objectWillChange.send()
        prospect.isContacted.toggle()
        save()
    }
}
