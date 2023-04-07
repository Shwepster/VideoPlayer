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
        GeometryReader { geometry in
            ScrollView {
                Divider()
                
                LazyVGrid(columns: columns, spacing: 4) {
                    ForEach(viewModel.videos) { video in
                        image(for: video)
                            .resizable()
                            .scaledToFill()
                            .frame(
                                width: geometry.size.width / 2,
                                height: geometry.size.width / 2 / 1.4
                            )
                            .clipped()
                            .onTapGesture {
                                viewModel.selectVideo(video)
                            }
                    }
                }
            }
        }
        .sheet(item: $viewModel.selectedVideo) {
            viewModel.deselectVideo()
        } content: { video in
            VideoPlayerView(viewModel: .init(video: video))
        }
    }
    
    @ViewBuilder private var placeholderImage: Image {
        Image(systemName: "star")
    }

    @ViewBuilder func image(for video: VideoModel) -> Image {
        video.image == nil
        ? placeholderImage
        : Image(uiImage: video.image!)
    }
}

struct VideoList_Previews: PreviewProvider {
    static let viewModel = VideoList.ViewModel()
    static var previews: some View {
        VideoList(viewModel: viewModel)
    }
}
