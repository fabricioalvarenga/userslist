//
//  User.swift
//  UsersList
//
//  Created by FABRICIO ALVARENGA on 04/09/22.
//

import Foundation

struct User: Codable, Identifiable {
    struct Friend: Codable, Identifiable, Hashable {
        var id: UUID
        var name: String
    }

    var id: UUID
    var isActive: Bool
    var name: String
    var age: Int16
    var company: String
    var email: String
    var address: String
    var about: String
    var registered: Date?
    var tags: [String]
    var friends: [Friend]
    
    var tagsString: String {
        tags.joined(separator: ", ")
    }
    
    var friendsString: String {
        let friends = friends.compactMap { friend in
            friend.name
        }
        return friends.joined(separator: ", ")
    }
    
}
