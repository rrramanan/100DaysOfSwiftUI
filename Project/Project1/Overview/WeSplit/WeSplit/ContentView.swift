//
//  ContentView.swift
//  WeSplit
//
//  Created by Ramanan on 11/10/22.
//

import SwiftUI

struct ContentView: View {
    @State private var tapCount = 0
    @State private var name = ""
    
    let students = ["Harry","Hermione","Ron"]
    @State private var selectedStudent = "Harry"
    
    var body: some View {
        //#1
//        Form {
//            Section {
//                Text("Hello, world!")
//            }
//
//            Section {
//                Text("Hello, world!")
//                Text("Hello, world!")
//            }
//        }
        
        //#2
//        NavigationView {
//            Form {
//                Section {
//                    Text("Hello, world!")
//                }
//
//            }
//            .navigationTitle("SwiftUI")
//            .navigationBarTitleDisplayMode(.inline)
//        }
        
        //#3
//        Button("Tap Count: \(tapCount)") {
//            tapCount += 1
//        }
        
        //#4
//        Form {
//            TextField("Enter your name ", text:$name)
//            Text("Your name is \(name)")
//        }
        
        //#5
//        Form {
//            ForEach(0..<100) {
//                Text("Row \($0)")
//            }
//        }
        
        NavigationView {
            Form {
                Picker("Select your student", selection: $selectedStudent) {
                    ForEach(students, id: \.self) {
                      Text($0)
                    }
                }
            }
        }//
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
            
    }
}
