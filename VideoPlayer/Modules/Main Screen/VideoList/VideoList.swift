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
        .fullScreenCover(item: $viewModel.selectedVideo) { video in
            VideoView(viewModel: .init(video: video))
                .presentationBackground(.clear)
                .modifier(SwipeToDismissModifier {
                    viewModel.selectedVideo = nil
                })
        }
        .sheet(item: $viewModel.editedVideo) { video in
            EditVideoView(viewModel: .init(
                video: video,
                mediaImporter: AppServices.createMediaImporter()
            ))
            .presentationDetents([.fraction(0.7)])
            .presentationDragIndicator(.visible)
            .presentationContentInteraction(.resizes)
        }
    }
    
    @ViewBuilder func contextMenu(for video: VideoModel) -> some View {
        Button {
            viewModel.editVideo(video)
        } label: {
            Label("Edit", systemImage: "pencil")
        }

        Button(role: .destructive) {
            viewModel.deleteVideo(video)
        } label: {
            Label("Delete", systemImage: "trash")
        }
    }
}

struct VideoList_Previews: PreviewProvider {
    static let viewModel = VideoList.ViewModel()
    static var previews: some View {
        VideoList(viewModel: viewModel)
    }
}
