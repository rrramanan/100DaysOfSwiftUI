//
//  CrewMembersView.swift
//  Moonshot
//
//  Created by Ramanan on 01/12/22.
//

import SwiftUI

struct CrewMembersView: View {
    let crew: [CrewMembers]
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Rectangle()
                    .frame(height:2)
                    .foregroundColor(.lightBackground)
                .padding(.vertical)
                
                Text("Crew")
                    .font(.title.bold())
                    .padding(.top, 5)
            }
            .padding(.horizontal)
            .accessibilityElement() //Challenge P15
            .accessibilityLabel("Crew")
        
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(crew, id: \.role) { crewMember in
                        NavigationLink {
                            AstronautView(astronaut: crewMember.astronaut)
                        } label: {
                            HStack {
                                Image(crewMember.astronaut.id)
                                    .resizable()
                                    .frame(width: 104, height: 72)
                                    .clipShape(Capsule())
                                    .overlay(
                                        Capsule()
                                            .strokeBorder(.white, lineWidth: 1)
                                    )
                                
                                VStack(alignment: .leading) {
                                    Text(crewMember.astronaut.name)
                                        .foregroundColor(.white)
                                        .font(.headline)
                                    
                                    Text(crewMember.role)
                                        .foregroundColor(.secondary)
                                }
                            }
                            .padding(.horizontal)
                            .accessibilityElement() //Challenge P15
                            .accessibilityHint("List of Crew members and their role")
                            .accessibilityValue("\(crewMember.astronaut.name) Role\(crewMember.role)")
                        }
                    }
                }
            }//
        }//
    }
}

struct CrewMembersView_Previews: PreviewProvider {
    static let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    static let crew  = CrewMembers(role: "Command Pilot", astronaut: astronauts["armstrong"]!)
    
    static var previews: some View {
        CrewMembersView(crew: [crew])
            .preferredColorScheme(.dark)
    }
}
