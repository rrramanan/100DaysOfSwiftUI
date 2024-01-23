//
//  Resort.swift
//  SnowSeeker
//
//  Created by Ramanan on 23/02/23.
//

import Foundation

struct Resort: Codable, Identifiable, Comparable {
    
    let id: String
    let name: String
    let country: String
    let description: String
    let imageCredit: String
    let price: Int
    let size: Int
    let snowDepth: Int
    let elevation: Int
    let runs: Int
    let facilities: [String]
    
    var facilityTypes: [Facility] {
        facilities.map(Facility.init)
    }
    
    static let allResorts: [Resort] = Bundle.main.decode("resorts.json")
    static let example = allResorts[0]
    //static let example = (Bundle.main.decode("resorts.json") as [Result])[0]
    
    static func < (lhs: Resort, rhs: Resort) -> Bool {
        lhs.name < rhs.name
    }
    
    //challenge
    static func countrySort (lhs: Resort, rhs: Resort) -> Bool {
        lhs.country < rhs.country
    }
}
