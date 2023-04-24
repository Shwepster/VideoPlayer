//
//  VideoPlayerEngine.swift
//  VideoPlayer
//
//  Created by Maxim Vynnyk on 11.04.2023.
//

import AVKit
import Combine

public final class VideoPlayerEngine {
    public var isPlaying = CurrentValueSubject<Bool, Never>(false)
    public var duration = CurrentValueSubject<CMTime?, Never>(nil)
    public var currentTime: Double {
        player.currentTime().seconds
    }
    
    private(set) public var player: AVPlayer
    private var playObserver: NSKeyValueObservation?
    private var subscriptions = Set<AnyCancellable>()
    private var didEnd = false
    
    public init(asset: AVAsset) {
        let item = AVPlayerItem(asset: asset)
        player = AVPlayer(playerItem: item)
        player.actionAtItemEnd = .pause
        subscribeObservers()
        loadDuration()
    }
    
    deinit {
        playObserver?.invalidate()
    }
    
    public func play() {
        if didEnd {
            player.seek(to: .zero)
            didEnd = false
        }
        
        player.play()
    }
    
    public func pause() {
        player.pause()
    }
    
    public func seek(to time: Double) {
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
    
    public func seek(appendingSeconds: Double) {
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
    
    public func subscribeOnProgress(
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
                self?.isPlaying.send(player.isPlaying)
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
