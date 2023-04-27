//
//  EditVideoView.swift
//  VideoPlayerMV
//
//  Created by Maxim Vynnyk on 24.04.2023.
//

import SwiftUI
import CustomViews
import VideoPlayerModel
import PreviewKit

struct EditVideoView: View {
    @EnvironmentObject var imageImporter: MediaImportManager
    @State var video: VideoModel // State creates a copy of injected video
    @State private var image = Image("kp")
    var onSave: (VideoModel) -> Void
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Form {
                VideoImagePicker(
                    selection: $imageImporter.mediaSelection,
                    image: image
                )
                
                HStack {
                    Text("Title")
                        .font(.headline)
                    Divider()
                    TextField("Title", text: $video.title)
                }
            }
            .scrollBounceBehavior(.basedOnSize)
            
            Button {
                onSave(video)
            } label: {
                Text("Save")
                    .padding(.vertical)
                    .padding(.horizontal, 100)
            }
            .foregroundColor(Color(uiColor: .systemBackground))
            .background(Color.accentColor)
            .clipShape(Capsule(style: .continuous))
        }
        .onReceive(imageImporter.$importedMedia) { output in
            switch output {
            case let .image(uiImage, path):
                video.imageURL = path
                image = Image(uiImage: uiImage)
            case .video, .empty:
                image = Image(
                    uiImage: UIImage(
                        contentsOfFile: video.imageURL?.path() ?? ""
                    ) ?? UIImage(named: "kp")!
                )
            }
        }
        
    }
}

struct EditVideoView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            EditVideoView(video: Mockups.videoModels[0], onSave: { _ in })
                .environmentObject(VideoManager(version: .debug).importManager)
        }
    }
}
