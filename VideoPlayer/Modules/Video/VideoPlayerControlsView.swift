//
//  VideoPlayerControlsView.swift
//  VideoPlayer
//
//  Created by Maxim Vynnyk on 06.04.2023.
//

import SwiftUI
import AVKit

struct VideoPlayerControlsView: View {
    var player: AVPlayer
    @State private var isPlaying: Bool = false
    
    var body: some View {
        HStack {
            PlayerProgressView(player: player)
                .padding(.leading)

            playButton
                .padding(.trailing)
        }
    }
    
    var playButton: some View {
        Button {
            player.isPlaying
            ? player.pause()
            : player.play()

            withAnimation(.spring().speed(1.2)) {
                isPlaying = player.isPlaying
            }
        } label: {
            Image(systemName: isPlaying ? "pause.circle" : "play.circle")
                .imageScale(.large)
                .frame(width: 25, height: 25)
                .opacity(isPlaying ? 0.5 : 0.8)
        }
        .tint(.white)
        .padding(4)
        .background(
            Color.black
                .opacity(0.4)
        )
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .scaleEffect(isPlaying ? 0.8 : 1)
        
    }
}

struct VideoPlayerControlsView_Previews: PreviewProvider {
    static var previews: some View {
        VideoPlayerControlsView(player: .init())
    }
}

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
