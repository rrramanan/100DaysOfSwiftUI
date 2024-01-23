//
//  DetailView.swift
//  Project10-12
//
//  Created by Ramanan on 20/12/22.
//

import SwiftUI

struct DetailView: View {
    let user: [User]
    let friends: [Friends]
    let userDetails: User
    
    var body: some View {
        VStack {
            Group {
                Text("About \(userDetails.name)")
                    .foregroundColor(.blue)
                .font(.title2.bold())
                
                Form {
                    Section {
                        Text("\(userDetails.formattedDate)")
                    } header: {
                        Text("Registred Date")
                    }
                    
                    Section {
                        Text("\(userDetails.age)")
                    } header: {
                        Text("Age")
                    }
                    
                    Section {
                        Text(userDetails.company)
                    } header: {
                        Text("Company")
                    }
                    
                    Section {
                        Text(userDetails.email)
                    } header: {
                        Text("Email")
                    }
                    
                    Section {
                        Text(userDetails.about)
                    } header: {
                        Text("About \(userDetails.name)")
                    }
                }
            }//
            
            Group {
                Text("Friends (\(friends.count))")
                    .foregroundColor(.brown)
                .font(.headline.bold())
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(friends) { friend in
                            NavigationLink {
                                UserView(userName: friend.name, user: self.user)
                            } label: {
                                Text(friend.name)
                                    .padding(7)
                                    .foregroundColor(.white)
                                    .background(.blue.opacity(0.6))
                                    .clipShape(RoundedRectangle(cornerRadius: 15))
                            }
                        }
                    }
                }
            }//
            
            TagView(userTags: userDetails.tags)
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        let user = User(id: "", name: "", age: 1, isActive: false, company: "", email: "", about: "", registered: Date.now, tags: [String](), friends: [Friends]())
        DetailView(user: [User](), friends: [Friends](), userDetails: user)
            .preferredColorScheme(.dark)
    }
}
