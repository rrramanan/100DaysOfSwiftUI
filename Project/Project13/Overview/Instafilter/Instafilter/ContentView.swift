//
//  ContentView.swift
//  Instafilter
//
//  Created by Ramanan on 27/12/22.
//

import SwiftUI

struct ContentView: View {
    @State private var blurAmount = 0.0
    // 1 -- How property wrappers become structs
    {
        didSet{
            print("New Value is  \(blurAmount)")
        }
    }
    
    @State private var showingConfimation = false
    @State private var backgroundColor = Color.white
 
    var body: some View {
        // 1 -- How property wrappers become structs
        
        VStack {
            Text("Hello, world!")
                .blur(radius: blurAmount)
        
            Slider(value: $blurAmount, in: 0...20)
            
            Button("Random Blur") {
                blurAmount = Double.random(in: 0...20)
            }
            
        }
        // 2 ---- Responding to state changes using onChange()
//        .onChange(of: blurAmount) { newValue in
//            print("New Value is \(newValue)")
//        }
        
        
        
        /*
        Text("Hello World")
            .frame(width: 300, height: 300)
            .background(backgroundColor)
            .onTapGesture {
                showingConfimation = true
            }
            .confirmationDialog("Change backgroud", isPresented: $showingConfimation) {
                Button("Red") { backgroundColor = .red}
                Button("Green") { backgroundColor = .green}
                Button("Blue") { backgroundColor = .blue}
                Button("Cancel", role: .cancel) { }
            } message: {
                Text("Select a new color")
            }
        */
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
