//
//  OrderModel.swift
//  CupcakeCorner
//
//  Created by Ramanan on 08/12/22.
//

import Foundation

//challenge
struct OrderModel: Codable {
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
    var type = 0
    var quantity = 3
    
    var specialRequestEnabled = false {
        didSet {
            if !specialRequestEnabled {
                extraForsting = false
                addSprinkles = false
            }
        }
    }
    var extraForsting = false
    var addSprinkles = false
    
    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""
    
    var hasValidAddress: Bool {
        if name.isEmpty || streetAddress.isEmpty || city.isEmpty || zip.isEmpty {
           return false
       }
        
       return true
   }
    
    var cost: Double {
        // $2 per cake
        var cost = Double(quantity) * 2
        
        // complicated cake cost more
        cost += (Double(type) / 2)
        
        // $1/Cake for extra frosting
        if extraForsting {
            cost += Double(quantity)
        }
        
        // $0.50/cake for sprinkles
        if addSprinkles {
            cost += Double(quantity) / 2
        }
        
        return cost
    }
}
