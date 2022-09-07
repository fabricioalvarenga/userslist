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
    var user: User
    
    var body: some View {
        ScrollView {
            VStack {
                Text(user.name)
                    .font(.title)
                Text(user.isActive ? "Active" : "Not Active")
                    .font(.headline)
                    .foregroundColor(user.isActive ? .green : .red)
                Text("\(user.age) years old")
                
                VStack {
                    Text("Company: \(user.company)")
                    Text("Registered at \(user.registered?.formatted(date: .abbreviated, time: .omitted) ?? Date.now.formatted(date: .abbreviated, time: .omitted))")
                }
                .padding(1)
                
                Text(user.email)
                Text(user.address)
                
            }
            .font(.subheadline.bold())
            
            VStack {
                RectangleDivider()
                
                Text(user.about)
                    .padding(.horizontal)
                
                RectangleDivider()
                
                TagsOrFriendsView("MY TAGS", user.tagsString)
                
                RectangleDivider()
                
                TagsOrFriendsView("MY FRIENDS", user.friendsString)
            }
            .multilineTextAlignment(.leading)
            
            Spacer()
        }
    }
}
