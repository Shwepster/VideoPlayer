//
//  VideoView.swift
//  VideoPlayerMV
//
//  Created by Maxim Vynnyk on 25.04.2023.
//

import SwiftUI
import CustomViews
import Model

struct VideoView: View {
    let video: VideoModel
    @EnvironmentObject var engine: VideoPlayerEngine
    @State private var contentMode: ContentMode = .fill

    var body: some View {
        ZStack(alignment: .bottom) {
            VideoPlayerView(
                player: engine.player,
                contentMode: contentMode
            )
            
            WatermarkView(text: video.title)
            
            VideoControlsView()
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
            .environmentObject(VideoPlayerEngine(
                asset: PreviewHelper.videoModels[0].asset
            ))
    }
}
