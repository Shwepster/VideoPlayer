//
//  ContentView.swift
//  VideoPlayerMV
//
//  Created by Maxim Vynnyk on 24.04.2023.
//

import SwiftUI
import CustomViews
import Model

struct MainView: View {
    @EnvironmentObject var videoManager: VideoManager
    @State private var editedVideo: VideoModel? = nil
    @State private var selectedVideo: VideoModel? = nil
    
    var body: some View {
        NavigationStack { 
            VideoList { video in
                selectedVideo = video
            } onDelete: { video in
                videoManager.deleteVideo(video)
            } onEdit: { video in
                editedVideo = video
            }
            .navigationTitle("Your Videos")
            .toolbar {
                if videoManager.importManager.importState == .idle {
                    VideoPicker(videoSelection: $videoManager.importManager.mediaSelection)
                        .padding()
                } else {
                    ProgressView()
                        .padding()
                }
            }
            .sheet(item: $editedVideo) { video in
                EditVideoView(video: video) { updatedVideo in
                    videoManager.saveVideo(updatedVideo)
                    editedVideo = nil
                }
                .presentationDetents([.fraction(0.7)])
                .presentationDragIndicator(.visible)
                .presentationContentInteraction(.resizes)
                .environmentObject(MediaImportManager(
                    mediaImporter: AppServices.createImageImporter()
                ))
            }
            .fullScreenCover(item: $selectedVideo) { video in
                VideoView(video: video)
                    .presentationBackground(.clear)
                    .modifier(SwipeToDismissModifier {
                        selectedVideo = nil
                    })
                    .environmentObject(VideoPlayerEngine(asset: video.asset))
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    @StateObject static var videoManager = VideoManager(version: .debug)

    static var previews: some View {
        MainView()
            .environmentObject(Self.videoManager)
    }
}
