//
//  CoreDataStack.swift
//  Execellent_web_world_practice_task
//
//  Created by Saumil Doshi on 23/11/24.
//

import CoreData

class CoreDataStack {
    static let shared = CoreDataStack()
    
    lazy var persistentContainer: NSPersistentContainer = {
            let container = NSPersistentContainer(name: "DataUserModal")
            container.loadPersistentStores(completionHandler: { (storeDescription, error) in
                if let error = error as NSError? {
                    print("Unresolved error \(error), \(error.userInfo)")
                }
            })
            return container;
        }()

    lazy var context = self.persistentContainer.viewContext
    
        func save() {
            let context = persistentContainer.viewContext;
            if context.hasChanges {
                do {
                    try context.save()
                } catch {
                    print("Failure to save context: \(error)")
                }
            }
        }
}

