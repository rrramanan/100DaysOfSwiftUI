//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Ramanan on 07/12/22.
//

import SwiftUI

struct AddressView: View {
    //@ObservedObject var order: Order
    @ObservedObject var orderClass: OrderClass //challenge
    
    //let struck: OrderModel
    //@State private var struck = OrderModel()
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $orderClass.order.name) // $struck.name
                TextField("Street address", text: $orderClass.order.streetAddress)
                TextField("City", text: $orderClass.order.city)
                TextField("Zip", text: $orderClass.order.zip)
            }
            
            Section {
                NavigationLink {
                    CheckoutView(orderClass: orderClass)
                } label: {
                    Text("Check out")
                }
            }
            .disabled(orderClass.order.hasValidAddress == false)
        }
        .navigationTitle("Delivery Details")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    
    
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AddressView(orderClass: OrderClass())
                .preferredColorScheme(.dark)
        }
    }
}
