//
//  StoredUser+CoreDataProperties.swift
//  Friendly
//
//  Created by Raymond Chen on 10/27/21.
//
//

import Foundation
import CoreData


extension StoredUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<StoredUser> {
        return NSFetchRequest<StoredUser>(entityName: "StoredUser")
    }

    @NSManaged public var about: String?
    @NSManaged public var age: Int16
    @NSManaged public var company: String?
    @NSManaged public var email: String?
    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var friend: NSSet?

    public var wrappedAbout: String {
        return about ?? "No About information"
    }
    
    public var wrappedCompany: String {
        return company ?? "No Company Information"
    }
    
    public var wrappedEmail: String {
        return email ?? "No Email Information"
    }
    
    public var wrappedId: UUID {
        return id ?? UUID()
    }
    
    public var wrappedName: String {
        return name ?? "No Name Available"
    }
    
    public var wrappedFriends: [StoredUser] {
        let set = friend as? Set<StoredUser> ?? []
        return set.sorted(by: {$0.wrappedName < $1.wrappedName})
    }
    
    func populate(from user: User) {
        self.name = user.name
        self.age = Int16(user.age)
        self.company = user.company
        self.email = user.email
        self.about = user.about
        self.id = user.id
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
