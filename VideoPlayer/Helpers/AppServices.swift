//
//  AppServices.swift
//  VideoPlayer
//
//  Created by Maxim Vynnyk on 17.04.2023.
//

import Foundation

enum AppServices {
    static func createMediaImporter() -> MediaImporterProtocol {
        let mediaImporter = MediaImporter()
        let loggerImporter = MediaImporterLoggingProxy(mediaImporter: mediaImporter)
        // TODO: Add Decorator for preview generation
        return loggerImporter
    }
}
