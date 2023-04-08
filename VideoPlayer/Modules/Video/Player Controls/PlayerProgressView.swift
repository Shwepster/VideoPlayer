//
//  PlayerProgressView.swift
//  VideoPlayer
//
//  Created by Maxim Vynnyk on 08.04.2023.
//

import SwiftUI
import AVKit

struct PlayerProgressView: View {
    var player: AVPlayer
    private var totalTime: Double
    @State private var currentTime: Double
    @State private var observer: AnyObject?

    init(player: AVPlayer) {
        self.player = player
        self.currentTime = player.currentTime().seconds
        self.totalTime = player.currentItem?.asset.duration.seconds ?? 0
    }
    
    var body: some View {
        ProgressView(value: currentTime, total: totalTime)
            .progressViewStyle(.linear)
            .tint(.white)
            .background(
                GeometryReader { geometry in
                    Color.clear
                        .task {
                            let updateSeconds = 0.5 * totalTime / geometry.size.width
                            
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
            )
            .onDisappear {
                player.removeTimeObserver(observer as Any)
            }
    }
}


struct PlayerProgressView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerProgressView(player: .init())
    }
}
