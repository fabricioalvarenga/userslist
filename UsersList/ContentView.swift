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
                List(vm.users) { user in
                    NavigationLink {
                        UserDetailView(user: user)
                    } label: {
                        HStack {
                            Text(user.name)
                                .font(.headline)
                            
                            Spacer()
                            
                            Text(user.isActive ? "Active" : "Not Active")
                                .font(.subheadline.bold())
                                .foregroundColor(user.isActive ? .green : .red)
                        }
                    }
                }
                .task {
                    await vm.loadData()
                }
                .navigationTitle("Users List")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
