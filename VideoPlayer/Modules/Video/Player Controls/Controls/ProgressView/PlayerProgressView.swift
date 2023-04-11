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
            .animation(.spring(), value: viewModel.currentTime)
        
//        Slider(value: $viewModel.currentTime, in: 0...100) {
//            Text("Time")
//        } minimumValueLabel: {
//            Text(viewModel.currentTime.description)
//        } maximumValueLabel: {
//            Text(viewModel.totalTime.description)
//        } onEditingChanged: { isEditing in
//            
//        }
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
