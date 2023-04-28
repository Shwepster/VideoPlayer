//
//  VideoPlayerViewModel.swift
//  VideoPlayer
//
//  Created by Maxim Vynnyk on 06.04.2023.
//

import SwiftUI
import Model

extension VideoView {
    @MainActor class ViewModel: ObservableObject {
        @Published var title: String
        @Published var contentMode: ContentMode = .fill
        private(set) var player: VideoPlayerEngine
        let controlsViewModel: VideoPlayerControlsView.ViewModel
        
        init(video: VideoModel) {
            self.title = video.title
            self.player = VideoPlayerEngine(asset: video.asset)
            self.controlsViewModel = .init(player: player)
        }
        
        deinit {
            NSLog("VideoView.VM deinit")
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
