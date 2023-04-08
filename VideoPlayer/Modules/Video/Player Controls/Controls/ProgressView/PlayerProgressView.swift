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
        ProgressView(value: viewModel.currentTime, total: viewModel.totalTime)
            .progressViewStyle(.linear)
            .tint(.white.opacity(0.5))
            .background(
                GeometryReader { geometry in
                    Color.clear
                        .task {
                            await viewModel.didDraw(with: geometry.size.width)
                        }
                }
            )
    }
}


struct PlayerProgressView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerProgressView(viewModel: .init(player: PreviewHelper.player))
    }
}
