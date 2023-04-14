//
//  PlayerPlayButton.swift
//  VideoPlayer
//
//  Created by Maxim Vynnyk on 08.04.2023.
//

import SwiftUI
import AVKit

struct PlayerPlayButton: View {
    let isPlaying: Bool
    let onTap: () -> Void
    
    var body: some View {
        GeometryReader { geometry in
            Button {
                onTap()
            } label: {
                Image(systemName: isPlaying ? "pause.circle" : "play.circle")
                    .resizable()
                    .opacity(isPlaying ? 0.4 : 0.6)
            }
            .tint(.white)
            .padding(geometry.size.width / 8)
            .background(
                Color.black
                    .opacity(0.4)
            )
            .clipShape(RoundedRectangle(cornerRadius: geometry.size.width / 4))
            .scaleEffect(isPlaying ? 0.8 : 1)
        }
    }
}

struct PlayerPlayButton_Previews: PreviewProvider {
    static var previews: some View {
        PlayerPlayButton(isPlaying: false) {}
            .frame(width: 100, height: 100)
    }
}
