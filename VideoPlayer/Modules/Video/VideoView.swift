//
//  VideoView.swift
//  VideoPlayer
//
//  Created by Maxim Vynnyk on 06.04.2023.
//

import SwiftUI
import AVKit

struct VideoView: View {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VideoPlayerView(
                player: viewModel.player.player,
                contentMode: viewModel.contentMode
            )
            
            WatermarkView(text: viewModel.title)
            
            VideoPlayerControlsView(viewModel: viewModel.controlsViewModel)
                .simultaneousGesture(zoomGesture)
        }
    }
    
    var zoomGesture: some Gesture {
        MagnificationGesture().onChanged { amount in
            withAnimation(.spring()) {
                viewModel.handleZoom(amount)
            }
        }
    }
}

struct VideoPlayerView_Previews: PreviewProvider {
    static var viewModel = VideoView.ViewModel(video: PreviewHelper.videoModels[0])
                                                
    static var previews: some View {
        VideoView(viewModel: viewModel)
    }
}

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
                .background(Color.black)
        }
    }
}
