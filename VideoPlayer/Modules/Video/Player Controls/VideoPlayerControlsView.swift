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
                viewModel.isControlsShown.toggle()
            }
            
            Group {
                VStack {
                    Spacer()
                    PlayerProgressView(viewModel: viewModel.progressViewModel)
                        .frame(height: 30)
                        .padding([.horizontal, .bottom])
                }
                
                playButton
                    .frame(width: 80, height: 80)
            }
            .opacity(viewModel.isControlsShown ? 1 : 0.01)
            .animation(.default.speed(1.5), value: viewModel.isControlsShown)
        }
    }
    
    var playButton: some View {
        PlayerPlayButton(isPlaying: viewModel.isPlaying) {
            viewModel.togglePlay()
        }
        .aspectRatio(1 / 1, contentMode: .fit)
        .animation(.spring().speed(1.5), value: viewModel.isPlaying)
    }
}
