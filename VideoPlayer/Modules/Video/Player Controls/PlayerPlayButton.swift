//
//  PlayerPlayButton.swift
//  VideoPlayer
//
//  Created by Maxim Vynnyk on 08.04.2023.
//

import SwiftUI
import AVKit

struct PlayerPlayButton: View {
    var isPlaying: Bool
    var onTap: () -> Void
    
    var body: some View {
        Button {
           onTap()
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

struct PlayerPlayButton_Previews: PreviewProvider {
    static var previews: some View {
        PlayerPlayButton(isPlaying: false) {
            
        }
    }
}
