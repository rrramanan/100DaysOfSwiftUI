//
//  EditCards.swift
//  Flashzilla
//
//  Created by Ramanan on 10/02/23.
//

import SwiftUI

struct EditCards: View {
    
    //@StateObject var card = CardClass()
    @ObservedObject var card: CardClass
    @State var addPrompt = ""
    @State var addAnswer = ""
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            VStack {
                List(0..<2) { section in
                    if section == 0 {
                        Section {
                            TextField("Enter your prompt", text: $addPrompt)
                            TextField("Enter your Answer", text: $addAnswer)
                            Button("Add New Card") {
                                Save()
                            }
                            .disabled(addPrompt.count == 0 || addAnswer.count == 0)
                        } header: {
                            Text("Add New Card")
                                .font(.caption2)
                                .foregroundColor(.gray)
                        }
                        
                    } else {
                        Section {
                            ForEach(0..<card.cardData.count, id: \.self) { index in
                                VStack(alignment: .leading) {
                                    Text(card.cardData[index].prompt)
                                        .font(.title2)
                                        .foregroundColor(.white)
                                    
                                    Text(card.cardData[index].answer)
                                        .font(.title3)
                                        .foregroundColor(.gray)
                                }
                            }
                            .onDelete(perform: deleteItem)
                        } header: {
                            Text("List of cards")
                                .font(.caption2)
                                .foregroundColor(.gray)
                        }
                    }
                }//
            }
            .navigationTitle("Edit View")
            .navigationBarItems(trailing:
                Button("Done") {
                 dismiss()
            })
        }
    }
    
    func Save() {
        let trimmedPrompt = addPrompt.trimmingCharacters(in: .whitespaces)
        let trimmedAnswer = addAnswer.trimmingCharacters(in: .whitespaces)
        guard trimmedPrompt.isEmpty == false && trimmedAnswer.isEmpty == false else { return }
        
        let new = Card(id: UUID(), prompt: trimmedPrompt, answer: trimmedAnswer)
            //card.cardData.append(new)
            card.cardData.insert(new, at: 0)
            addAnswer = ""
            addPrompt = ""
            card.SaveAsCodable()
    }
    
    func deleteItem(at offset: IndexSet) {
        card.cardData.remove(atOffsets: offset)
        card.SaveAsCodable()
    }
    
//    func SaveAsCodable() {
//        if let encoded = try? JSONEncoder().encode(card.cardData) {
//            UserDefaults.standard.set(encoded, forKey: "cards")
//        }
//    }
}

struct EditCards_Previews: PreviewProvider {
    static var previews: some View {
        EditCards(card: CardClass(), addPrompt: "", addAnswer: "")
            .preferredColorScheme(.dark)
    }
}
