//
//  VideoImportListView.swift
//  VideoPlayerMV
//
//  Created by Maxim Vynnyk on 26.04.2023.
//

import SwiftUI
import PhotosUI
import VideoPlayerViews
import VideoPlayerModel

struct VideoImportListView: View {
    @EnvironmentObject var videoImportService: MediaImportService
    
    var body: some View {
        Form {
            ForEach(
                videoImportService.runningImports.sorted(by: {
                    $0.key > $1.key
                }),
                id: \.key
            ) { item in
                LinearProgressView()
                    .padding(.vertical)
            }
            
            VideoPicker(videoSelection: $videoImportService.mediaSelection, maxCount: 10)
        }
        .animation(.spring(), value: videoImportService.runningImports.count)
    }
}

struct VideoImportListView_Previews: PreviewProvider {
    static var previews: some View {
        VideoImportListView()
            .environmentObject(MediaImportService(
                mediaImporter: AppServices.createVideoImporter()
            ))
    }
}
