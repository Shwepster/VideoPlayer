//
//  PlayerProgressViewModel.swift
//  VideoPlayer
//
//  Created by Maxim Vynnyk on 08.04.2023.
//

import AVKit
import Combine

extension PlayerProgressView {
    @MainActor class ViewModel: ObservableObject {
        @Published var currentTime: Double
        @Published var totalTime: Double = 0
        private var observer: AnyObject?
        private var player: AVPlayer
        private let updateFrequency = 0.5
        
        init(player: AVPlayer) {
            self.player = player
            self.currentTime = player.currentTime().seconds
        }
        
        deinit {
            player.removeTimeObserver(observer as Any)
            NSLog("ProgressView.VM deinit")
        }
        
        func didDraw(with width: CGFloat) async {
            guard let duration = (try? await player.currentItem?.asset.load(.duration)) else { return }
            
            totalTime = duration.seconds
            let updateSeconds = updateFrequency * totalTime / width
            let updateTime = CMTime(seconds: updateSeconds, preferredTimescale: duration.timescale)
            
            observer = player.addPeriodicTimeObserver(
                forInterval: updateTime,
                queue: .main
            ) { [weak self] time in
                self?.currentTime = time.seconds
            } as AnyObject
        }
    }
}
