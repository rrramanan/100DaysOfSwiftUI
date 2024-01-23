//
//  DetailView.swift
//  Project10-12
//
//  Created by Ramanan on 20/12/22.
//

import SwiftUI

struct DetailView: View {
    @ObservedObject var user: UserClass
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
            
            TagView(userTag: userDetails.tags)
            
            FriendsView(friends: friends, user: user)
        }
        .navigationBarTitleDisplayMode(.inline)
        
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        let user = User(id: "", name: "", age: 1, isActive: false, company: "", email: "", about: "", registered: Date.now, friends: [Friends](), tags: [String]())
        DetailView(user: UserClass(), friends: [Friends](), userDetails: user)
            .preferredColorScheme(.dark)
    }
}

