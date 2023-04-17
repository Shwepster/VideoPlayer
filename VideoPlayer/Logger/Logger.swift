//
//  Logger.swift
//  VideoPlayer
//
//  Created by Maxim Vynnyk on 16.04.2023.
//

import Foundation

protocol Logger {
    func log(event: Event)
}

final class BaseLogger: Logger {
    static let shared = BaseLogger()
    private init() {}
    
    func log(event: Event) {
        NSLog(event.name)
    }
}
