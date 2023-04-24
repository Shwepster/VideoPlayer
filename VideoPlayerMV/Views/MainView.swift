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
    @EnvironmentObject var videoImporter: VideoImportManager
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
                if videoImporter.importState == .idle {
                    VideoPicker(videoSelection: $videoImporter.videoSelection)
                        .padding()
                } else {
                    ProgressView()
                        .padding()
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    @StateObject static var videoManager = VideoManager(version: .debug)

    static var previews: some View {
        MainView()
            .environmentObject(Self.videoManager)
            .environmentObject(Self.videoManager.importManager)
    }
}
