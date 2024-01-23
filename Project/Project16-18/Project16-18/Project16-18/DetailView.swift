//
//  DetailView.swift
//  Project16-18
//
//  Created by Ramanan on 21/02/23.
//

import SwiftUI

struct DetailView: View {
    @ObservedObject var user: UserClass
    
    var body: some View {
        List(0..<1) { _ in
            ForEach(0..<user.diceSideStorage_Array.count, id: \.self) { index in
                HStack(spacing:10) {
                    let customColor = customColor()
                   
                    Circle()
                        .foregroundColor(customColor)
                    .frame(width: 10, height: 10)
                        
                    VStack(alignment: .leading) {
                        Text("\(user.diceSideStorage_Array[index].diceSideValue)")
                            .foregroundColor(customColor)
                            .font(.headline.bold().monospaced())
                           
                        Text("\(user.diceValuesStorage_Array[index].diceValue)")
                            .font(.subheadline.bold().monospaced())
                    }
                }
            }
            .onDelete(perform: deleteRow)
        }
        .navigationTitle(user.diceSideStorage_Array.count > 0 ? "Your Rolls: \(user.diceSideStorage_Array.count)" : "Your Rolls")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                EditButton()
                    .disabled(user.diceSideStorage_Array.isEmpty)
            }
        }
    }
    
    func customColor() -> Color {
        return Color(hue: CGFloat.random(in: 0.1...1), saturation: CGFloat.random(in: 0.3...0.7), brightness: CGFloat.random(in: 0.5...0.9))
    }
    
    func deleteRow(at offset: IndexSet) {
        user.diceSideStorage_Array.remove(atOffsets: offset)
        user.diceValuesStorage_Array.remove(atOffsets: offset)
        user.save_diceSide()
        user.save_diceValue()
    }
    
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(user: UserClass())
            .preferredColorScheme(.dark)
    }
}


