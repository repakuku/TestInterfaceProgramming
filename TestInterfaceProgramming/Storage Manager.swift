//
//  Storage Manager.swift
//  TestInterfaceProgramming
//
//  Created by Alexey Turulin on 8/3/23.
//

import CoreData

final class StorageManager {
    
    static let shared = StorageManager()
    
    private var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "TestInterfaceProgramming")
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Unable to load persistent stores: \(error)")
            }
        }
        
        return container
    }()
    
    private var context: NSManagedObjectContext
    
    private init() {
        context = persistentContainer.viewContext
    }
    
    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch let error as NSError {
                print("Error: \(error), \(error.userInfo)")
            }
        }
    }
}
