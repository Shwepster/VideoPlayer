//
//  VideoManager.swift
//  VideoPlayerMV
//
//  Created by Maxim Vynnyk on 24.04.2023.
//

import Combine
import Model

final class VideoManager: ObservableObject {
    @Published private(set) var videos: [VideoModel] = []
    var importManager: MediaImportManager
    
    private let version: Version
    private let storageService: StorageService
    private var subscriptions = Set<AnyCancellable>()

    init(version: Version = .normal, storageService: StorageService = .shared) {
        self.version = version
        self.storageService = storageService
        self.importManager = .init(mediaImporter: AppServices.createVideoImporter())
        setupObservers()
    }
    
    deinit {
        subscriptions.removeAll()
    }
    
    func deleteVideo(_ video: VideoModel) {
        storageService.deleteVideo(video)
    }
    
    func saveVideo(_ video: VideoModel) {
        storageService.saveVideo(video)
    }
    
    @MainActor
    func loadVideos() async {
        // load only if there is no videos, if new videos are needed use 'refresh'
        guard videos.isEmpty else { return }
        reloadVideos()
    }
    
    private func reloadVideos() {
        // TODO: Replace with provider
        switch version {
        case .debug:
            videos = PreviewHelper.videoModels
        case .normal:
            videos = storageService.getVideos().reversed()
        }
    }
    
    private func setupObservers() {
        storageService.updatesPublisher
            .debounce(for: 0.3, scheduler: RunLoop.current) // storage can update few times a second
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.reloadVideos()
            }
            .store(in: &subscriptions)
    }
}

// MARK: - Version

extension VideoManager {
    enum Version {
        case debug
        case normal
    }
}
