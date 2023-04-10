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
        ZStack {
            PlayerSeekView {
                viewModel.seekForward()
            } onSeekBack: {
                viewModel.seekBack()
            }
            
            VStack {
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
            
            if !viewModel.isPlaying {
                playButton
                    .frame(width: 100, height: 100)
            }
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
