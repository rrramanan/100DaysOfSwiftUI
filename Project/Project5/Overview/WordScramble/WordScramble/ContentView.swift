//
//  ContentView.swift
//  WordScramble
//
//  Created by Ramanan on 27/10/22.
//

import SwiftUI

struct ContentView: View {
    let people = ["Finn", "Leia", "luke", "Rey"]
    
    
    var body: some View {
        
        //#1 - static
//        List {
//            Text("Hello, world!")
//            Text("Hello, world!")
//            Text("Hello, world!")
//        }
        
        //#1 - dynamic
//        List {
//            ForEach(0..<5) {
//               Text("Dynamic Row \($0)")
//            }
//       }
        
        
        //#2 - dynamic
        
        List(0..<1) {
            Text("Dynamic Row \($0)")
           
            Section("Section 1") {
                Text("Static Row 1")
                Text("Static Row 2")
            }


            Section("Section 2") {
                ForEach(0..<5) {
                    Text("Dynamic Row \($0)")
                }
            }

            Section("Section 3") {
                Text("Static Row 3")
                Text("Static Row 4")
            }
       }
        .listStyle(.grouped)
        
        
        
        //#3 - dynamic
//        List(people, id: \.self) {
//            Text("\($0)")
//       }
//        .listStyle(.grouped)
        
        
        //#4 - dynamic
//        List {
//            Text("Static Row")
//
//            ForEach(people, id: \.self) {
//                Text($0)
//            }
//
//            Text("Static Row")
//       }
//        .listStyle(.grouped)
            
        //**************
        
    }
    
    //#5 - load resoruce from app bundle
    func loadFile() {
        if let fileURL = Bundle.main.url(forResource: "some-file", withExtension: "txt") {
            if let fileContent = try? String(contentsOf: fileURL) {
                //fileContent
            }
        }
    }
    
    //#6 - Strings
    func test() {
        //#1
        //let input = "a b c"
        //let letters = input.components(separatedBy: " ")
        
        //#2
        /*
        let input = """
a
b
c
"""
        let letters = input.components(separatedBy: "\n")
        let letter = letters.randomElement()
        
        let trimmed = letter?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        */
        
        //#3
        
        let word = "swift"
        let checker = UITextChecker()
        
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        let allGood = misspelledRange.location == NSNotFound
        
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
