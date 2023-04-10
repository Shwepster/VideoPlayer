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
                    .aspectRatio(1 / 1.75, contentMode: .fit)
                    .onTapGesture {
                        viewModel.selectVideo(video)
                    }
                    .contextMenu {
                        Button(role: .destructive) {
                            viewModel.deleteVideo(video)
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    }
                    .padding(.horizontal, 30)
                    .padding(.bottom, 50)
            }
        }
        .tabViewStyle(.page)
        .fullScreenCover(item: $viewModel.selectedVideo) {
            viewModel.deselectVideo()
        } content: { video in
            VideoPlayerView(viewModel: .init(video: video))
                .presentationBackground(.clear)
                .modifier(SwipeToDismissModifier {
                    viewModel.selectedVideo = nil
                })
        }
    }
}

struct VideoList_Previews: PreviewProvider {
    static let viewModel = VideoList.ViewModel()
    static var previews: some View {
        VideoList(viewModel: viewModel)
    }
}
