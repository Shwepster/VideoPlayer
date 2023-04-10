//
//  VideoPlayerViewModel.swift
//  VideoPlayer
//
//  Created by Maxim Vynnyk on 06.04.2023.
//

import SwiftUI
import AVKit

extension VideoPlayerView {
    @MainActor class ViewModel: ObservableObject {
        @Published var player: AVPlayer
        @Published var title: String
        @Published var contentMode: ContentMode = .fill
        
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
        
        func handleZoom(_ value: CGFloat) {
            if value >= 1.5 {
                contentMode = .fill
            }
            
            if value <= 0.75 {
                contentMode = .fit
            }
        }
    }
}
