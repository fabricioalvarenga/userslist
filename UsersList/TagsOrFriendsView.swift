//
//  TagsOrFriendsView.swift
//  UsersList
//
//  Created by FABRICIO ALVARENGA on 07/09/22.
//

import SwiftUI

struct TagsOrFriendsView: View {
    var text: String
    var tagsOrFriends: String
    
    init(_ text: String, _ tagsOrFriends: String) {
        self.text = text
        self.tagsOrFriends = tagsOrFriends
    }
    
    var body: some View {
        VStack {
            Text(text)
                .font(.callout.bold())
            HStack {
                Text(tagsOrFriends)
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal)
                Spacer()
            }
        }
    }
}
