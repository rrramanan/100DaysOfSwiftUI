//
//  UserView.swift
//  Project10-12
//
//  Created by Ramanan on 20/12/22.
//

import SwiftUI

struct UserView: View {
    let user: [User]
    let userName: String
    let user_filtered: [User]
    
    var body: some View {
        VStack {
            ForEach(user_filtered) { user in
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
                }//
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
    
    init(userName: String, user: [User]) {
        self.userName = userName
        self.user = user
        self.user_filtered = user.filter({ data in
            return data.name.contains(userName)
        })
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView(userName: "", user: [User]())
            .preferredColorScheme(.dark)
    }
}
