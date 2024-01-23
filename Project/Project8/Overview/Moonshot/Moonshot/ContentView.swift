//
//  ContentView.swift
//  Moonshot
//
//  Created by Ramanan on 16/11/22.
//

import SwiftUI

struct User: Codable {
    let name: String
    let address: Address
}

struct Address: Codable {
    let street: String
    let city: String
}

struct CustomText: View {
    let text: String
    
    var body: some View {
        Text(text)
    }
    
    init(_ text: String) {
        print("Creating a new CustomText")
        self.text = text
    }
}


struct ContentView: View {
    
    let layout = [
        GridItem(.adaptive(minimum: 80, maximum: 120))
        //GridItem(.fixed(80)),
        //GridItem(.fixed(80)),
        //GridItem(.fixed(80))
    ]
    
    var body: some View {

        /*
        // #1 GeometryReader
        GeometryReader { geo in
            Image("Example")
                .resizable()
                .scaledToFit()
                .frame(width: geo.size.width * 0.8)
                .frame(width: geo.size.width, height: geo.size.height)
                //.frame(width: 300, height: 300)
                //.clipped()
        }
        */
        
        /*
        // #2 ScrollView
        ScrollView(.horizontal) {
            LazyHStack(spacing:10) {
                ForEach(0..<100) {
                    CustomText("Item \($0)").font(.title)
                }
            }
            .frame(maxWidth:.infinity)
        }
        */
        
        /*
        // #3 Pushing Views
        NavigationView {
            List(0..<100) { row in
                NavigationLink {
                    Text("Detail \(row)")
                } label: {
                    Text("Row \(row)")
                }
            }
            .navigationTitle("SwiftUI")
        }
        */
        
        
        /*
        // #4 hierarchical Codable data
        Button("Decode JSON") {
            let input = """
            {
                "name" : "Taylor Swift",
                "address" : {
                    "street" : "555, Taylor Swift Avenue",
                    "city" : "Nashville"
                }
            }
            """
         
            let data = Data(input.utf8)
            if let user = try? JSONDecoder().decode(User.self, from: data) {
                print(user.address.street)
            }
            
        }
        */
        
        // #5  How to lay out views in a scrolling grid
        ScrollView(.horizontal) {
            LazyHGrid(rows: layout) {
                ForEach(0..<1000) {
                    Text("Item \($0)")
                }
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
