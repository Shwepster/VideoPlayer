//
//  AppServices.swift
//  VideoPlayer
//
//  Created by Maxim Vynnyk on 17.04.2023.
//

import Foundation
import Model

enum AppServices {
    static func createVideoImporter() -> MediaImporterProtocol {
        let mediaImporter = MediaImporter()
        let previewDecorator = MediaImporterPreviewDecorator(mediaImporter: mediaImporter)
        let loggerImporter = MediaImporterLoggingProxy(mediaImporter: previewDecorator, logger: logger)
        return loggerImporter
    }
    
    static func createImageImporter() -> MediaImporterProtocol {
        let mediaImporter = MediaImporter()
        let loggerImporter = MediaImporterLoggingProxy(mediaImporter: mediaImporter, logger: logger)
        return loggerImporter
    }
    
    static var logger: Logger = BaseLogger()
}
