//
//  BaseCDM.swift
//  VideoPlayer
//
//  Created by Maxim Vynnyk on 05.04.2023.
//

import CoreData

protocol BaseCDM: UpdatableCDM, FetchableCDM {}

protocol UpdatableCDM: NSManagedObject {
    func update(_ data: Any)
}

protocol FetchableCDM: NSManagedObject {
    associatedtype FetchableType: NSManagedObject = Self
    associatedtype Identifier
    
    static var entityName : String { get }
    static func fetchRequest(predicate: NSPredicate?) -> NSFetchRequest<FetchableType>
    static func objectPredicate(id: Identifier) -> NSPredicate
}

extension FetchableCDM where Self: NSManagedObject {
    static var entityName: String {
        return String(describing: self)
    }
    
    static func fetchRequest(predicate: NSPredicate?) -> NSFetchRequest<FetchableType> {
        let request = NSFetchRequest<FetchableType>(entityName: entityName)
        request.predicate = predicate
        return request
    }
    
    static func objectPredicate(id: Identifier) -> NSPredicate {
        .init(format: "id == '\(id)'")
    }
}
