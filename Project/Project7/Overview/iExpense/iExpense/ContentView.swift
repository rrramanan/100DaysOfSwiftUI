//
//  ContentView.swift
//  iExpense
//
//  Created by Ramanan on 10/11/22.
//

import SwiftUI

struct Users: Codable {
    var firstName: String
    var lastName: String
}

struct SecondView: View {
    @Environment(\.dismiss) var dismiss
    let name: String
    
    var body: some View {
        //Text("Hello \(name)")
        Button("Dismiss") {
            dismiss()
        }
    }
}


//works when struct
class User: ObservableObject {
    @Published var firstName = "Bilbo"
    @Published var lastName = "Baggings"
}

struct ContentView: View {
    @StateObject private var user = User()
    @State private var showingSheet = false
    @State private var numbers = [Int]()
    @State private var currentNumber = 1
    //@State private var tapCount = UserDefaults.standard.integer(forKey: "Tap")
    @AppStorage("tapCount") private var tapCount = 0
    @State private var users = Users(firstName: "Taylor", lastName: "Swift")
    
    var body: some View {
        
        /*
        //#1-2 Why @State only works with structs
        VStack {
            Text("Your name is \(user.firstName) \(user.lastName)")
            
            TextField("First Name", text: $user.firstName)
            TextField("Last Name", text: $user.lastName)
        }
        */
        
        //#3 Why @State only works with structs
        /*
        Button("Show Sheet") {
            showingSheet.toggle()
        }
        .sheet(isPresented: $showingSheet) {
            SecondView(name: "Helooooo")
        }
        */
        
        
        //#4 onDelete()
        /*
        NavigationView {
            VStack {
                List {
                    ForEach(numbers, id: \.self) {
                        Text("Row \($0)")
                    }
                    .onDelete(perform: removeRows)
                }
                Button("Add Number") {
                    numbers.append(currentNumber)
                    currentNumber += 1
                }
                
            }
            .navigationTitle("onDelete()")
            .toolbar {
                EditButton()
            }
        }
        */
        
        /*
        //#5 userDefaults
        Button("Tap count: \(tapCount)") {
            tapCount += 1
            UserDefaults.standard.set(tapCount, forKey: "Tap")
        }
        */
        
        //#6 Codable
        
        Button("Save User") {
            let encoder = JSONEncoder()
            
            if let data = try? encoder.encode(users) {
                UserDefaults.standard.set(data, forKey: "UserData")
            }
        }
        
    }
    
    func removeRows(at offsets: IndexSet) {
        numbers.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
