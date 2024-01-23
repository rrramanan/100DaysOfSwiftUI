//
//  ContentView.swift
//  WeSplit
//
//  Created by Ramanan on 11/10/22.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercantage = 20
    @FocusState private var amountIsFocused: Bool
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercantage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        return amountPerPerson
    }
    
    //challenge
    var totalAmountWithTip: Double {
        let tipSelection = Double(tipPercantage)
        let tipValue = checkAmount / 100 * tipSelection
        return checkAmount + tipValue
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format:
                        .currency(code: Locale.current.currencyCode ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                }
                //challenge .. change picker style, ForEach
                Section {
                    Picker("Tip percentage", selection: $tipPercantage) {
                        //ForEach(tipPercentages, id: \.self) {
                        ForEach(0..<101) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.automatic) //.segmented //#old
                } header: {
                    Text("How much tip do you want to leave?")
                }
                
                Section {
                    Text(totalPerPerson, format: .currency(code:Locale.current.currencyCode ?? "USD"))
                        .foregroundColor(tipPercantage == 0 ? .red : .white) //challenge P3
                } header: {
                    Text("Amount per person") //challenge
                }
                
                //challenge
                Section {
                    Text(totalAmountWithTip, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                } header: {
                    Text("Total amount with tips")
                }
            }//
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }//
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .preferredColorScheme(.dark)
        }
    }
}
