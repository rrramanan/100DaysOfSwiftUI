//
//  FriendsView.swift
//  Project10-12
//
//  Created by Ramanan on 21/12/22.
//

import SwiftUI

struct FriendsView: View {
    let friends: [Friends]
    let user: UserClass
    
    var body: some View {
        VStack {
            Group {
                Text("Friends (\(friends.count))")
                    .foregroundColor(.purple)
                .font(.headline.bold())
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(friends) { friend in
                            NavigationLink {
                                UserView(user: user, userName: friend.name)
                            } label: {
                                Text(friend.name)
                                    .padding(7)
                                    .foregroundColor(.white)
                                    .background(.blue)
                                    .clipShape(RoundedRectangle(cornerRadius: 15))
                            }
                        }
                    }
                }
            }
        }//
    }
}

struct FriendsView_Previews: PreviewProvider {
    static var previews: some View {
        FriendsView(friends: [Friends](), user: UserClass())
            .preferredColorScheme(.dark)
    }
}
