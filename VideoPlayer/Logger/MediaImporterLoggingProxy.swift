//
//  MediaImporterLoggingProxy.swift
//  VideoPlayer
//
//  Created by Maxim Vynnyk on 16.04.2023.
//

import Foundation
import UIKit
import PhotosUI
import SwiftUI
import Combine
import Model

final class MediaImporterLoggingProxy: MediaImporterProtocol {    
    private let mediaImporter: MediaImporterProtocol
    private let logger: Logger
    
    init(mediaImporter: MediaImporterProtocol, logger: Logger) {
        self.mediaImporter = mediaImporter
        self.logger = logger
    }
    
    func loadVideo(from selection: PhotosPickerItem) async -> VideoModel? {
        logger.log(event: .startImportingVideo())
        let result = await mediaImporter.loadVideo(from: selection)
        
        if let preview = result?.imageURL {
            logger.log(event: .generatedPreview(path: preview.path()))
        }
        
        if let result {
            logger.log(event: .videoImportedSuccess(videoPath: result.videoURL.path()))
        }
        
        logger.log(event: .finishImportingVideo())
        return result
    }
    
    func loadImage(from selection: PhotosPickerItem) async -> (UIImage?, URL?) {
        await mediaImporter.loadImage(from: selection)
    }
}
