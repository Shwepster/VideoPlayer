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
        @Published var videoSelection: [PhotosPickerItem] = [] {
            didSet {
                if let selection = videoSelection.first {
                    importVideo(from: selection)
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
            // is saved in DB during loading
            Task.detached {
                await videoImporter.loadVideo(from: selection)
                MainActor.run {
                    importState = .idle
                    videoSelection.removeAll()
                }
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
