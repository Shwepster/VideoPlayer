//
//  MediaImporterDecorator.swift
//  VideoPlayer
//
//  Created by Maxim Vynnyk on 17.04.2023.
//

import Foundation
import SwiftUI
import PhotosUI
import Combine

class MediaImporterDecorator: MediaImporterProtocol {
    private let mediaImporter: MediaImporterProtocol
    
    init(mediaImporter: MediaImporterProtocol) {
        self.mediaImporter = mediaImporter
    }
    
    func loadVideo(from selection: PhotosPickerItem) async -> VideoModel? {
        await mediaImporter.loadVideo(from: selection)
    }
    
    func loadImage(from selection: PhotosPickerItem) async -> (UIImage?, URL?) {
        await mediaImporter.loadImage(from: selection)
    }
}

final class MediaImporterPreviewDecorator: MediaImporterDecorator {
    private let previewGenerator: PreviewGenerator
    private let storageService: StorageService
    
    init(
        mediaImporter: MediaImporterProtocol,
        previewGenerator: PreviewGenerator = .shared,
        storageService: StorageService = .shared
    ) {
        self.previewGenerator = previewGenerator
        self.storageService = storageService
        super.init(mediaImporter: mediaImporter)
    }

    override func loadVideo(from selection: PhotosPickerItem) async -> VideoModel? {
        let video = await super.loadVideo(from: selection)

        if let video {
            // Chain of Command
            let handler = PreviewGenerationImportingHandler()
            handler.setNext(PreviewCompressorImportingHandler())
            
            let video = await handler.handleVideo(video)
            
            storageService.saveVideo(video)
            return video
        } else {
            return video
        }
    }
}
