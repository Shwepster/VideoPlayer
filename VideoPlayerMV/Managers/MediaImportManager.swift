//
//  MediaImportManager.swift
//  VideoPlayerMV
//
//  Created by Maxim Vynnyk on 24.04.2023.
//

import Combine
import SwiftUI
import PhotosUI
import VideoPlayerModel

extension PhotosPickerItem: @unchecked Sendable {
    
}

final class MediaImportManager: ObservableObject, Sendable {
    private let mediaImporter: MediaImporterProtocol & Sendable
    @Published var importState = ImportState.idle
    @Published var importedMedia = ImportedMedia.empty
    @Published var mediaSelection: PhotosPickerItem? {
        didSet {
            if let mediaSelection {
                importVideo(from: mediaSelection)
            } else {
                importState = .idle
            }
        }
    }
    
    init(mediaImporter: MediaImporterProtocol & Sendable) {
        self.mediaImporter = mediaImporter
    }
    
    private func importVideo(from selection: PhotosPickerItem) {
        importState = .loading
        
        Task.detached(priority: .low) {
            @LoggedValue(title: "Importing result")
            var result = ImportedMedia.empty
            
            if selection.supportedContentTypes.contains(.jpeg) {
                let (image, url) = await self.mediaImporter.loadImage(from: selection)
                if let image, let url {
                    result = .image(image, url)
                }
            } else {
                // is saved in DB during loading
                if let videoModel = await self.mediaImporter.loadVideo(from: selection) {
                    result = .video(videoModel)
                }
            }
            
            await MainActor.run { [result] in
                self.importState = .idle
                self.importedMedia = result
            }
        }
    }
}

// MARK: - Enums

extension MediaImportManager {
    enum ImportState: Sendable {
        case loading
        case idle
    }
    
    enum ImportedMedia: Sendable {
        case video(VideoModel)
        case image(UIImage, URL)
        case empty
    }
}
