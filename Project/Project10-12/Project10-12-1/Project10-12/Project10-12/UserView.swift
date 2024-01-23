//
//  UserView.swift
//  Project10-12
//
//  Created by Ramanan on 20/12/22.
//

import SwiftUI

struct UserView: View {
    @ObservedObject var user: UserClass
    let userName: String
    let user_Filtered: [User]
    
    var body: some View {
        VStack {
            ForEach(user_Filtered) { user in
                Group {
                    Text("About \(user.name)")
                        .foregroundColor(.blue)
                        .font(.title2.bold())
                    
                    Form {
                        Section {
                            Text("\(user.formattedDate)")
                        } header: {
                            Text("Registred Date")
                        }
                        
                        Section {
                            Text("\(user.age)")
                        } header: {
                            Text("Age")
                        }
                        
                        Section {
                            Text(user.company)
                        } header: {
                            Text("Company")
                        }
                        
                        Section {
                            Text(user.email)
                        } header: {
                            Text("Email")
                        }
                        
                        Section {
                            Text(user.about)
                        } header: {
                            Text("About \(user.name)")
                        }
                    }
                }
            }
        }
    }
    
    init(user: UserClass, userName: String) {
        self.userName = userName
        self.user = user
        self.user_Filtered = user.allUsers.filter { user in
           user.name.contains(userName)
        }
    }
}


struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView(user: UserClass(), userName: "")
            .preferredColorScheme(.dark)
    }
}

