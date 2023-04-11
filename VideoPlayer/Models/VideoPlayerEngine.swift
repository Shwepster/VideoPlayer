//
//  VideoPlayerEngine.swift
//  VideoPlayer
//
//  Created by Maxim Vynnyk on 11.04.2023.
//

import AVKit
import Combine

final class VideoPlayerEngine {
    var isPlaying = CurrentValueSubject<Bool, Never>(false)
    private(set) var player: AVPlayer

    private var playObserver: NSKeyValueObservation?
    private var subscriptions = Set<AnyCancellable>()
    private var didEnd = false
    
    init(asset: AVAsset) {
        let item = AVPlayerItem(asset: asset)
        player = AVPlayer(playerItem: item)
        player.actionAtItemEnd = .pause
        subscribeObservers()
    }
    
    deinit {
        playObserver?.invalidate()
    }
    
    func play() {
        if didEnd {
            player.seek(to: .zero)
            didEnd = false
        }
        
        player.play()
    }
    
    func pause() {
        player.pause()
    }
    
    func seek(to time: Double) {
        // TODO:
    }
    
    func seek(appendingSeconds: Double) {
        guard let currentTime = player.currentItem?.currentTime() else { return }
        
        let newTime = CMTime(
            seconds: currentTime.seconds + appendingSeconds,
            preferredTimescale: 600
        )
        
        player.seek(
            to: newTime,
            toleranceBefore: .zero,
            toleranceAfter: .zero
        )
    }
    
    private func subscribeObservers() {
        subscribeOnPlayChange()
        subscribeOnPlayEnd()
    }
    
    private func subscribeOnPlayChange() {
        playObserver = player.observe(\.rate, options: .new) { [weak self] player, value in
            Task { @MainActor [weak self] in
                guard player.error == nil else {
                    self?.isPlaying.send(false)
                    return
                }
                
                self?.isPlaying.send(value.newValue == 1)
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
                self?.didEnd = true
            }
            .store(in: &subscriptions)
    }
}
