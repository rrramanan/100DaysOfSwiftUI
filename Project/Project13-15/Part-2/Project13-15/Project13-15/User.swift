//
//  User.swift
//  Project13-15
//
//  Created by Ramanan on 24/01/23.
//

import Foundation
import UIKit
import CoreLocation

struct User: Identifiable, Codable, Comparable {
    
    var id : UUID
    var name: String
    var image: Data //UIImage
    var userMap: Location
    
    static func <(lhs: User, rhs: User) -> Bool {
        lhs.name < rhs.name
    }
}

//struct userCollect {
//    var allUser = [User]()
//}

struct Location: Identifiable, Codable, Equatable {
    var id : UUID
    let name: String
    let latitude: Double
    let longitude: Double
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    static let example = Location(id: UUID(), name: "Buckingham Palace", latitude: 51.501, longitude: -0.141)
    
    static func ==(lhs: Location, rhs: Location) -> Bool {
        lhs.id == rhs.id
    }
}
