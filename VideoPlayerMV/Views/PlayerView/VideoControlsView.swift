//
//  VideoControlsView.swift
//  VideoPlayerMV
//
//  Created by Maxim Vynnyk on 26.04.2023.
//

import SwiftUI
import CustomViews
import VideoPlayerModel

struct VideoControlsView: View {
    var onSeekForward: () -> Void = {}
    var onSeekBack: () -> Void = {}
    @Binding var isPlaying: Bool
    @State private var isControlsShown = true
        
    var body: some View {
        ZStack {
            PlayerSeekView(
                onSeekForward: onSeekForward,
                onSeekBack: onSeekBack
            )
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
        PlayerPlayButton(isPlaying: isPlaying) {
            isPlaying.toggle()
        }
        .frame(width: 80, height: 80)
        .animation(
            .spring().speed(1.5),
            value: isPlaying
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

struct Previews_VideoControlsView_Previews: PreviewProvider {
    struct TestView: View {
        @State private var isPlaying = false
        var body: some View {
            VideoControlsView(isPlaying: $isPlaying)
                .environmentObject(Mockups.engine)
        }
    }
    
    static var previews: some View {
        TestView()
    }
}
