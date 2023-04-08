//
//  VideoListViewModel.swift
//  VideoPlayer
//
//  Created by Maxim Vynnyk on 07.04.2023.
//

import Combine
import Foundation

extension VideoList {
    @MainActor class ViewModel: ObservableObject {
        @Published private(set) var videos: [VideoModel] = []
        @Published var selectedVideo: VideoModel?
        private let storageService: StorageService
        private var subscriptions = Set<AnyCancellable>()

        init(selectedVideo: VideoModel? = nil, storageService: StorageService = .shared) {
            self.selectedVideo = selectedVideo
            self.storageService = storageService
            
            setupObservers()
            loadVideos()
        }
        
        deinit {
            subscriptions.removeAll()
        }
        
        func selectVideo(_ video: VideoModel) {
            selectedVideo = video
        }
        
        func deselectVideo() {
            selectedVideo = nil
        }
        
        func deleteVideo(_ video: VideoModel) {
            storageService.deleteVideo(video)
        }
        
        private func loadVideos() {
            videos = storageService.getVideos().reversed()
        }
        
        private func setupObservers() {
            storageService.updatesPublisher
                .receive(on: DispatchQueue.main)
                .sink { [weak self] _ in
                    self?.loadVideos()
                }
                .store(in: &subscriptions)
        }
    }
}
