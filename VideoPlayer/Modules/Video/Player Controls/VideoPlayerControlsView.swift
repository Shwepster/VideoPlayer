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
            
            playButton
                .scaleEffect(isPlaying ? 0 : 2)
                .opacity(isPlaying ? 0 : 1)
            
            Spacer()
            
            HStack {
                PlayerProgressView(player: player)
                    .padding(.leading)

                playButton
                    .padding(.trailing)
                    .frame(width: isPlaying ? nil : 0)
                    .scaleEffect(isPlaying ? 1 : 0)
            }
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
    }
}

struct VideoPlayerControlsView_Previews: PreviewProvider {
    static var previews: some View {
        VideoPlayerControlsView(player: .init())
    }
}
