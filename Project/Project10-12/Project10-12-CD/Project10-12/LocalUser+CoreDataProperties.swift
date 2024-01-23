//
//  LocalUser+CoreDataProperties.swift
//  Project10-12
//
//  Created by Ramanan on 24/12/22.
//
//

import Foundation
import CoreData


extension LocalUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LocalUser> {
        return NSFetchRequest<LocalUser>(entityName: "LocalUser")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var age: Int16
    @NSManaged public var isActive: Bool
    @NSManaged public var company: String?
    @NSManaged public var email: String?
    @NSManaged public var about: String?
    @NSManaged public var registered: Date?
    @NSManaged public var address: String?
    @NSManaged public var origin: NSSet?

    public var friendArray: [LocalFriend] {
        let set = origin as? Set<LocalFriend> ?? []
        
        return set.sorted {
            $0.id > $1.id
        }
    }
    
}

// MARK: Generated accessors for origin
extension LocalUser {

    @objc(addOriginObject:)
    @NSManaged public func addToOrigin(_ value: LocalFriend)

    @objc(removeOriginObject:)
    @NSManaged public func removeFromOrigin(_ value: LocalFriend)

    @objc(addOrigin:)
    @NSManaged public func addToOrigin(_ values: NSSet)

    @objc(removeOrigin:)
    @NSManaged public func removeFromOrigin(_ values: NSSet)

}

extension LocalUser : Identifiable {

}
