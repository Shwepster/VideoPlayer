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

final class MediaImporterLoggingProxy: MediaImporterProtocol {
    var state: CurrentValueSubject<MediaImporterState, Never> { mediaImporter.state }
    
    private let mediaImporter: MediaImporterProtocol
    private let logger: Logger
    
    init(mediaImporter: MediaImporterProtocol, logger: Logger = BaseLogger.shared) {
        self.mediaImporter = mediaImporter
        self.logger = logger
    }
    
    func loadVideo(from selection: PhotosPickerItem) async -> VideoModel? {
        logger.log(event: .startImportingVideo())
        let result = await mediaImporter.loadVideo(from: selection)
        logger.log(event: .finishImportingVideo())
        
        return result
    }
    
    func loadImage(from selection: PhotosPickerItem) async -> (UIImage?, URL?) {
        return await mediaImporter.loadImage(from: selection)
    }
}
