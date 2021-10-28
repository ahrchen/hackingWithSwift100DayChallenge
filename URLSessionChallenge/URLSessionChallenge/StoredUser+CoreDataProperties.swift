//
//  StoredUser+CoreDataProperties.swift
//  URLSessionChallenge
//
//  Created by Raymond Chen on 10/26/21.
//
//

import Foundation
import CoreData


extension StoredUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<StoredUser> {
        return NSFetchRequest<StoredUser>(entityName: "StoredUser")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var isActive: Bool
    @NSManaged public var age: Int16
    @NSManaged public var company: String?
    @NSManaged public var email: String?
    @NSManaged public var about: String?
    @NSManaged public var address: String?
    @NSManaged public var registered: Date?
    @NSManaged public var tags: [String]?
    @NSManaged public var friend: NSSet?
    
    public var wrappedName: String {
        return name ?? "Unknown"
    }
    
    public var wrappedEmail: String {
        return email ?? "Unknown"
    }
    
    public var friends: [StoredUser] {
        let set = friend as? Set<StoredUser> ?? []
        return set.sorted { $0.wrappedName < $1.wrappedName}
    }
    
    func populate(from user: User) {
        self.id = user.id
        self.name = user.name
        self.isActive = user.isActive
        self.age = Int16(user.age)
        self.company = user.company
        self.email = user.email
        self.about = user.about
        self.address = user.address
        self.registered = user.registered
        self.tags = user.tags
    }
}

// MARK: Generated accessors for friend
extension StoredUser {

    @objc(addFriendObject:)
    @NSManaged public func addToFriend(_ value: StoredUser)

    @objc(removeFriendObject:)
    @NSManaged public func removeFromFriend(_ value: StoredUser)

    @objc(addFriend:)
    @NSManaged public func addToFriend(_ values: NSSet)

    @objc(removeFriend:)
    @NSManaged public func removeFromFriend(_ values: NSSet)

}

extension StoredUser : Identifiable {

}
