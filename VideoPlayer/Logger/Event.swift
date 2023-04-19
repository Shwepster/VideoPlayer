//
//  Event.swift
//  VideoPlayer
//
//  Created by Maxim Vynnyk on 16.04.2023.
//

import Foundation

struct Event {
    var parameters: [AnyHashable: Any]
    var name: String
    
    init(name: String, parameters: [AnyHashable: Any] = [:]) {
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
    
    static func generatedPreview(path: String) -> Self {
        .init(name: "Generated preview", parameters: ["path": path])
    }
    
    static func videoImportedSuccess(videoPath: String) -> Self {
        .init(name: "Video imported success", parameters: ["path": videoPath])
    }
}
