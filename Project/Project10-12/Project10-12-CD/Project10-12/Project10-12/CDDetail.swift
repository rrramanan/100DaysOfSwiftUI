//
//  CDDetail.swift
//  Project10-12
//
//  Created by Ramanan on 24/12/22.
//

import SwiftUI

struct CDDetail: View {
    @ObservedObject var user: UserClass
    let friends: [LocalFriend]
    let userDetails: LocalUser
    
    var body: some View {
        VStack{
            Group {
                Text("About \(userDetails.name ?? "sk")")
                    .foregroundColor(.pink)
                .font(.title2.bold())
                
                Form {
                    Section {
                        Text("\(userDetails.registered ?? Date.now)")
                    } header: {
                        Text("Registred Date")
                    }
                    
                    Section {
                        Text("\(userDetails.age)")
                    } header: {
                        Text("Age")
                    }
                    
                    Section {
                        Text(userDetails.company ?? "un")
                    } header: {
                        Text("Company")
                    }
                    
                    Section {
                        Text(userDetails.email ?? "ss")
                    } header: {
                        Text("Email")
                    }
                    
                    Section {
                        Text(userDetails.about ?? "sd")
                    } header: {
                        Text("About \(userDetails.name ?? "sk")")
                    }
                }
            }
            
            
            Group {
                Text("Friends (\(friends.count))")
                    .foregroundColor(.purple)
                .font(.headline.bold())
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(friends) { friend in
                            NavigationLink {
                                //UserView(user: user, userName: friend.name)
                            } label: {
                                Text(friend.name ?? "HJ")
                                    .padding(7)
                                    .foregroundColor(.white)
                                    .background(.orange)
                                    .clipShape(RoundedRectangle(cornerRadius: 15))
                            }
                        }
                    }
                }
            }
            
            
        }
        
    }
}

//struct CDDetail_Previews: PreviewProvider {
//    static var previews: some View {
//        CDDetail(user: UserClass(), friends: [LocalFriend](), userDetails: LocalUser())
//    }
//}
