//
//  VideoManager.swift
//  VideoPlayerMV
//
//  Created by Maxim Vynnyk on 24.04.2023.
//

import Foundation
import Combine
import VideoPlayerModel
import VideoPlayerKit

@dynamicMemberLookup
final class VideoManager: ObservableObject {
    @Published private(set) var videos: [VideoModel] = []
    var importManager: MediaImportService
    
    private let version: Version
    private let storageService: StorageService
    private var subscriptions = Set<AnyCancellable>()

    init(version: Version = .normal, storageService: StorageService = .shared) {
        self.version = version
        self.storageService = storageService
        self.importManager = .init(mediaImporter: AppServices.createVideoImporter())
        setupObservers()
    }
    
    // Just to remember this feature
    subscript<T>(dynamicMember keyPath: KeyPath<MediaImportService, T>) -> T {
        importManager[keyPath: keyPath]
    }
    
    deinit {
        subscriptions.removeAll()
    }
    
    func deleteVideo(_ video: VideoModel) {
        Task { await storageService.deleteVideoAsync(video) }
    }
    
    func saveVideo(_ video: VideoModel) {
        Task { await storageService.saveVideoAsync(video) }
    }
    
    func loadVideos() async {
        // load only if there is no videos, if new videos are needed use 'refresh'
        guard videos.isEmpty else { return }
        await reloadVideos()
    }
    
    @MainActor private func reloadVideos() async {
        // TODO: Replace with provider
        switch version {
        case .debug:
            videos = Mockups.videoModels
        case .normal:
            videos = await storageService.getVideos().reversed()
        }
    }
    
    private func setupObservers() {
        storageService.updatesPublisher
            .debounce(for: 0.3, scheduler: RunLoop.current) // storage can update few times a second
            .receive(on: DispatchQueue.main)
            .asyncSink { [weak self] _ in
                await self?.reloadVideos()
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
