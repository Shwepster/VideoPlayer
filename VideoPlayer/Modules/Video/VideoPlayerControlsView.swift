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
    @State private var buttonDegree: Double = 0
    
    var body: some View {
        playButton
    }
    
    var playButton: some View {
        Button {
            player.isPlaying
            ? player.pause()
            : player.play()

            withAnimation(.easeInOut(duration: 0.2)) {
                buttonDegree = player.isPlaying ? 180 : 0
            }
        } label: {
            Image(systemName: player.isPlaying ? "pause.circle" : "play.circle")
                .imageScale(.large)
        }
        .rotation3DEffect(.init(degrees: buttonDegree), axis: (x: 0, y: 1, z: 0))
    }
}

struct VideoPlayerControlsView_Previews: PreviewProvider {
    static var previews: some View {
        VideoPlayerControlsView(player: .init())
    }
}
