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
            .onTapGesture {
                withAnimation {
                    viewModel.isControlsShown.toggle()
                }
            }
            
            Group {
                VStack {
                    Spacer()
                    HStack {
                        PlayerProgressView(viewModel: viewModel.progressViewModel)
                    }
                    .frame(height: 30)
                    .padding(.horizontal)
                }
                
                playButton
                    .frame(width: 80, height: 80)
            }
            .opacity(viewModel.isControlsShown ? 1 : 0.01)
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
