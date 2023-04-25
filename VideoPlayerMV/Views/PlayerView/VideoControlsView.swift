//
//  VideoControlsView.swift
//  VideoPlayerMV
//
//  Created by Maxim Vynnyk on 26.04.2023.
//

import SwiftUI
import AVKit
import CustomViews
import Model

struct VideoControlsView: View {
    @EnvironmentObject private var engine: VideoPlayerEngine
    @State private var isControlsShown = true
    private let seekTime = 5.0
    
    var body: some View {
        ZStack {
            PlayerSeekView {
                engine.seek(appendingSeconds: seekTime)
            } onSeekBack: {
                engine.seek(appendingSeconds: -seekTime)
            }
            .onTapGesture {
                isControlsShown.toggle()
            }
            
            Group {
                progressLayer
                playButton
            }
            .opacity(isControlsShown ? 1 : 0.01)
            .animation(.default.speed(1.5), value: isControlsShown)
        }
    }
    
    @ViewBuilder var playButton: some View {
        PlayerPlayButton(isPlaying: engine.isPlaying) {
            engine.isPlaying.toggle()
        }
        .frame(width: 80, height: 80)
        .animation(
            .spring().speed(1.5),
            value: engine.isPlaying
        )
    }
    
    @ViewBuilder var progressLayer: some View {
        VStack {
            Spacer()
            PlayerProgressView()
                .frame(height: 30)
                .padding(.horizontal)
                .padding(.bottom, 50)
        }
    }
}
