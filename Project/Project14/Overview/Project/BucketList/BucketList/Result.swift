//
//  Result.swift
//  BucketList
//
//  Created by Ramanan on 11/01/23.
//

import Foundation

struct Result: Codable {
    let query: Query
}

struct Query: Codable {
    let pages: [Int: Page]
}

struct Page: Codable, Comparable {
    let pageid: Int
    let title: String
    let terms: [String : [String]]?
    
    //#5 - Sorting Wikipedia results
    var description: String {
        terms?["description"]?.first ?? "No further informaation"
    }
    
   static func <(lhs: Page, rhs: Page) -> Bool {
       lhs.title < rhs.title
    }
    
}
