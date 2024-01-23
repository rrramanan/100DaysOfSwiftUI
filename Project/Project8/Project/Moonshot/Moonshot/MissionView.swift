//
//  MissionView.swift
//  Moonshot
//
//  Created by Ramanan on 18/11/22.
//

import SwiftUI

struct MissionView: View {
//    struct CrewMember {
//        let role: String
//        let astronaut: Astronaut
//    }
    
    let mission: Mission
    //let crew: [CrewMember]

    let fullCrew: [CrewMembers] //challenge
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack {
                    VStack {
                        Image(mission.image)
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: geometry.size.width * 0.6)
                            .padding(.top)
                        
                        Text("\(mission.briefLaunchDate)") //challenge
                    }//for accessibility
                    .accessibilityElement() //Challenge P15
                    .accessibilityLabel("Mission Image and Date")
                    .accessibilityValue("Image of \(mission.image) Launch Date \(mission.briefLaunchDate)")
                    
                    VStack(alignment: .leading) {
                        Rectangle()
                            .frame(height:2)
                            .foregroundColor(.lightBackground)
                            .padding(.vertical)
                        
                        Text("Mission Highlight")
                            .font(.title.bold())
                            .padding(.top, 5)
                        
                        Text(mission.description)
                        
                        //replaced 
//                        Rectangle()
//                            .frame(height:2)
//                            .foregroundColor(.lightBackground)
//                            .padding(.vertical)
//
//                        Text("Crew")
//                            .font(.title.bold())
//                            .padding(.top, 5)
                    }
                    .padding(.horizontal)
                    .accessibilityElement() //Challenge P15
                    .accessibilityLabel("Mission Highlight")
                    .accessibilityValue("\(mission.description)")
                    
               CrewMembersView(crew: fullCrew) //challenge
                    
                    //replaced
                /*
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
                                }
                            }
                        }
                    }//
                    
                */
                    
                }
                .padding(.bottom)
            }
        }//
        .navigationTitle(mission.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBackground)
    }
    
//    init(mission: Mission, astronauts: [String: Astronaut]) {
//        self.mission = mission
//
//        self.crew = mission.crew.map { member in
//            if let astronaut = astronauts[member.name] {
//                return CrewMember(role: member.role, astronaut: astronaut)
//            } else {
//                fatalError("Missions \(member.name)")
//            }
//        }
//    }
    
    //modified ....
    init(mission: Mission, astronauts: [String: Astronaut]) {
        self.mission = mission
        
        self.fullCrew = mission.crew.map { member in
            if let astronaut = astronauts[member.name] {
                return CrewMembers(role: member.role, astronaut: astronaut)
            } else {
                fatalError("Missions \(member.name)")
            }
        }
    }
    
}

struct MissionView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
         MissionView(mission: missions[0], astronauts: astronauts)
        //MissionView(mission: missions[0])
            .preferredColorScheme(.dark)
    }
}
