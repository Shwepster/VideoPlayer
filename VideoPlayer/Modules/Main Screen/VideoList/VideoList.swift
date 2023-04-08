//
//  VideoList.swift
//  VideoPlayer
//
//  Created by Maxim Vynnyk on 04.04.2023.
//

import SwiftUI

struct VideoList: View {
    @ObservedObject var viewModel: ViewModel
    
    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        TabView {
            ForEach(viewModel.videos) { video in
                VideoItemView(video: video)
                    .aspectRatio(1 / 1.8, contentMode: .fit)
                    .onTapGesture {
                        viewModel.selectVideo(video)
                    }
                    .padding(30)
            }
        }
        .tabViewStyle(.page)
        .sheet(item: $viewModel.selectedVideo) {
            viewModel.deselectVideo()
        } content: { video in
            VideoPlayerView(viewModel: .init(video: video))
        }
    }
}

struct VideoList_Previews: PreviewProvider {
    static let viewModel = VideoList.ViewModel()
    static var previews: some View {
        VideoList(viewModel: viewModel)
    }
}
