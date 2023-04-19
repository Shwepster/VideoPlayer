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
        @Published var editedVideo: VideoModel?
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
        
        func deleteVideo(_ video: VideoModel) {
            storageService.deleteVideo(video)
        }
        
        func editVideo(_ video: VideoModel) {
            editedVideo = video
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
                .debounce(for: 0.3, scheduler: RunLoop.current) // storage can update few times a second
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
