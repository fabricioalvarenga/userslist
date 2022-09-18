//
//  UserEntity+CoreDataProperties.swift
//  UsersList
//
//  Created by FABRICIO ALVARENGA on 12/09/22.
//
//

import Foundation
import CoreData


extension UserEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserEntity> {
        return NSFetchRequest<UserEntity>(entityName: "UserEntity")
    }

    @NSManaged public var about: String?
    @NSManaged public var address: String?
    @NSManaged public var age: Int16
    @NSManaged public var company: String?
    @NSManaged public var email: String?
    @NSManaged public var id: UUID?
    @NSManaged public var isActive: Bool
    @NSManaged public var name: String?
    @NSManaged public var registered: Date?
    @NSManaged public var tags: String?
    @NSManaged public var friends: NSSet?
    
    public var wrappedAbout: String { about ?? "" }
    public var wrappedAddress: String { address ?? "Unknown Address" }
    public var wrappedCompany: String { company ?? "Unknow Company" }
    public var wrappedEmail: String { email ?? "Unknow Email" }
    public var wrappedName: String { name ?? "Unknown Name" }
    public var wrappedRegistered: String { Date.now.formatted(date: .abbreviated, time: .omitted) }
    public var wrappedTags: String { tags ?? "" }
    
    public var wrappedFriends: String {
        let set = friends as? Set<FriendEntity> ?? []
        
        let friendsArray: [FriendEntity] = set.sorted { $0.wrappedName < $1.wrappedName }
        
        let namesArray: [String] = friendsArray.compactMap { $0.wrappedName }
        
        let names: String = namesArray.joined(separator: ", ")
        
        return names
    }
    
}

// MARK: Generated accessors for friends
extension UserEntity {

    @objc(addFriendsObject:)
    @NSManaged public func addToFriends(_ value: FriendEntity)

    @objc(removeFriendsObject:)
    @NSManaged public func removeFromFriends(_ value: FriendEntity)

    @objc(addFriends:)
    @NSManaged public func addToFriends(_ values: NSSet)

    @objc(removeFriends:)
    @NSManaged public func removeFromFriends(_ values: NSSet)

}

extension UserEntity : Identifiable {

}
