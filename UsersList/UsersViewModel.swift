//
//  UsersViewModel.swift
//  UsersList
//
//  Created by FABRICIO ALVARENGA on 07/09/22.
//

import Foundation

@MainActor
final class UsersViewModel: ObservableObject {
    @Published var users = [User]()
    @Published var downloaded = true

    func loadData() async {
        if !users.isEmpty {
            return
        }

        downloaded = false

        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            print("Invalid URL")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601

            let decodedUsers = try decoder.decode([User].self, from: data)

            users = decodedUsers.sorted { $0.name < $1.name }
        } catch {
            print("\(error.localizedDescription): \(error)")
        }
        
        downloaded = true
    }

}
