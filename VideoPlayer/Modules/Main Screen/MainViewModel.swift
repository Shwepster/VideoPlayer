//
//  MainViewModel.swift
//  VideoPlayer
//
//  Created by Maxim Vynnyk on 04.04.2023.
//

import Combine
import SwiftUI
import PhotosUI
import Model

extension MainView {
    @MainActor class ViewModel: ObservableObject {
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
        
        let videoListViewModel: VideoList.ViewModel
        private let videoImporter: MediaImporterProtocol
        
        init(videoImporter: MediaImporterProtocol) {
            self.videoImporter = videoImporter
            self.videoListViewModel = .init()
        }
        
        private func importVideo(from selection: PhotosPickerItem) {
            importState = .loading
            Task { @MainActor in
                // is saved in DB during loading
                let _ = await videoImporter.loadVideo(from: selection)
                importState = .idle
            }
        }
    }
}

// MARK: - ImportState

extension MainView.ViewModel {
    enum ImportState {
        case loading
        case idle
    }
}
