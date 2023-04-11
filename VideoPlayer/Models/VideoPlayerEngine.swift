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
    var duration = CurrentValueSubject<CMTime?, Never>(nil)
    var currentTime: Double {
        player.currentTime().seconds
    }
    
    private(set) var player: AVPlayer
    private var playObserver: NSKeyValueObservation?
    private var subscriptions = Set<AnyCancellable>()
    private var didEnd = false
    
    init(asset: AVAsset) {
        let item = AVPlayerItem(asset: asset)
        player = AVPlayer(playerItem: item)
        player.actionAtItemEnd = .pause
        subscribeObservers()
        loadDuration()
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
        let newTime = CMTime(
            seconds: time,
            preferredTimescale: duration.value?.timescale ?? 600
        )
        
        player.seek(
            to: newTime,
            toleranceBefore: .zero,
            toleranceAfter: .zero
        )
    }
    
    func seek(appendingSeconds: Double) {
        let newTime = CMTime(
            seconds: currentTime + appendingSeconds,
            preferredTimescale: duration.value?.timescale ?? 600
        )
        
        player.seek(
            to: newTime,
            toleranceBefore: .zero,
            toleranceAfter: .zero
        )
    }
    
    func subscribeOnProgress(
        forWidth width: CGFloat,
        updateFrequency: Double = 0.5
    ) -> AnyPublisher<Double, Never> {
        duration
            .compactMap { $0 }
            .map { time in
                let updateSeconds = updateFrequency * time.seconds / width
                return CMTime(seconds: updateSeconds, preferredTimescale: time.timescale)
            }
            .flatMap { [weak self] time in
                self.publisher
                    .flatMap { engine in
                        engine.player.periodicTimePublisher(forInterval: time)
                    }
            }
            .map(\.seconds)
            .eraseToAnyPublisher()
    }
    
    // MARK: - Private

    private func loadDuration() {
        Task { [weak self] in
            let duration = try? await self?.player.currentItem?.asset.load(.duration)
            self?.duration.send(duration)
        }
    }
    
    private func subscribeObservers() {
        subscribeOnPlayChange()
        subscribeOnPlayEnd()
    }
    
    private func subscribeOnPlayChange() {
        playObserver = player.observe(\.rate, options: [.initial, .new]) { [weak self] player, value in
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
