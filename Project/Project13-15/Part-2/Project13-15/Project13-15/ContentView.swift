//
//  ContentView.swift
//  Project13-15
//
//  Created by Ramanan on 23/01/23.
//

import SwiftUI

struct ContentView: View {
    @State private var showSheet = false
    @StateObject var user = UserClass()
    //@State var loadUser = userCollect()
    
    var body: some View {
        NavigationView {
            VStack {
                List(user.userData.sorted()) { userdata in
                    HStack {
                        NavigationLink {
                            DetailView(user: UIImage(data: userdata.image) ?? UIImage(), userMapData: userdata.userMap)
                           
                        } label: {
                            Image(uiImage: UIImage(data: userdata.image) ?? UIImage())
                                .resizable()
                                .scaledToFill()
                                .frame(width: 50, height: 50)
                                .clipShape(Circle())

                            Text(userdata.name)
                                .font(.headline)
                            Spacer()
                        }
                    }
                }
            }
            .navigationTitle("Project13-15")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showSheet.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showSheet) {
                 AddView(name: "", saveUser: user)
                //AddView(name: "", user: loadUser)
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(user: UserClass())
        //ContentView()
            .preferredColorScheme(.dark)
    }
}
