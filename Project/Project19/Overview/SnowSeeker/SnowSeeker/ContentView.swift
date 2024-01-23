//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Ramanan on 22/02/23.
//

import SwiftUI

struct UserView: View {
    var body: some View {
        Group {
            Text("Name: Paul")
            Text("Country: England")
            Text("Pets: Luna and Arya")
        }
        .font(.title)
    }
}


struct User: Identifiable {
    var id = "Taylor Swift"
}

struct ContentView: View {
    @State private var selectedUser: User? = nil
    @State private var isShowingUser = false
    
    @State private var layoutVertically = false
    
    @Environment(\.horizontalSizeClass) var sizeClass
    
    @State private var searchText = ""
    let allNames = ["Subh", "Vina", "Melvin", "Stefanie"]
    
    var body: some View {
        
        
        // #1 : Working with two side by side views in SwiftUI
        NavigationView {
            
            NavigationLink {
                Text("New Secondary")
            } label: {
                Text("Hello, world!")
            }
            
            //Text("Hello, world!")
            .navigationTitle("Primary")
            
            Text("Secondary")
            
            Text("Tertiary")
        }
        
        
        
        /*
        // #2 : Using alert() and sheet() with optionals
        
        Text("Hello, world!")
            .onTapGesture {
                selectedUser = User()
                isShowingUser = true
            }
            /*
             .sheet(item: $selectedUser) { user in
             Text(user.id)
             //Text(selectedUser!.id)
             }
             */
            
            /*
            .alert("Welcome", isPresented: $isShowingUser, presenting: selectedUser) { user in
                Button(user.id) { }
            }
            */
            .alert("Welcome", isPresented: $isShowingUser) { }
        
        */
        
        // #3: Using groups as transparent layout containers
        
        /*
        Group {
            if layoutVertically {
                VStack {
                    UserView()
                }
            } else {
                HStack {
                    UserView()
                }
            }
        }
        .onTapGesture {
            layoutVertically.toggle()
        }
        */
        
      /*
        if sizeClass == .compact {
            VStack(content: UserView.init)
            /*
            VStack {
                UserView()
            }
            */
        } else {
            HStack(content: UserView.init)
            /*
            HStack {
                UserView()
            }
            */
        }
        
        */
        
        // #4 - Making a SwiftUI view searchable
        /*
        NavigationView {
            //Text("Searching for \(searchText)")
            List(filteredNames, id: \.self) { name in
                Text(name)
            }
            .searchable(text: $searchText, prompt: "Look for something")
            .navigationTitle("Searching")
        }

        */
        
    }
    
    var filteredNames: [String] {
        if searchText.isEmpty {
            return allNames
        } else {
            //return allNames.filter { $0.contains(searchText) }
            return allNames.filter { $0.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
