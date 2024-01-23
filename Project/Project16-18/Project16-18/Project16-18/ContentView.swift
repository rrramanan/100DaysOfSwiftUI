//
//  ContentView.swift
//  Project16-18
//
//  Created by Ramanan on 20/02/23.
//

import SwiftUI

struct ContentView: View {
    var diceSides = [4,6,8,10,12,20,100]
    @State private var diceCount = 1
    @State private var finalDiceCount = 1
    @State private var sideSelected = 0
    @State private var showDiceView = false
    @State private var uiLockFlag = true
    @State private var counter = 0.0
    @State var timer = Timer.publish(every: 0.2, on: .main, in: .common).autoconnect()
    @State private var feedback = UINotificationFeedbackGenerator()
    let layout = [GridItem(.adaptive(minimum: 70, maximum: 120))]
    
    @StateObject var user = UserClass()
    
    var diceSideValue: Int {
        diceSides[sideSelected]
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Section {
                    Stepper("Dice Selected: \(diceCount)", value: $diceCount, in: 1...20)
                        .font(.subheadline.bold().monospaced())
                    
                    HStack {
                        Text("Select Sides:")
                            .font(.headline.bold().monospaced())
                        Spacer()
                        Picker("Select Sides:", selection: $sideSelected) {
                            ForEach(0..<diceSides.count) { sel in
                                Text("\(diceSides[sel]) Sided")
                                    .background(.orange)
                            }
                        }
                        .padding([.leading, .trailing])
                        .background(.ultraThickMaterial)
                        .clipShape(Capsule(style: .circular))
                    }
                 
                    HStack(alignment: .center) {
                        Spacer()
                        Button {
                            diceRollAction()
                        } label: {
                            Text("Let's Roll!")
                                .padding()
                                .foregroundColor(.primary)
                                .font(.headline.bold().monospaced())
                                .background(LinearGradient(colors: [.blue.opacity(0.4),.white.opacity(0.4),.pink.opacity(0.2),.red.opacity(0.5)], startPoint: .topLeading, endPoint: .bottomTrailing))
                                .foregroundColor(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                        }
                        Spacer()
                    }
                   
                }
                .padding()
                .background(.black.opacity(0.35))
                .background(.ultraThinMaterial)
                
                if showDiceView {
                    ScrollView {
                        LazyVGrid(columns: layout) {
                            ForEach(0..<finalDiceCount, id:\.self) { item in
                                Text("\(user.diceValuesArray[item])")
                                    .font(.title.bold().monospacedDigit())
                                    .foregroundColor(.primary)
                                    .frame(width: 60, height: 60)
                                    .background(LinearGradient(colors: [.blue.opacity(0.45),.black.opacity(0.5),.pink.opacity(0.2),.red.opacity(0.6)], startPoint: .top, endPoint: .bottomTrailing))
                                //.background(LinearGradient(colors: [.blue.opacity(0.45),.white.opacity(0.4),.pink.opacity(0.2),.red.opacity(0.6)], startPoint: .top, endPoint: .bottomTrailing))
                                    .clipShape(RoundedRectangle(cornerRadius: 14))
                                    .foregroundColor(.white)
                            }
                        }
                    }
                    .padding()
                } else {
                    Spacer()
                }
            }
            .allowsHitTesting(uiLockFlag)
            .onChange(of: [diceCount,sideSelected] , perform: { _ in
                feedback.prepare()
            })
            .onAppear(perform: {
                timer.upstream.connect().cancel()
                //addDiceData() //
            })
            .onReceive(timer, perform: { _ in
                timerAction()
            })
            .navigationTitle("Project16-18")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
                        DetailView(user: user)
                    } label: {
                        Image(systemName: "list.dash")
                    }
                    .allowsHitTesting(uiLockFlag)
                }
            }
        }
    }
  
    func addDiceData() {
        user.diceValuesArray.removeAll()
        for _ in 1...diceCount {
            user.diceValuesArray.append(Int.random(in: 1...diceSideValue))
        }
    }
    
    func saveDiceValues() {
        let strArray = user.diceValuesArray.compactMap { val in
            String(val)
        }
        let str = strArray.joined(separator: ", ")
        user.diceValuesStorage_Array.insert(DiceValuesStorage(diceValue: str), at: 0)
        user.save_diceValue()
    }
    
    func saveDiceDetails() {
        var count = 0
        let _ = user.diceValuesArray.compactMap { val in
              count += val
        }
        let detail = "#Dice: \(diceCount) #Side: \(diceSideValue) #Total: \(count)"
        user.diceSideStorage_Array.insert(DiceSideStorage(diceSideValue: detail), at: 0)
        user.save_diceSide()
    }
    
    func diceRollAction() {
        counter = 0.0
        timer = Timer.publish(every: 0.2, on: .main, in: .common).autoconnect()
        uiLockFlag.toggle()
        feedback.notificationOccurred(.success)
    }
    
    func timerAction() {
        if counter > 3.0 {
            uiLockFlag.toggle()
            timer.upstream.connect().cancel()
            saveDiceValues()
            saveDiceDetails()
        } else {
            addDiceData()
        }
     
        if !showDiceView {
            showDiceView = true
        }
        
        if finalDiceCount != diceCount {
            finalDiceCount = diceCount
        }
        
        counter += 0.2
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}

/*
 //old action ***
 //showDiceView = true
 //finalDiceCount = diceCount
 //addDiceData()
 //counter = 0.0
 //timer = Timer.publish(every: 0.2, on: .main, in: .common).autoconnect()
 //uiLockFlag.toggle()
 //feedback.notificationOccurred(.success)
 */
