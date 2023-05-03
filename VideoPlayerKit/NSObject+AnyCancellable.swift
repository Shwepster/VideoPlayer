//
//  NSObject+AnuCancellable.swift
//  VideoPlayer
//
//  Created by Maxim Vynnyk on 04.04.2023.
//

import Foundation
import Combine

private var _key: UInt8 = 0

extension NSObject {
    enum Key: Hashable {
        case retain
        case temporary(key: AnyHashable)
    }
    
    var subscriptions: [Key: Set<AnyCancellable>] {
        get {
            guard let associatedObject = objc_getAssociatedObject(self, &_key) else {
                return [.retain: Set<Combine.AnyCancellable>()]
            }
            
            return associatedObject as! [Key: Set<AnyCancellable>]
        }
        set {
            objc_setAssociatedObject(
                self,
                &_key,
                newValue,
                .OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
        }
    }
}
