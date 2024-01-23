//
//  ContentView.swift
//  Moonshot
//
//  Created by Ramanan on 17/11/22.
//

import SwiftUI

struct ContentView: View {
    let astronauts: [String:Astronaut] = Bundle.main.decode("astronauts.json")
    let mission: [Mission] = Bundle.main.decode("missions.json")
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    @State private var showingGrid = false  //challenge
    
    var body: some View {
        NavigationView {
            Group { //challenge
                if showingGrid {
                    List(mission) { mission in
                        NavigationLink {
                            MissionView(mission: mission, astronauts: astronauts)
                        } label: {
                            HStack {
                                Image(mission.image)
                                    .resizable()
                                    .scaledToFit()
                                .frame(width: 50, height: 50)

                                VStack(alignment: .leading) {
                                    Text(mission.displayName)
                                        .font(.headline)
                                        .foregroundColor(.white)

                                    Text(mission.formattedLaunchDate)
                                        .font(.caption.weight(.medium))
                                        .foregroundColor(.white.opacity(0.5))
                                }
                            }
                            .accessibilityElement() //Challenge P15
                            .accessibilityLabel("Mission Detail")
                            .accessibilityValue("Image of \(mission.image) Mission Title \(mission.displayName) LaunchDate \(mission.formattedLaunchDate)")
                        }
                    }
                } else {
                    ScrollView {
                        LazyVGrid(columns: columns) {
                            ForEach(mission) { mission in
                                NavigationLink {
                                    MissionView(mission: mission, astronauts: astronauts)
                                } label: {
                                    VStack {
                                        Image(mission.image)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 100, height: 100)
                                            .padding()
                                        VStack {
                                            Text(mission.displayName)
                                                .font(.headline)
                                                .foregroundColor(.white)

                                            Text(mission.formattedLaunchDate)
                                                .font(.caption)
                                                .foregroundColor(.white.opacity(0.5))
                                        }
                                        .padding(.vertical)
                                        .frame(maxWidth:.infinity)
                                        .background(.lightBackground)
                                    }
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(.lightBackground)
                                    )
                                    .accessibilityElement() //Challenge P15
                                    .accessibilityLabel("Mission Detail")
                                    .accessibilityValue("Image of \(mission.image) Mission Title \(mission.displayName) LaunchDate \(mission.formattedLaunchDate)")
                                }
                            }
                        }
                        .padding([.horizontal, .bottom])
                    }
                }
            }
            .navigationTitle("Moonshot")
            .accessibilityLabel("Moonshot") //Challenge P15
            .listStyle(.plain)
            .listRowBackground(Color.darkBackground)
            .background(.darkBackground)
            .preferredColorScheme(.dark)
            .toolbar {
                Button{
                    withAnimation {
                        showingGrid.toggle()
                    }
                } label: {
                    showingGrid == false ? Image(systemName: "list.dash") :  Image(systemName: "grid")
                }
                .accessibilityLabel("Change View") //Challenge P15
                .accessibilityHint("Swicth between list and grid view")
            }
            
        
        }//
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
            
    }
}





/*
 
 
 //old code
 
 /*
 ScrollView {
     LazyVGrid(columns: columns) {
         ForEach(mission) { mission in
             NavigationLink {
                 MissionView(mission: mission, astronauts: astronauts)
             } label: {
                 VStack {
                     Image(mission.image)
                         .resizable()
                         .scaledToFit()
                         .frame(width: 100, height: 100)
                         .padding()
                     VStack {
                         Text(mission.displayName)
                             .font(.headline)
                             .foregroundColor(.white)
                         
                         Text(mission.formattedLaunchDate)
                             .font(.caption)
                             .foregroundColor(.white.opacity(0.5))
                     }
                     .padding(.vertical)
                     .frame(maxWidth:.infinity)
                     .background(.lightBackground)
                 }
                 .clipShape(RoundedRectangle(cornerRadius: 10))
                 .overlay(
                     RoundedRectangle(cornerRadius: 10)
                         .stroke(.lightBackground)
                 )
             }
         }
     }
     .padding([.horizontal, .bottom])
 }
 */
 
 
 
 /*
 List(mission) { mission in
     NavigationLink {
         MissionView(mission: mission, astronauts: astronauts)
     } label: {
         HStack {
             Image(mission.image)
                 .resizable()
                 .scaledToFit()
             .frame(width: 50, height: 50)
             
             VStack(alignment: .leading) {
                 Text(mission.displayName)
                     .font(.headline)
                     .foregroundColor(.white)
                 
                 Text(mission.formattedLaunchDate)
                     .font(.caption)
                     .foregroundColor(.white.opacity(0.5))
             }
         }
     }//
 }
 .listStyle(.plain)
 .listRowBackground(Color.darkBackground)
 */
 
 
 */
