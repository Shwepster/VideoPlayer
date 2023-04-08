//
//  VideoPlayerControlsView.swift
//  VideoPlayer
//
//  Created by Maxim Vynnyk on 06.04.2023.
//

import SwiftUI
import AVKit

struct VideoPlayerControlsView: View {
    @ObservedObject var viewModel: ViewModel

    var body: some View {
        VStack {
            Spacer()

            if !viewModel.isPlaying {
                playButton
                    .frame(width: 100, height: 100)
            }
            
            Spacer()
            
            HStack {
                PlayerProgressView(viewModel: viewModel.progressViewModel)

                if viewModel.isPlaying {
                    playButton
                }
            }
            .frame(height: 30)
            .padding(.horizontal)
        }
    }
    
    var playButton: some View {
        PlayerPlayButton(isPlaying: viewModel.isPlaying) {
            withAnimation(.spring().speed(1.2)) {
                viewModel.togglePlay()
            }
        }
        .aspectRatio(1 / 1, contentMode: .fit)
        .transition(.scale.combined(with: .opacity))
    }
}

struct VideoPlayerControlsView_Previews: PreviewProvider {
    static var previews: some View {
        VideoPlayerControlsView(viewModel: .init(player: PreviewHelper.player))
    }
}
