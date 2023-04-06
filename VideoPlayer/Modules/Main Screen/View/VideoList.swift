//
//  VideoList.swift
//  VideoPlayer
//
//  Created by Maxim Vynnyk on 04.04.2023.
//

import SwiftUI

struct VideoList: View {
    var videos: [VideoModel]
    @State private var selectedVideo: VideoModel?
    
    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                Divider()
                
                LazyVGrid(columns: columns, spacing: 4) {
                    ForEach(videos) { video in
                        image(for: video)
                            .resizable()
                            .scaledToFill()
                            .frame(
                                width: geometry.size.width / 2,
                                height: geometry.size.width / 2 / 1.4
                            )
                            .clipped()
                            .onTapGesture {
                                selectedVideo = video
                            }
                    }
                }
            }
        }
        .fullScreenCover(item: $selectedVideo) {
            selectedVideo = nil
        } content: { video in
            VideoPlayerView(viewModel: .init(video: video))
        }
    }
    
    private var placeholderImage: Image {
        Image(systemName: "star")
    }

    func image(for video: VideoModel) -> Image {
        return video.image == nil
        ? placeholderImage
        : Image(uiImage: video.image!)
    }
}

struct VideoList_Previews: PreviewProvider {
    static var previews: some View {
        VideoList(videos: [.testModel])
    }
}
