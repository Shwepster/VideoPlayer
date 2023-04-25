//
//  VideoList.swift
//  VideoPlayerMV
//
//  Created by Maxim Vynnyk on 24.04.2023.
//

import SwiftUI
import Model
import CustomViews

struct VideoList: View {
    @EnvironmentObject private var videoManager: VideoManager
    var onSelect: (VideoModel) -> Void = { _ in }
    var onDelete: (VideoModel) -> Void = { _ in }
    var onEdit:   (VideoModel) -> Void = { _ in }
    
    var body: some View {
        ScrollView(.vertical) {
            LazyVGrid(columns: [.init(.flexible()), .init(.flexible())]) {
                ForEach(videoManager.videos) { video in
                    VideoItemView(video: video)
                        .aspectRatio(10/16, contentMode: .fit)
                        .onTapGesture {
                            onSelect(video)
                        }
                        .contextMenu {
                            contextMenu(for: video)
                        }
                }
            }
            .padding(.horizontal)
            .animation(.spring(), value: videoManager.videos)
        }
        .task {
            await videoManager.loadVideos()
        }
    }
    
    @ViewBuilder private func contextMenu(for video: VideoModel) -> some View {
        Button {
            onEdit(video)
        } label: {
            Label("Edit", systemImage: "pencil")
        }

        Button(role: .destructive) {
            onDelete(video)
        } label: {
            Label("Delete", systemImage: "trash")
        }
    }
}

struct VideoList_Previews: PreviewProvider {
    static var previews: some View {
        VideoList()
            .environmentObject(VideoManager(version: .debug))
    }
}
