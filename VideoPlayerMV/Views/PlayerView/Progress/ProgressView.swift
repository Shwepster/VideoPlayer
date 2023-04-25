//
//  ProgressView.swift
//  VideoPlayerMV
//
//  Created by Maxim Vynnyk on 25.04.2023.
//

import SwiftUI
import Model
import CustomViews

struct PlayerProgressView: View {
    @EnvironmentObject var engine: VideoPlayerEngine
    @State private var wasPlayingBeforeEdit = false

    var body: some View {
        GeometryReader { geometry in
            Slider(value: $engine.currentTime, in: 0...(engine.duration?.seconds ?? 0)) {
                Text("Time")
            } minimumValueLabel: {
                Text(engine.currentTime.toTimeString())
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.6))
                    .monospaced()
            } maximumValueLabel: {
                Text((engine.duration?.seconds ?? 0).toTimeString())
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.6))
                    .monospaced()
            } onEditingChanged: { isEditing in
                onEditChanged(isEditing)
            }
            .tint(.white.opacity(0.6))
            .task {
                engine.startTrackingProgress(forWidth: geometry.size.width)
            }
        }
        .fixedSize(horizontal: false, vertical: true)
        .onAppear {
            wasPlayingBeforeEdit = engine.isPlaying
        }
    }
    
    private func onEditChanged(_ isEditing: Bool) {
        if isEditing {
            wasPlayingBeforeEdit = engine.isPlaying
            engine.isPlaying = false
        } else {
            engine.isPlaying = wasPlayingBeforeEdit
        }
    }
}


struct PlayerProgressView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerProgressView()
    }
}
