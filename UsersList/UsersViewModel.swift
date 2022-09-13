//
//  UsersViewModel.swift
//  UsersList
//
//  Created by FABRICIO ALVARENGA on 07/09/22.
//

import Foundation
import CoreData

final class UsersViewModel: ObservableObject {
    let manager = DataManager.shared
    
    @Published var savedUsers = [UserEntity]()
    @Published var downloaded = false

    private var users = [User]()
    
    // Carrega todos os usuários armazenados no dispositivo, no array savedUsers
    @MainActor
    func fetchUsers() {
        let request = UserEntity.fetchRequest()
        
        do {
            savedUsers = try manager.context.fetch(request).sorted { $0.name ?? "" < $1.name ?? "" }
        } catch {
            print("Error fetching! \(error)")
        }
    }
    
    // Deleta um usuário tanto do array savedUsers, quanto do dispositivo
    func deleteUser(indexSet: IndexSet) {
        guard let index = indexSet.first else { return }

        let user = savedUsers[index]
        manager.context.delete(user)
        manager.save()

        savedUsers.remove(at: index)
    }
    
    
    // A função armazena no dispositivo e insere no array savedUsers somente os usuários
    // que ainda não foram armazenados, usuários novos contidos na URL e usuários que,
    // porventura, tenham sido excluídos, mantendo assim a base de dados sempre atualizada.
    // Os mesmo usuários são adicioinados ao array savedUsers.
    @MainActor
    func addNewUsers() {
        for user in users {
            // Verifica se o usuário já está armazenado no dispositivo. Caso esteja, retorna sem fazer nada.
            let filteredUser = savedUsers.filter { filtered in
                filtered.id == user.id
            }
            
            // Adiciona todos os amigos do usuário ao conjunto friendsSet e
            // cria as entidades para que os amigos sejam armazenados no dispositivo
            var friendsSet: Set<FriendEntity> = []
            for friend in user.friends {
                let newFriend = FriendEntity(context: manager.context)
                newFriend.id = friend.id
                newFriend.name = friend.name
                
                friendsSet.insert(newFriend)
            }
            
            // Caso o usuário não esteja ainda armazenado no dispositivo,
            // adiciona-o ao array savedUsers e cria a entidade necessária
            // para armazena-lo
            if filteredUser.isEmpty {
                let newUser = UserEntity(context: manager.context)
                newUser.id = user.id
                newUser.isActive = user.isActive
                newUser.name = user.name
                newUser.age = user.age
                newUser.company = user.company
                newUser.email = user.email
                newUser.address = user.address
                newUser.about = user.about
                newUser.registered = user.registered
                newUser.tags = user.tagsString
                newUser.friends = friendsSet as NSSet
                
                savedUsers.append(newUser)
            }

        }
        savedUsers  = savedUsers.sorted { $0.name ?? "" < $1.name ?? ""}
        manager.save()
    }
    
    
    // A função carrega os usuários armazenados no dispositivo
    // e logo após carrega os usuários através da URL.
    // Feito isso chama a função addNewUsers().
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
            await fetchUsers()

            let (data, _) = try await URLSession.shared.data(from: url)
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601

            let decodedUsers = try decoder.decode([User].self, from: data)

            users = decodedUsers.sorted { $0.name < $1.name }

            await addNewUsers()
        } catch {
            print("\(error.localizedDescription): \(error)")
        }

        await MainActor.run { downloaded = true }
    }

}
