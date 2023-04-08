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
        VStack {
            Spacer()
            
            if !isPlaying {
                playButton
                    .frame(width: 100, height: 100)
            }
            
            Spacer()
            
            HStack {
                PlayerProgressView(player: player)

                if isPlaying {
                    playButton
                }
            }
            .frame(height: 30)
            .padding(.horizontal)
        }
    }
    
    var playButton: some View {
        PlayerPlayButton(isPlaying: isPlaying) {
            player.isPlaying
            ? player.pause()
            : player.play()
            
            withAnimation(.spring().speed(1.2)) {
                isPlaying = player.isPlaying
            }
        }
        .aspectRatio(1 / 1, contentMode: .fit)
        .transition(.scale.combined(with: .opacity))
    }
}

struct VideoPlayerControlsView_Previews: PreviewProvider {
    static var previews: some View {
        VideoPlayerControlsView(player: PreviewHelper.player)
    }
}
