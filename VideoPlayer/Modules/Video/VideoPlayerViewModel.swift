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
        let controlsViewModel: VideoPlayerControlsView.ViewModel
        
        init(video: VideoModel) {
            self.video = video
            self.title = video.title
            
            let playerItem = AVPlayerItem(asset: video.asset)
            let player = AVPlayer(playerItem: playerItem)
            self.player = player
            self.controlsViewModel = .init(player: player)
        }
        
        deinit {
            NSLog("VideoPlayerView.VM deinit")
        }
    }
}
