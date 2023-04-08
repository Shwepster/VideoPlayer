//
//  VideoPlayerViewModel.swift
//  VideoPlayer
//
//  Created by Maxim Vynnyk on 06.04.2023.
//

import Foundation
import AVKit

extension VideoPlayerView {
    @MainActor class ViewModel: ObservableObject {
        @Published var player: AVPlayer
        @Published var title: String
        private let video: VideoModel
        
        init(video: VideoModel) {
            self.video = video
            title = video.title
            
            let playerItem = AVPlayerItem(asset: video.asset)
            player = AVPlayer(playerItem: playerItem)
        }
    }
}
