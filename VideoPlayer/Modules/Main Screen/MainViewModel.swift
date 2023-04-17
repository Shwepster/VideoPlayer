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
    @MainActor class ViewModel: ObservableObject {
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
        
        let videoListViewModel: VideoList.ViewModel
        private let videoImporter: MediaImporterProtocol
        private var subscriptions = Set<AnyCancellable>()
        
        init(videoImporter: MediaImporterProtocol) {
            self.videoImporter = videoImporter
            self.videoListViewModel = .init()
            setupObservers()
        }
        
        deinit {
            subscriptions.removeAll()
        }
        
        private func setupObservers() {
            videoImporter.state
                .receive(on: DispatchQueue.main)
                .sink { [weak self] state in
                    self?.handleImporterState(state)
                }
                .store(in: &subscriptions)
        }
        
        private func handleImporterState(_ state: MediaImporterState) {
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
