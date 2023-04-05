//
//  MainViewModel.swift
//  VideoPlayer
//
//  Created by Maxim Vynnyk on 04.04.2023.
//

import Combine
import SwiftUI
import PhotosUI

final class MainViewModel: ObservableObject {
    @Published var images: [Image] = []
    @Published var importState = ImportState.idle
    @Published var videoSelection: PhotosPickerItem? {
        didSet {
            if let videoSelection {
                videoImporter.loadVideo(from: videoSelection)
            } else {
                importState = .idle
            }
        }
    }
    
    private let placeholderImage = Image(systemName: "star")
    private let videoImporter: VideoImporter
    private var subscriptions = Set<AnyCancellable>()
    
    init(videoImporter: VideoImporter) {
        self.videoImporter = videoImporter
        setupObservers()
    }
    
    private func setupObservers() {
        videoImporter.state
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: handleImporterState)
            .store(in: &subscriptions)
    }
    
    private func handleImporterState(_ state: VideoImporter.State) {
        switch state {
        case .loading:
            importState = .loading
        case .fail, .empty:
            importState = .idle
        case .loaded(let video):
            let image: Image = {
                if let image = video.image {
                    return Image(uiImage: image)
                }
                
                return placeholderImage
            }()
            
            images.insert(image, at: 0)
            importState = .idle
        }
    }
}

// MARK: - ImportState

extension MainViewModel {
    enum ImportState {
        case loading
        case idle
    }
}
