//
//  CodeSnippets.swift
//  VideoPlayerMV
//
//  Created by Maxim Vynnyk on 19.08.2024.
//

import Foundation

protocol VideoObserver: AnyObject {}

final class ObserverStorage {
    var observer: Weak<VideoObserver>?
    
    func addObserver(_ observer: VideoObserver) {
        self.observer = .init(object: observer)
    }
}

struct Weak<T> {
    var object: T? { closure() }
    private let closure: () -> T?
    
    init(object: T) {
        let object = object as AnyObject
        closure = { [weak object] in
            object as? T
        }
    }
}
