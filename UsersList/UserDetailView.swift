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
                Text(userEntity.name ?? "")
                    .font(.title)
                Text(userEntity.isActive ? "Active" : "Not Active")
                    .font(.headline)
                    .foregroundColor(userEntity.isActive ? .green : .red)
                Text("\(userEntity.age) years old")
                
                VStack {
                    Text("Company: \(userEntity.company ?? "")")
                    Text("Registered at \(userEntity.registered?.formatted(date: .abbreviated, time: .omitted) ?? Date.now.formatted(date: .abbreviated, time: .omitted))")
                }
                .padding(1)
                
                Text(userEntity.email ?? "")
                Text(userEntity.address ?? "")
                
            }
            .font(.subheadline.bold())
            
            VStack {
                RectangleDivider()
                
                Text(userEntity.about ?? "")
                    .padding(.horizontal)
                
                RectangleDivider()
                
                TagsOrFriendsView("MY TAGS", userEntity.tags ?? "")
                
                RectangleDivider()
                
                TagsOrFriendsView("MY FRIENDS", userEntity.friendsString)
            }
            .multilineTextAlignment(.leading)
            
            Spacer()
        }
    }
}
