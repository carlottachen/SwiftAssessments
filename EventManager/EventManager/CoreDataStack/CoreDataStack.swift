//
//  CoreDataStack.swift
//  EventManager
//
//  Created by Carlotta Chen on 1/28/22.
//

import CoreData

enum CoreDataStack {
    
    static let container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: Strings.appName)
        
        container.loadPersistentStores { storeDescription, error in
            if let error = error {
                fatalError("Error loading persistent store \(error)")
            }
        }
        return container
        
    } ()
    
    static var context: NSManagedObjectContext { return container.viewContext }
    
    static func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                NSLog("Error saving context \(error)")
            }
        }
    }
}
