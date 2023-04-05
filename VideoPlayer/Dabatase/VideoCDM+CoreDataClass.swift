//
//  VideoCDM+CoreDataClass.swift
//  
//
//  Created by Maxim Vynnyk on 05.04.2023.
//
//

import Foundation
import CoreData

@objc(VideoCDM)
final class VideoCDM: BaseCDM {
    class func objectPredicate(id: String? = nil) -> NSPredicate? {
        guard let id else { return nil }
        return .init(format: "id == '\(id)'")
    }
}
