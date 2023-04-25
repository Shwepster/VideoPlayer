//
//  VideoPlayerView.swift
//  VideoPlayerMV
//
//  Created by Maxim Vynnyk on 25.04.2023.
//

import SwiftUI
import AVKit

struct VideoPlayerView: View {
    let player: AVPlayer
    let contentMode: ContentMode
    
    var body: some View {
        GeometryReader { geometry in
            VideoPlayer(player: player)
                .ignoresSafeArea()
                .disabled(true)
                .aspectRatio(contentMode: contentMode)
                .frame(
                    width: geometry.size.width,
                    height: geometry.size.height
                )
        }
        .background(Color.black)
        .clipped()
    }
}

struct VideoPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        VideoPlayerView(player: PreviewHelper.player, contentMode: .fill)
    }
}
