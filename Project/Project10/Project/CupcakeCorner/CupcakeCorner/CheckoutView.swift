//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Ramanan on 07/12/22.
//

import SwiftUI

struct CheckoutView: View {
    //@ObservedObject var order: Order
    @ObservedObject var orderClass: OrderClass //challenge
   
    
    @State private var confirmationMessage = ""
    @State private var showingConfiramtion = false
    
    @State private var errorMessage = "" //challenge
    @State private var showingErrorAlert = false //challenge
    
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 233)
                .accessibilityHidden(true)//P15 Challenge 1
                
                
                Text("Your total is \(orderClass.order.cost, format: .currency(code: "USD"))")
                    .font(.title)
                
                Button("Place Order") {
                    Task {
                       await placeOrder()
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Check out")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Thank you!", isPresented: $showingConfiramtion) {
            Button("OK") { }
        } message: {
            Text(confirmationMessage)
        }
        .alert("Error", isPresented: $showingErrorAlert) {
            Button("OK") { }
        } message: {
            Text(errorMessage)
        } //challenge
    }
    
    func placeOrder() async {
        guard let encoded = try? JSONEncoder().encode(orderClass.order) else {
            print("Failed to encode order")
            return
        }
        
        let url = URL(string: "https://reqres.in/api/dcupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            let decodedOrder = try JSONDecoder().decode(OrderModel.self, from: data)
            confirmationMessage = "Your order for \(decodedOrder.quantity)x \(Order.types[decodedOrder.type].lowercased()) cupcakes is on its way!"
            showingConfiramtion = true
        } catch {
            //print("Checkout failed.")
            //challenge
            errorMessage = "Checkout failed"
            showingErrorAlert = true
        }
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CheckoutView(orderClass: OrderClass())
                .preferredColorScheme(.dark)
        }
    }
}
