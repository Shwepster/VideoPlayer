//
//  PersistentContainer.swift
//  VideoPlayer
//
//  Created by Maxim Vynnyk on 05.04.2023.
//

import CoreData

final class PersistentContainer: NSPersistentContainer {
   func saveContext(_ context: NSManagedObjectContext? = nil) {
        let context = context ?? self.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                context.rollback()
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
