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
        private(set) var totalTime: Double
        private var observer: AnyObject?
        private var player: AVPlayer
        private let updateFrequency = 0.5
        
        init(player: AVPlayer) {
            self.player = player
            self.currentTime = player.currentTime().seconds
            self.totalTime = player.currentItem?.asset.duration.seconds ?? 0
        }
        
        deinit {
            player.removeTimeObserver(observer as Any)
        }
        
        func didDraw(with width: CGFloat) async {
            let updateSeconds = updateFrequency * totalTime / width
            
            let timeScale = CMTimeScale(NSEC_PER_SEC)
            let updateTime = CMTime(seconds: updateSeconds, preferredTimescale: timeScale)
            
            observer = player.addPeriodicTimeObserver(
                forInterval: updateTime,
                queue: .main
            ) { [self] time in
                self.currentTime = time.seconds
            } as AnyObject
        }
    }
}
