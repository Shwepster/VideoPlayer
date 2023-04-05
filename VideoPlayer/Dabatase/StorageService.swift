//
//  StorageService.swift
//  VideoPlayer
//
//  Created by Maxim Vynnyk on 05.04.2023.
//

import CoreData

final class StorageService {
    static let shared = StorageService()
    private init() {}
    
    private lazy var persistentContainer: PersistentContainer = {
        let container = PersistentContainer(name: "Database")
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Unable to load persistent stores: \(error)")
            }
        }
        return container
    }()
}
