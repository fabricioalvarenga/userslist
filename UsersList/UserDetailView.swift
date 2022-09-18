//
//  UserDetailView.swift
//  UsersList
//
//  Created by FABRICIO ALVARENGA on 07/09/22.
//

import SwiftUI

struct RectangleDivider: View {
    var body: some View {
        Rectangle()
            .frame(height: 2)
            .foregroundColor(.secondary)
            .padding()
    }
}

struct UserDetailView: View {
    var userEntity: UserEntity
    
    var body: some View {
        ScrollView {
            VStack {
                Text(userEntity.wrappedName)
                    .font(.title)
                Text(userEntity.isActive ? "Active" : "Not Active")
                    .font(.headline)
                    .foregroundColor(userEntity.isActive ? .green : .red)
                Text("\(userEntity.age) years old")
                
                VStack {
                    Text("Company: \(userEntity.wrappedCompany)")
                    Text("Registered at \(userEntity.wrappedRegistered)")
                }
                .padding(1)
                
                Text(userEntity.wrappedEmail)
                Text(userEntity.wrappedAddress)
                
            }
            .font(.subheadline.bold())
            
            VStack {
                RectangleDivider()
                
                Text(userEntity.wrappedAbout)
                    .padding(.horizontal)
                
                RectangleDivider()
                
                TagsOrFriendsView("MY TAGS", userEntity.wrappedTags)
                
                RectangleDivider()
                
                TagsOrFriendsView("MY FRIENDS", userEntity.wrappedFriends)
            }
            .multilineTextAlignment(.leading)
            
            Spacer()
        }
    }
}
