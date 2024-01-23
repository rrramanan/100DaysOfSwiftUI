//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Ramanan on 06/12/22.
//

import SwiftUI

// #1 -- Adding Codable conformance for @Published properties
class User: ObservableObject, Codable {
    enum CodingKeys: CodingKey {
        case name
    }
    
    @Published var name = "Paul Hudson"
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
    }
}


// #2 -- Sending and receiving Codable data with URLSession and SwiftUI
struct Response: Codable {
    var results: [Result]
}

struct Result: Codable {
    var trackId: Int
    var trackName: String
    var collectionName: String
}


struct ContentView: View {
    @State private var results = [Result]()
    @State private var username = ""
    @State private var email = ""
    
    
    var body: some View {
    
        /*
        // #2 ---------
         
        List(results, id: \.trackId) { item in
            VStack(alignment: .leading) {
                Text(item.trackName)
                    .font(.headline)
                Text(item.collectionName)
            }
        }
        .task {
           await loadData()
        }
        */
        
        
        
    
        // #3 ------- Loading an image from a remote server
        
        //AsyncImage(url: URL(string: "https://hws.dev/img/logo.png"))
        //AsyncImage(url: URL(string: "https://hws.dev/img/logo.png"), scale: 3)
        
        /*
        AsyncImage(url: URL(string: "https://hws.dev/img/logo.png"), scale: 3)
            //.resizable()
            .frame(width: 200, height: 200)
        */
        
        
        /*
        AsyncImage(url: URL(string: "https://hws.dev/img/logo.png")) { image in
            image
                .resizable()
                .scaledToFit()
        } placeholder: {
            //Color.red
            ProgressView()
        }
        .frame(width: 200, height: 200)
        */
        
        /*
        AsyncImage(url: URL(string: "https://hws.dev/img/bad.png")) { phase in
            if let image = phase.image {
                image
                    .resizable()
                    .scaledToFit()
            } else if phase.error != nil {
                Text("There was a error loading the image.")
            } else {
                ProgressView()
            }
        }
        .frame(width: 200, height: 200)
         */
        
        
        
        
        // #4 ----- Validating and disabling forms
         
        Form {
            Section {
                TextField("Username", text: $username)
                TextField("Email", text: $email)
            }
            
            Section {
                Button("Create Account") {
                    print("Creating Account...")
                }
                //.disabled(username.isEmpty || email.isEmpty)
                .disabled(disableForm)
            }
        }
         
        
    }//
    
    // #4
    var disableForm: Bool {
        username.count < 5 || email.count < 5
    }
    
    
    // #2
    func loadData() async {
        guard let url = URL(string: "https://itunes.apple.com/search?term=taylor+swift&entity=song") else {
            print("Invalid URL")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let decodeResponse = try? JSONDecoder().decode(Response.self, from: data) {
                results = decodeResponse.results
            } 
        } catch {
            print("Invalid Data")
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
