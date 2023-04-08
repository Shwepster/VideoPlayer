//
//  VideoPlayerView.swift
//  VideoPlayer
//
//  Created by Maxim Vynnyk on 06.04.2023.
//

import SwiftUI
import AVKit

struct VideoPlayerView: View {
    @ObservedObject var viewModel: ViewModel
    @State private var contentMode: ContentMode = .fill
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottom) {
                VideoPlayer(player: viewModel.player)
                .ignoresSafeArea()
                .disabled(true)
                .aspectRatio(contentMode: contentMode)
                .frame(
                    width: geometry.size.width,
                    height: geometry.size.height
                )
                
                WatermarkView(text: viewModel.title)
                
                VideoPlayerControlsView(viewModel: viewModel.controlsViewModel)
            }
        }
    }
}

struct VideoPlayerView_Previews: PreviewProvider {
    static var viewModel = VideoPlayerView.ViewModel(video: PreviewHelper.videoModels[0])
                                                
    static var previews: some View {
        VideoPlayerView(viewModel: viewModel)
    }
}
