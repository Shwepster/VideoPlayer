//
//  LoggedValue.swift
//  VideoPlayerKit
//
//  Created by Maxim Vynnyk on 19.08.2024.
//

import Foundation

@propertyWrapper
struct LoggedValue<T> {
    private var value: T
    private let title: String
    
    init(wrappedValue: T, title: String) {
        debugPrint("Creating '\(title)' with value: \(wrappedValue)")
        self.value = wrappedValue
        self.title = title
    }
    
    var wrappedValue: T {
        get {
            debugPrint("Accessing '\(title)' with value: \(value)")
            return value
        }
        
        set {
            debugPrint("Setting '\(title)' from: \(value), to: \(newValue)")
            value = newValue
        }
    }
}
