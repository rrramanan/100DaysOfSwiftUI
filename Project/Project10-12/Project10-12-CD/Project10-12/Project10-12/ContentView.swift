//
//  ContentView.swift
//  Project10-12
//
//  Created by Ramanan on 20/12/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @StateObject var user = UserClass()
    //@ObservedObject var user: UserClass
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity:LocalUser.entity() ,sortDescriptors: [
        //NSSortDescriptor(key: \.LocalUser.id, ascending: true)
    ]) var fetchedUserData: FetchedResults<LocalUser>
    @FetchRequest(entity:LocalFriend.entity() ,sortDescriptors: [
    ]) var fetchedFriendsData: FetchedResults<LocalFriend>
    
    var body: some View {
        NavigationView {
            List(fetchedUserData, id: \.id) { user in
                NavigationLink {
                    CDDetail(user: self.user, friends: user.friendArray, userDetails: user)
                   // DetailView(user: self.user, friends: user.friends, userDetails: user)
                } label: {
                    HStack {
                        Text(user.isActive ? "🟢" : "🔴")
                            .font(.system(size: 9))
                            .opacity(0.8)
                        Text(user.name ?? "Unknown")
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
            
            /*
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
            
            */
        }
    }
    
    func loadData() async {
        //deleteData()
        
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
               
                deleteData()
                
                for data in decodeData {
                    let localUser = LocalUser(context: moc)
                    localUser.name       = data.name
                    localUser.id         = data.id
                    localUser.isActive   = data.isActive
                    localUser.age        = Int16(data.age)
                    localUser.company    = data.company
                    localUser.email      = data.email
                    localUser.address    = data.address
                    localUser.about      = data.about
                    localUser.registered = data.registered
                   
                    
                    for bud in data.friends {
                        if data.id == "63caacb0-7312-41ca-ad9b-33cb93e6c85d" {
                            print("\(bud)")
                        }
                        
                        for dat in localUser.friendArray {
                            if data.id == "63caacb0-7312-41ca-ad9b-33cb93e6c85d" {
                                print("------ \(dat)")
                            }
                            //let  = LocalFriend(context: moc)
                            dat.id = bud.id
                            dat.name = bud.name
                        }
                    }
                    
                
                    
                }
            
                print("fetchedUserData 1 --- ",fetchedUserData.count)
                print("fetchedUserData 2 --- ",fetchedFriendsData.count)
                if moc.hasChanges {
                    try? moc.save()
                }
                print("fetchedUserData 1 --- ",fetchedUserData.count)
                print("fetchedUserData 2 --- ",fetchedFriendsData.count)
                for (ind,val) in fetchedUserData.enumerated() {
                    if val.id == "63caacb0-7312-41ca-ad9b-33cb93e6c85d" {
                        print(val.name ?? "kim")
                        print(val.friendArray.count )
                    }
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
    
    func deleteData() {
        for (ind,_) in fetchedUserData.enumerated() {
            let data = fetchedUserData[ind]
            moc.delete(data)
        }
        for (ind,_) in fetchedFriendsData.enumerated() {
            let data = fetchedFriendsData[ind]
            moc.delete(data)
        }
        try? moc.save()
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
