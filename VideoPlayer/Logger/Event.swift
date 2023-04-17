//
//  Event.swift
//  VideoPlayer
//
//  Created by Maxim Vynnyk on 16.04.2023.
//

import Foundation

struct Event {
    var parameters: [String: AnyObject]
    var name: String
    
    init(parameters: [String: AnyObject] = [:], name: String) {
        self.parameters = parameters
        self.name = name
    }
}

extension Event {
    static func startImportingVideo() -> Self {
        .init(name: "Start importing")
    }
    
    static func finishImportingVideo() -> Self {
        .init(name: "Finish importing")
    }
}
