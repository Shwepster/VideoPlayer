//
//  VideoView.swift
//  VideoPlayerMV
//
//  Created by Maxim Vynnyk on 25.04.2023.
//

import SwiftUI
import CustomViews
import Model
import PreviewKit

struct VideoView: View {
    let video: VideoModel
    @EnvironmentObject var engine: VideoPlayerEngine
    @State private var contentMode: ContentMode = .fill
    private let seekTime: Double = 5

    var body: some View {
        ZStack(alignment: .bottom) {
            VideoPlayerView(
                player: engine.player,
                contentMode: contentMode
            )
            
            WatermarkView(text: video.title)
            
            VideoControlsView(
                onSeekForward: {
                    engine.seek(appendingSeconds: seekTime)
                }, onSeekBack: {
                    engine.seek(appendingSeconds: -seekTime)
                }, isPlaying: $engine.isPlaying
            )
            .simultaneousGesture(zoomGesture)
        }
    }
    
    var zoomGesture: some Gesture {
        MagnificationGesture().onChanged { amount in
            withAnimation(.spring()) {
                if amount >= 1.5 {
                    contentMode = .fill
                }
                
                if amount <= 0.75 {
                    contentMode = .fit
                }
            }
        }
    }
}

struct VideoView_Previews: PreviewProvider {
    static var previews: some View {
        VideoView(video: PreviewHelper.videoModels[0])
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
            .environmentObject(VideoPlayerEngine(
                asset: PreviewHelper.videoModels[0].asset
            ))
    }
}
