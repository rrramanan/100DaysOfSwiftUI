//
//  ContentView.swift
//  iExpense
//
//  Created by Ramanan on 14/11/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var expenses = Expenses()
    @State private var showingAddExpense = false
    
//    let example = [
//        "Personal": [ExpenseItem(id: UUID(), name: "tr", type: "Personal", amount: 100.00),ExpenseItem(id: UUID(), name: "yu", type: "Personal", amount: 20.00)],
//        "Business": [ExpenseItem(id: UUID(), name: "pop", type: "Business", amount: 600.00),ExpenseItem(id: UUID(), name: "loop", type: "Business", amount: 5.00)]
//    ] //Array(example.keys), id:\.self
    
    var body: some View {
        NavigationView {
            //challenge
            List {
                ForEach(0..<2) { item in
                    Section {
                        
//                        ForEach(example[item]!, id: \.id) { subItem in
//                            HStack {
//                                Text(subItem.name)
//                                    .font(.headline)
//                                Spacer()
//                                amount(subItem.amount)
//                            }
//                        }
                        
                        ForEach(expenses.items) { subItem in

                        if (item == 0 && subItem.type == "Personal") {

                                HStack {
                                    Text(subItem.name)
                                        .font(.headline)
                                    Spacer()
                                    amount(subItem.amount)
                                }
                                .accessibilityElement() //challenge p15
                                .accessibilityHint("Personal")
                                .accessibilityLabel("\(subItem.name) \(subItem.amount)")

                        } else if (item == 1 && subItem.type == "Business") {

                            //if subItem.type == "Business" {
                                HStack {
                                    Text(subItem.name)
                                        .font(.headline)
                                    Spacer()
                                    amount(subItem.amount)
                                }
                                .accessibilityElement() //challenge p15
                                .accessibilityHint("Business")
                                .accessibilityLabel("\(subItem.name) \(subItem.amount)")
                            //}

                        }
                      }//foreacj=
                        .onDelete(perform: removeItems)
                        
                    } header: {
                        Text(item == 0 ? "Personal" : "Business")
                        //Text(item)
                    }
                }
  
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button {
                  showingAddExpense = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: expenses)
            }
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
    
    //challenge
    func amount(_ value: Double) -> Text {
        
        if value < 10.0 {
            return Text(value, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                        .foregroundColor(.white)
        } else if value < 100.0 {
            return Text(value, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                        .foregroundColor(.blue)
        } else {
            return Text(value, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                        .foregroundColor(.orange)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}


/*
 
             List {
                 //, id: \.id) - as using Identifiable protocol
                 ForEach(expenses.items) { item in
                     HStack {
                         VStack(alignment: .leading) {
                             Text(item.name)
                                 .font(.headline)
                             Text(item.type)
                         }
 
                         Spacer()
 
                         Text(item.amount, format: .currency(code: Locale.current.currencyCode ?? "USD")) //challenge
                             .foregroundColor( item.amount > 10 ? .white : .blue)
                             .foregroundColor( item.amount > 100 ? .orange : .green)
                     }//
 
                 }
                 .onDelete(perform: removeItems)
             }
 
 */





/*
 List(0..<1) { _ in
     Section {
         ForEach(expenses.items) { item in
             if item.type == "Personal" {
                HStack {
                    Text(item.name)
                        .font(.headline)
                    Spacer()
                    amount(item.amount)
                }
                //.accessibilityElement()
             }
         }
         .onDelete(perform: removeItems)
     } header: {
         Text("Personal")
     }
    
     
     Section {
         ForEach(expenses.items) { item in
             if item.type == "Business" {
                 HStack {
                     Text(item.name)
                         .font(.headline)
                     Spacer()
                    amount(item.amount)
                 }
//                            .accessibilityElement()
//                            .accessibilityLabel("Expense")
//                            .accessibilityValue("\(item.name) \(item.amount)")
             }
         }
         .onDelete(perform: removeItems)
     } header: {
         Text("Business")
     }
 }
 */


/*
 /*
 Section {
     ForEach(expenses.items) { item in
             HStack {
                 if item.type == "Personal" {
                 Text(item.name)
                     .font(.headline)
                 Spacer()
                 amount(item.amount)
                 }
             }
             .accessibilityElement()
             .accessibilityLabel("Personal")
             .accessibilityValue("\(item.name) \(item.amount)")
     }
 } header: {
     Text("Personal")
 }
 
 Section {
     ForEach(expenses.items) { item in
             HStack {
                 if item.type == "Business" {
                 Text(item.name)
                     .font(.headline)
                 Spacer()
                 amount(item.amount)
                 }
             }
             .accessibilityElement()
             .accessibilityLabel("Business")
             .accessibilityValue("\(item.name) \(item.amount)")
     }
 } header: {
     Text("Business")
 }
*/
 */
