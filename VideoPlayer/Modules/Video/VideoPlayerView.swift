//
//  VideoPlayerView.swift
//  VideoPlayer
//
//  Created by Maxim Vynnyk on 06.04.2023.
//

import SwiftUI
import AVKit

struct VideoPlayerView: View {
    @StateObject var viewModel: ViewModel
    @State private var contentMode: ContentMode = .fill
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VideoPlayer(player: viewModel.player) {
                WatermarkView()
            }
            .ignoresSafeArea()
            .disabled(true)
            
            VideoPlayerControlsView(player: viewModel.player)
        }
    }
}

struct VideoPlayerView_Previews: PreviewProvider {
    static var viewModel = VideoPlayerView.ViewModel(video: .testModel)
                                                
    static var previews: some View {
        VideoPlayerView(viewModel: viewModel)
    }
}
