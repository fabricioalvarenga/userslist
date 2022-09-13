//
//  CoreDataController.swift
//  UsersList
//
//  Created by FABRICIO ALVARENGA on 08/09/22.
//

import Foundation
import CoreData

final class DataManager {
    static let shared = DataManager()
    
    let container: NSPersistentContainer
    let context: NSManagedObjectContext
    
    init() {
        container = NSPersistentContainer(name: "UsersDataModel")
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Error loading Core Data! \(error)")
            }
        }
        
        context = container.viewContext
        context.mergePolicy = NSMergePolicy.mergeByPropertyStoreTrump

    }
    
    func save() {
        do {
            try context.save()
        } catch let error {
            print("Error saving! \(error)")
        }
    }
}
