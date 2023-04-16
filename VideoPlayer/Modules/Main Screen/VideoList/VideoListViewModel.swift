//
//  VideoListViewModel.swift
//  VideoPlayer
//
//  Created by Maxim Vynnyk on 07.04.2023.
//

import Combine
import Foundation
import SwiftUI

extension VideoList {
    @MainActor class ViewModel: ObservableObject {
        @Published private(set) var videos: [VideoModel] = []
        @Published var selectedVideo: VideoModel?
        @AppStorage("selectedVideoId") var selectedVideoId: String?
        
        private let storageService: StorageService
        private var subscriptions = Set<AnyCancellable>()

        init(storageService: StorageService = .shared) {
            self.selectedVideo = nil
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
//            videos = PreviewHelper.videoModels
            videos = storageService.getVideos().reversed()
            
            if selectedVideo == nil, let selectedVideoId {
                selectedVideo = videos.first { video in
                    video.id == selectedVideoId
                }
            }
        }
        
        private func setupObservers() {
            storageService.updatesPublisher
                .receive(on: DispatchQueue.main)
                .sink { [weak self] _ in
                    self?.loadVideos()
                }
                .store(in: &subscriptions)
            
            $selectedVideo
                .map(\.?.id)
                .sink { [weak self] id in
                    self?.selectedVideoId = id
                }
                .store(in: &subscriptions)
        }
    }
}
