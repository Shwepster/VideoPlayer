//
//  PlayerControlsViewModel.swift
//  VideoPlayer
//
//  Created by Maxim Vynnyk on 08.04.2023.
//

import Combine
import AVKit

extension VideoPlayerControlsView {
    @MainActor class ViewModel: ObservableObject {
        @Published var isPlaying: Bool
        private(set) var player: AVPlayer
        private var playObserver: NSKeyValueObservation?
        private var subscriptions = Set<AnyCancellable>()
        
        var progressViewModel: PlayerProgressView.ViewModel
        
        init(player: AVPlayer) {
            self.player = player
            self.isPlaying = player.isPlaying
            progressViewModel = .init(player: player)
            player.actionAtItemEnd = .pause
            subscribeObservers()
        }
        
        deinit {
            playObserver?.invalidate()
            NSLog("PlayerControls.VM deinit")
        }
        
        // MARK: - Actions
        
        func togglePlay() {
            player.isPlaying
            ? player.pause()
            : player.play()
            
            isPlaying = player.isPlaying
        }
        
        // MARK: - Subscriptions
        
        private func subscribeObservers() {
            subscribeOnPlayChange()
            subscribeOnPlayEnd()
        }
        
        private func subscribeOnPlayChange() {
            playObserver = player.observe(\.rate, options: .new) { [weak self] player, value in
                Task { @MainActor [weak self] in
                    guard player.error == nil else {
                        self?.isPlaying = false
                        return
                    }
                    
                    // 0 to x is Play
                    if value.oldValue == 0, value.newValue != 0 {
                        self?.isPlaying = true
                    }
                    
                    // x to 0 is Pause
                    if value.oldValue != 0, value.newValue == 0 {
                        self?.isPlaying = false
                    }
                }
            }
        }
        
        private func subscribeOnPlayEnd() {
            NotificationCenter.default
                .publisher(
                    for: .AVPlayerItemDidPlayToEndTime,
                    object: player.currentItem
                )
                .sink { [weak self] _ in
                    self?.player.seek(to: .zero)
                }
                .store(in: &subscriptions)
        }
    }
}
