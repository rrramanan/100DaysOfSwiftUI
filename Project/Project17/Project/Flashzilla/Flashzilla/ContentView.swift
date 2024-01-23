//
//  ContentView.swift
//  Flashzilla
//
//  Created by Ramanan on 08/02/23.
//

import SwiftUI

extension View {
    func stacked(at position: Int , in total: Int) -> some View {
         let offset = Double(total - position)
        return self.offset(x: 0, y: offset * 10)
    }
}

struct ContentView: View {
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    @Environment(\.accessibilityVoiceOverEnabled) var voiceOverEnabled
    //@State private var cards = Array(repeating: Card.example, count: 10) //Array<Card>
    
    @State private var timeRemaining = 100
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @Environment(\.scenePhase) var scenePhase
    @State private var isActive = false
    
    @State private var showingEditScreen = false
    
    @StateObject var cards = CardClass()
    //@ObservedObject var cards: CardClass
    
    var body: some View {
        ZStack {
            Image("background")
                .resizable()
                .ignoresSafeArea()
            
            VStack {
                Text("Time: \(timeRemaining)")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 5)
                    .background(.black.opacity(0.75))
                    .clipShape(Capsule())
                
                ZStack {
                    ForEach(0..<cards.cardData.count, id:\.self) { index in
                        CardView(card: cards.cardData[index]) { flag in
                            withAnimation {
                              removeCard(at: index, with: flag)
                            }
                        }
                        .stacked(at: index, in: cards.cardData.count)
                        .allowsHitTesting(index == cards.cardData.count - 1)
                        .accessibilityHidden(index < cards.cardData.count - 1)
                    }
                }
                .allowsHitTesting(timeRemaining > 0)
                
                if cards.cardData.isEmpty {
                    Button("Start Again", action: resetCards)
                        .padding()
                        .background(.white)
                        .foregroundColor(.black)
                        .clipShape(Capsule())
                }
            }
            
            VStack {
                HStack {
                    Spacer()

                    Button {
                        showingEditScreen = true
                    } label: {
                        Image(systemName: "plus.circle")
                            .padding()
                            .background(.black.opacity(0.7))
                            .clipShape(Circle())
                    }
                }

                Spacer()
            }
            .foregroundColor(.white)
            .font(.largeTitle)
            .padding()
            
            if differentiateWithoutColor || voiceOverEnabled {
                VStack {
                    Spacer()
                    
                    HStack {
                        Button {
                            withAnimation {
                               removeCard(at: cards.cardData.count - 1, with: false)
                            }
                        } label: {
                            Image(systemName: "xmark.circle")
                                .padding()
                                .background(.black.opacity(0.7))
                                .clipShape(Circle())
                        }
                        .accessibilityLabel("Wrong")
                        .accessibilityHint("Mark your answer as being incorrect")
                        
                        Spacer()
                        
                        Button {
                            withAnimation {
                                removeCard(at: cards.cardData.count - 1, with: true)
                            }
                        } label: {
                            Image(systemName: "checkmark.circle")
                                .padding()
                                .background(.black.opacity(0.7))
                                .clipShape(Circle())
                        }
                        .accessibilityLabel("Correct")
                        .accessibilityHint("Mark your answer is being correct.")
                       
                    }
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .padding()
                }
            }
        }
        .onReceive(timer) { time in
            guard isActive else { return }
             
            if timeRemaining > 0 {
                timeRemaining -= 1
            }
        }
        .onChange(of: scenePhase) { newPhase in
            if newPhase == .active {
                if cards.cardData.isEmpty == false {
                    isActive = true
                }
            } else {
                isActive = false
            }
        }
        .sheet(isPresented: $showingEditScreen, onDismiss: resetCards) {
            EditCards(card: cards)
        }
        .onAppear(perform: resetCards)
       
       
    }
    
    func removeCard(at index: Int,with flag: Bool) {
        guard index >= 0 else { return }
        
        let localCopy = cards.cardData[index]
        cards.cardData.remove(at: index)
        
        if !flag {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                cards.cardData.insert(localCopy, at: 0)
                cards.SaveAsCodable()
            }
        } else {
            cards.SaveAsCodable()
        }
        
        if cards.cardData.isEmpty {
            isActive = false
        }
    }
    
    func resetCards() {
        
        //cards = Array(repeating: Card.example, count: 10)//Array<Card>
        timeRemaining = 100
        isActive = true
        cards.loadData()
        if cards.cardData.count == 0 {
            cards.loadSampleData()
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(cards: CardClass())
            .preferredColorScheme(.dark)
    }
}
