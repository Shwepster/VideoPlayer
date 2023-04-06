//
//  PersistentContainer.swift
//  VideoPlayer
//
//  Created by Maxim Vynnyk on 05.04.2023.
//

import CoreData

final class PersistentContainer: NSPersistentContainer {
    private lazy var backgroundContext = newBackgroundContext()
    
    func setup() {
        let storeDescription = NSPersistentStoreDescription()
        storeDescription.shouldMigrateStoreAutomatically = true
        storeDescription.shouldInferMappingModelAutomatically = false // because we have custom mapper
        persistentStoreDescriptions.append(storeDescription)
        
        loadPersistentStores { description, error in
            if let error = error {
                fatalError("Unable to load persistent stores: \(error)")
            }
        }
        
        viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        viewContext.shouldDeleteInaccessibleFaults = true
        viewContext.automaticallyMergesChangesFromParent = true
    }
    
    func getObjects<T: FetchableCDM>(_ predicate: NSPredicate? = nil) -> [T]? {
        let request = T.fetchRequest(predicate: predicate)
        let objects = try? viewContext.fetch(request)
        return objects as? [T]
    }
    
    func getObject<T: FetchableCDM>(predicate: NSPredicate) -> T? {
        getObjects(predicate)?.first
    }
    
    func createObject<T: UpdatableCDM>(type: T.Type, data: Any) {
        let object = T(context: backgroundContext)
        object.update(data)
        saveContext(backgroundContext)
    }
    
    /// Updates object. If it does not exist - creates it
    func saveObject<T: UpdatableCDM & FetchableCDM>(type: T.Type, data: Any, predicate: NSPredicate) {
        let object: T? = getObject(predicate: predicate)
        
        if let object {
            object.update(data)
            saveContext(backgroundContext)
        } else {
            createObject(type: type, data: data)
        }
    }
    
    func deleteObjects<T: FetchableCDM>(of type: T.Type, predicate: NSPredicate) {
        let a: [T]? = getObjects(predicate)
        a?.forEach { object in
            backgroundContext.delete(object)
        }
        
        saveContext(backgroundContext)
    }
    
    private func saveContext(_ context: NSManagedObjectContext? = nil) {
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
        
        self.newBackgroundContext()
    }
}
