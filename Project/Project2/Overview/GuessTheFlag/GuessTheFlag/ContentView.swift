//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Ramanan on 12/10/22.
//

import SwiftUI

struct ContentView: View {
    @State private var showingAlert = false
    var body: some View {
        
        //#1 stack
//        VStack {
//            HStack {
//                Text("1")
//                Text("2")
//                Text("3")
//            }
//            HStack {
//                Text("4")
//                Text("5")
//                Text("6")
//            }
//            HStack {
//                Text("7")
//                Text("8")
//                Text("9")
//            }
//        }
        
        //#2 colors and frames ******** ******** ********
        
//        ZStack {
//            //Color.blue
//            //Color.secondary
//            //Color(red: 1, green: 0.8, blue: 0)
//            Color.green
//                .frame(minWidth: 200, maxWidth: .infinity, maxHeight: 200)
//            Text("Your Content")
//        }
        
//        ZStack {
//            Color.red
//            Text("Your Content")
//        }
//        .ignoresSafeArea()
        
//        ZStack {
//            VStack(spacing: 0) {
//                Color.red
//                Color.blue
//            }
//
//            Text("Your Content")
//                .foregroundColor(.secondary)
//                .padding(50)
//                .background(.ultraThinMaterial)
//        }
//        .ignoresSafeArea()
        
        //#3 gradient ******** ******** ********
        
        //LinearGradient(gradient: Gradient(colors: [.white,.black]), startPoint: .top, endPoint: .bottom)
        
//        LinearGradient(gradient: Gradient(stops: [
//            Gradient.Stop(color: .white, location: 0.45),
//            .init(color: .black, location: 0.55) //alternate
//        ]), startPoint: .top, endPoint: .bottom)
        
        
        //RadialGradient(colors: [.blue,.black], center: .center, startRadius: 20, endRadius: 200)
        //AngularGradient(colors: [.red, .yellow, .green, .blue, .purple, .red], center: .center)
        
        //#4 Button/Image ******** ******** ********
        
       // Button("Delete Selection", role: .destructive, action: executeDelete)
        
//        VStack {
//            Button("Button1") {}
//                .buttonStyle(.bordered)
//            Button("Button2", role: .destructive) {}
//                .buttonStyle(.bordered)
//            Button("Button3") {}
//                .buttonStyle(.borderedProminent)
//                .tint(.mint)
//            Button("Button4", role: .destructive) {}
//                .buttonStyle(.borderedProminent)
//        }
        
        
//        Button {
//            print("Button was tapped!")
//        } label: {
//            Text("Tap me!")
//                .padding()
//                .foregroundColor(.white)
//                .background(.red)
//        }
        
       // Image(systemName: "pencil")
        
        /*
        Button {
            print("Edit Button was tapped!")
        } label: {
            //Image(systemName: "pencil")
            Label("Edit", systemImage: "pencil")
        }
        //.renderingMode(.original)
        */
        
        //#4 Alert ******** ******** ********
        Button ("Show Alert") {
            showingAlert = true
        }
        .alert("Important Message", isPresented: $showingAlert) {
            //Button("OK") { }
            Button("Delete", role: .destructive) { }
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("Please read this")
        }
        
        
    }
    
    func executeDelete() {
        print("delete")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
