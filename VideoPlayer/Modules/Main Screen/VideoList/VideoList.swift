//
//  VideoList.swift
//  VideoPlayer
//
//  Created by Maxim Vynnyk on 04.04.2023.
//

import SwiftUI

struct VideoList: View {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        ScrollView(.vertical) {
            LazyVGrid(columns: [.init(.flexible()), .init(.flexible())]) {
                ForEach(viewModel.videos) { video in
                    VideoItemView(video: video)
                        .aspectRatio(10/16, contentMode: .fit)
                        .onTapGesture {
                            viewModel.selectVideo(video)
                        }
                        .contextMenu {
                           contextMenu(for: video)
                        }
                }
            }
            .padding(.horizontal)
            .animation(.spring(), value: viewModel.videos)
            .tabViewStyle(.page)
        }
        .fullScreenCover(item: $viewModel.selectedVideo) {
            viewModel.deselectVideo()
        } content: { video in
            VideoView(viewModel: .init(video: video))
                .presentationBackground(.clear)
                .modifier(SwipeToDismissModifier {
                    viewModel.selectedVideo = nil
                })
        }
    }
    
    @ViewBuilder func contextMenu(for video: VideoModel) -> some View {
        Button(role: .destructive) {
            viewModel.deleteVideo(video)
        } label: {
            Label("Delete", systemImage: "trash")
        }
        
        Button {
            // TODO: Add edit
        } label: {
            Label("Edit", systemImage: "pencil")
        }
    }
}

struct VideoList_Previews: PreviewProvider {
    static let viewModel = VideoList.ViewModel()
    static var previews: some View {
        VideoList(viewModel: viewModel)
    }
}
