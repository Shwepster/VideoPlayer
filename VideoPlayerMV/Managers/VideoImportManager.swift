//
//  VideoImportManager.swift
//  VideoPlayerMV
//
//  Created by Maxim Vynnyk on 24.04.2023.
//

import Combine
import SwiftUI
import PhotosUI
import Model

final class VideoImportManager: ObservableObject {
    @Published var importState = ImportState.idle
    @Published var videoSelection: PhotosPickerItem? {
        didSet {
            if let videoSelection {
                importVideo(from: videoSelection)
            } else {
                importState = .idle
            }
        }
    }
    
    private let videoImporter: MediaImporterProtocol
    
    init(videoImporter: MediaImporterProtocol) {
        self.videoImporter = videoImporter
    }
    
    private func importVideo(from selection: PhotosPickerItem) {
        importState = .loading
        Task {
            // is saved in DB during loading
            let _ = await videoImporter.loadVideo(from: selection)
            
            Task { @MainActor in
                importState = .idle
            }
        }
    }
}

extension VideoImportManager {
    enum ImportState {
        case loading
        case idle
    }
}
