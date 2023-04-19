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
        let previewDecorator = MediaImporterPreviewDecorator(mediaImporter: mediaImporter)
        let loggerImporter = MediaImporterLoggingProxy(mediaImporter: previewDecorator, logger: logger)
        return loggerImporter
    }
    
    static var logger: Logger = BaseLogger()
}
