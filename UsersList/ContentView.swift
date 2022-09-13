//
//  ContentView.swift
//  UsersList
//
//  Created by FABRICIO ALVARENGA on 04/09/22.
//

import SwiftUI

extension View {
    @ViewBuilder func isHidden(_ isHidden: Bool) -> some View {
        if isHidden {
            self.hidden()
        } else {
            self
        }
    }
}

struct ContentView: View {
    @StateObject private var vm = UsersViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                List {
                    ForEach(vm.savedUsers) { userEntity in
                        NavigationLink {
                            UserDetailView(userEntity: userEntity)
                        } label: {
                            HStack {
                                Text(userEntity.name ?? "")
                                    .font(.headline)
                                
                                Spacer()
                                
                                Text(userEntity.isActive ? "Active" : "Not Active")
                                    .font(.subheadline.bold())
                                    .foregroundColor(userEntity.isActive ? .green : .red)
                            }
                        }
                    }
                    .onDelete(perform: vm.deleteUser)
                }
                .task {
                    await vm.loadData()
                }
                .navigationTitle("Users List")
                
                ProgressView()
                    .isHidden(vm.downloaded)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
