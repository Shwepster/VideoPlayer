//
//  VideoView.swift
//  VideoPlayer
//
//  Created by Maxim Vynnyk on 06.04.2023.
//

import SwiftUI
import CustomViews
import PreviewKit

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

struct VideoView_Previews: PreviewProvider {
    static var viewModel = VideoView.ViewModel(video: PreviewHelper.videoModels[0])
                                                
    static var previews: some View {
        VideoView(viewModel: viewModel)
    }
}
