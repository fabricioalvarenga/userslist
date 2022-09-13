//
//  FriendEntity+CoreDataProperties.swift
//  UsersList
//
//  Created by FABRICIO ALVARENGA on 12/09/22.
//
//

import Foundation
import CoreData

extension FriendEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FriendEntity> {
        return NSFetchRequest<FriendEntity>(entityName: "FriendEntity")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var users: NSSet?
    
    public var wrappedName: String {
        name ?? "Unkown Friend"
    }
}

// MARK: Generated accessors for users
extension FriendEntity {

    @objc(addUsersObject:)
    @NSManaged public func addToUsers(_ value: UserEntity)

    @objc(removeUsersObject:)
    @NSManaged public func removeFromUsers(_ value: UserEntity)

    @objc(addUsers:)
    @NSManaged public func addToUsers(_ values: NSSet)

    @objc(removeUsers:)
    @NSManaged public func removeFromUsers(_ values: NSSet)

}

extension FriendEntity : Identifiable {

}
