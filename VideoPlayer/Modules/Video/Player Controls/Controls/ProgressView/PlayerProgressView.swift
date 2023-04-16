//
//  PlayerProgressView.swift
//  VideoPlayer
//
//  Created by Maxim Vynnyk on 08.04.2023.
//

import SwiftUI
import AVKit

struct PlayerProgressView: View {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        GeometryReader { geometry in
            Slider(value: $viewModel.currentTime, in: 0...viewModel.totalTime) {
                Text("Time")
            } minimumValueLabel: {
                Text(viewModel.currentTimeText)
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.6))
                    .monospaced()
            } maximumValueLabel: {
                Text(viewModel.totalTimeText)
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.6))
                    .monospaced()
            } onEditingChanged: { isEditing in
                viewModel.isEditing = isEditing
            }
            .tint(.white.opacity(0.6))
            .task {
                await viewModel.didDraw(with: geometry.size.width)
            }
        }
        .fixedSize(horizontal: false, vertical: true)
    }
}


struct PlayerProgressView_Previews: PreviewProvider {
    static let vm = PlayerProgressView.ViewModel(engine: .init(
        asset: PreviewHelper.videoModels[0].asset
    ))
    
    static var previews: some View {
        PlayerProgressView(viewModel: vm)
    }
}
