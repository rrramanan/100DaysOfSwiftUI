//
//  Mission.swift
//  Moonshot
//
//  Created by Ramanan on 17/11/22.
//

import Foundation

struct CrewMembers {
    let role: String
    let astronaut: Astronaut
} //challenge

struct Mission: Codable, Identifiable {
    struct CrewRole: Codable {
        var name: String
        var role: String
    }
    
    var id: Int
    var launchDate: Date?
    var crew : [CrewRole]
    var description: String
    
    var displayName: String {
        "Apollo \(id)"
    }
    
    var image: String {
        "apollo\(id)"
    }
    
    var formattedLaunchDate: String {
        launchDate?.formatted(date: .abbreviated, time: .omitted) ?? "N/A"
    }
    
    var briefLaunchDate: String {
        launchDate?.formatted(date: .complete, time: .omitted) ?? "N/A"
    }
}
