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
    func log(event: Event) {
        if event.parameters.isEmpty {
            NSLog("%@", event.name)
        } else {
            NSLog("%@\nParameters:\n%@", event.name, event.parameters)
        }
    }
}
