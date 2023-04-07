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
    @State private var isPlaying = false
    
    var body: some View {
        playButton
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
                .opacity(isPlaying ? 0.5 : 0.8)
        }
        .tint(.white)
        .padding(4)
        .background(
            Color.black
                .opacity(0.4)
        )
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .scaleEffect(isPlaying ? 1 : 1.5)
        
    }
}

struct VideoPlayerControlsView_Previews: PreviewProvider {
    static var previews: some View {
        VideoPlayerControlsView(player: .init())
    }
}
