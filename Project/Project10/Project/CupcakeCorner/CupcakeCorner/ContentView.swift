//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Ramanan on 07/12/22.
//

import SwiftUI

struct ContentView: View {
    //@StateObject var order = Order()
    @StateObject var orderClass = OrderClass() //challenge
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Select your cake type", selection: $orderClass.order.type) {
                        ForEach(OrderModel.types.indices) {
                            Text(OrderModel.types[$0])
                        }
                    }
                   
                    Stepper("Number of cakes: \(orderClass.order.quantity)", value: $orderClass.order.quantity, in: 3...20)
                }
                
                Section {
                    Toggle("Any special requests", isOn: $orderClass.order.specialRequestEnabled.animation())
                    
                    if orderClass.order.specialRequestEnabled {
                        Toggle("Add extra frosting", isOn: $orderClass.order.extraForsting)
                        Toggle("Add extra sprinkles", isOn: $orderClass.order.addSprinkles)
                    }
                }
                
                Section {
                    NavigationLink {
                        AddressView(orderClass: orderClass)
                    } label: {
                        Text("Delivery Detail")
                    }
                }
            }
            .navigationTitle("CupCake Corner")
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
 
 NavigationView {
     Form {
         Section {
             Picker("Select your cake type", selection: $order.type) {
                 ForEach(Order.types.indices) {
                     Text(Order.types[$0])
                 }
             }
             
             Stepper("Number of cakes: \(order.quantity)", value: $order.quantity, in: 3...20)
         }
         
         Section {
             Toggle("Any special requests", isOn: $order.specialRequestEnabled.animation())
             
             if order.specialRequestEnabled {
                 Toggle("Add extra frosting", isOn: $order.extraForsting)
                 Toggle("Add extra sprinkles", isOn: $order.addSprinkles)
             }
         }
         
         Section {
             NavigationLink {
                 AddressView(order: order)
             } label: {
                 Text("Delivery Detail")
             }
         }
     }
     .navigationTitle("CupCake Corner")
 }
 
 
 */
