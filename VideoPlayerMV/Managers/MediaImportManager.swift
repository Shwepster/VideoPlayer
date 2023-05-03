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

final class MediaImportManager: ObservableObject {
    private let mediaImporter: MediaImporterProtocol
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
    
    init(mediaImporter: MediaImporterProtocol) {
        self.mediaImporter = mediaImporter
    }
    
    private func importVideo(from selection: PhotosPickerItem) {
        importState = .loading
        
        Task {
            var result = ImportedMedia.empty
            
            if selection.supportedContentTypes.contains(.jpeg) {
                let (image, url) = await mediaImporter.loadImage(from: selection)
                if let image, let url {
                    result = .image(image, url)
                }
            } else {
                // is saved in DB during loading
                if let videoModel = await mediaImporter.loadVideo(from: selection) {
                    result = .video(videoModel)
                }
            }
            
            Task { @MainActor [result] in
                importState = .idle
                importedMedia = result
            }
        }
    }
}

// MARK: - Enums

extension MediaImportManager {
    enum ImportState {
        case loading
        case idle
    }
    
    enum ImportedMedia {
        case video(VideoModel)
        case image(UIImage, URL)
        case empty
    }
}
