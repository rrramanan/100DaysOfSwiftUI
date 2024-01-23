//
//  ContentView.swift
//  Project10-12
//
//  Created by Ramanan on 19/12/22.
//

import SwiftUI

struct ContentView: View {
    @State private var user = [User]()
    
    var body: some View {
        NavigationView {
            List(user) { user in
                NavigationLink {
                    DetailView(user: self.user, friends: user.friends, userDetails: user)
                } label: {
                    HStack {
                        Text(user.isActive ? "🟢" : "🔴")
                            .font(.system(size: 9))
                            .opacity(0.8)
                        Text(user.name)
                            .font(.headline)
                            .opacity(user.isActive ? 1 : 0.65)
                    }
                }
            }
            .task {
                if user.isEmpty {
                    await loadData()
                }
            }
            .navigationTitle("Project10-12")
        }
    }
    
    func loadData() async {
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            print("URL error")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            if let decodeData = try? decoder.decode([User].self, from: data) {
                user = decodeData
            } else {
                print("data issue")
            }
        } catch {
            print("Invalid data")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
