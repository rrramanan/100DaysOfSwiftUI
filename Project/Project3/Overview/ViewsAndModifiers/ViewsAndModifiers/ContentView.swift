//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Ramanan on 14/10/22.
//

import SwiftUI

struct ContentView: View {
    @State private var changeColor = false
    
    var body: some View {
//        VStack {
//            Button("Button Click") {
//                print(type(of: self.body))
//            }
//            .font(.title2.weight(.semibold))
//            Text("wed")
//            Text("Hello, world!")
//                .frame(maxWidth:.infinity, maxHeight: .infinity)
//                .background(.indigo)
//                .ignoresSafeArea()
//        }
        
        
        
//        Button("Button Click") {
//            print(type(of: self.body))
//            changeColor.toggle()
//        }
//        .font(.title.bold())
//        .foregroundColor(changeColor ? .white : .orange)
//        .background(.thinMaterial)
//        .frame(width: 200, height: 200)
//        .background(.blue)
//        .padding()
//        .background(.yellow)

        
        VStack {
            Text("Halo")
            Text("Halo")
            Text("Halo")
        }
        .font(.title)
        
        
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)

    }
}
