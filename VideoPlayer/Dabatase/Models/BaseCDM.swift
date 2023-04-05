//
//  BaseCDM.swift
//  VideoPlayer
//
//  Created by Maxim Vynnyk on 05.04.2023.
//

import CoreData

class BaseCDM: NSManagedObject {
    class func fetchRequest<T: BaseCDM>(predicate: NSPredicate? = nil) -> NSFetchRequest<T> {
        let request = NSFetchRequest<T>(entityName: "\(T.self)")
        request.predicate = predicate
        return request
    }
}
