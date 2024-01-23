//
//  CardClass.swift
//  Flashzilla
//
//  Created by Ramanan on 10/02/23.
//

import Foundation

@MainActor class CardClass: ObservableObject {
    @Published var cardData = [Card]()
    let savedPath = FileManager.documentsDirectory.appendingPathComponent("card")
    
    init() {
        loadData()
        if cardData.isEmpty {
            loadSampleData()
        }
    }
        
    func loadData() {
        do {
            let data = try Data(contentsOf: savedPath)
            cardData = try JSONDecoder().decode([Card].self, from: data)
        } catch {
            loadSampleData()
        }
        /*
        if let defaults = UserDefaults.standard.data(forKey: "cards") {
            if let decoded = try? JSONDecoder().decode([Card].self, from: defaults) {
                cardData = decoded
            }
        }
        */
    }
    
    func SaveAsCodable() {
        do {
            let data = try JSONEncoder().encode(cardData)
            try data.write(to: savedPath, options: [.atomic,.completeFileProtection])
        } catch {
            print("Unable to save")
        }
        
        /*
        if let encoded = try? JSONEncoder().encode(cardData) {
            UserDefaults.standard.set(encoded, forKey: "cards")
        }
         */
    }
    
    func loadSampleData() {
        cardData = [Card(id: UUID(), prompt: "WWomen Who", answer: "Gal Gadot"),
                    Card(id: UUID(), prompt: "Spy Who", answer: "Benedict Cumberbatch"),
                    Card(id: UUID(), prompt: "Killer Who", answer: "Uma Thurman"),
                    Card(id: UUID(), prompt: "Spider Who", answer: "Tobey Maguire")]
        SaveAsCodable()
    }
}
