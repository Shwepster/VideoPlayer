//
//  MainViewModel.swift
//  VideoPlayer
//
//  Created by Maxim Vynnyk on 04.04.2023.
//

import Combine
import SwiftUI
import PhotosUI

extension MainView {
    class ViewModel: ObservableObject {
        @Published var videos: [VideoModel] = []
        @Published var importState = ImportState.idle
        @Published var videoSelection: PhotosPickerItem? {
            didSet {
                if let videoSelection {
                    Task {
                        await videoImporter.loadVideo(from: videoSelection)
                    }
                } else {
                    importState = .idle
                }
            }
        }
        
        private let videoImporter: VideoImporter
        private let storageService: StorageService
        private var subscriptions = Set<AnyCancellable>()
        
        init(videoImporter: VideoImporter, storageService: StorageService = .shared) {
            self.videoImporter = videoImporter
            self.storageService = storageService
            setupObservers()
            loadVideos()
        }
        
        private func loadVideos() {
            videos = storageService.getVideos().reversed()
        }
        
        private func setupObservers() {
            videoImporter.state
                .receive(on: DispatchQueue.main)
                .sink { [weak self] state in
                    self?.handleImporterState(state)
                }
                .store(in: &subscriptions)
            
            storageService.updatesPublisher
                .receive(on: DispatchQueue.main)
                .sink { [weak self] _ in
                    NSLog("Storage updated!")
                    self?.loadVideos()
                }
                .store(in: &subscriptions)
        }
        
        private func handleImporterState(_ state: VideoImporter.State) {
            switch state {
            case .loading:
                importState = .loading
            case .fail, .empty, .loaded:
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
