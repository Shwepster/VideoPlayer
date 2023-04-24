//
//  PlayerControlsViewModel.swift
//  VideoPlayer
//
//  Created by Maxim Vynnyk on 08.04.2023.
//

import Combine
import AVKit
import Model

extension VideoPlayerControlsView {
    @MainActor class ViewModel: ObservableObject {
        @Published var isControlsShown = true
        @Published var isPlaying = false
        let progressViewModel: PlayerProgressView.ViewModel
        private(set) var player: VideoPlayerEngine
        private let seekSeconds = 5.0
        
        init(player: VideoPlayerEngine) {
            self.player = player
            progressViewModel = .init(engine: player)
            subscribe()
        }
        
        deinit {
            NSLog("PlayerControls.VM deinit")
        }
        
        // MARK: - Actions
        
        func togglePlay() {
            isPlaying
            ? player.pause()
            : player.play()
        }
        
        func seekForward() {
            player.seek(appendingSeconds: seekSeconds)
        }
        
        func seekBack() {
            player.seek(appendingSeconds: -seekSeconds)
        }
        
        // MARK: - Private
        
        private func subscribe() {
            player.isPlaying.assign(to: &$isPlaying)
        }
    }
}
