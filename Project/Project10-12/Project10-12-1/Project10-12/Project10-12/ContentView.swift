//
//  ContentView.swift
//  Project10-12
//
//  Created by Ramanan on 20/12/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var user = UserClass()
    
    var body: some View {
        NavigationView {
            List(user.allUsers) { user in
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
                if user.allUsers.isEmpty {
                    await loadData()
                }
            }
            .navigationTitle("Project10-12")
        }
    }
    
    func loadData() async {
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            print("URL Error")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            if let decodeData = try? decoder.decode([User].self, from: data) {
                await MainActor.run {
                    user.allUsers =  decodeData
                }
            /*
            when using -> user.allUsers =  decodeData
            "Publishing changes from background threads is not allowed; make sure to publish values from the main thread (via operators like receive(on:)) on model updates."
            */
            } else {
                print("data issue")
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
