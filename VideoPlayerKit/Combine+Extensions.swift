//
//  CombineExtensions.swift
//  VideoPlayer
//
//  Created by Maxim Vynnyk on 04.04.2023.
//

import Foundation
import Combine

extension AnyCancellable {
    public func store(untilDeallocating object: NSObject) {
        object.subscriptions[.retain]?.insert(self)
    }
}
