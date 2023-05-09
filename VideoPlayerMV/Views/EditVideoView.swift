//
//  EditVideoView.swift
//  VideoPlayerMV
//
//  Created by Maxim Vynnyk on 24.04.2023.
//

import SwiftUI
import VideoPlayerViews
import VideoPlayerModel

struct EditVideoView: View {
    @EnvironmentObject var imageImporter: MediaImportManager
    @State var video: VideoModel // State creates a copy of injected video
    @State private var image = Image(systemName: "scribble.variable")
    @FocusState private var textFieldIsFocused: Bool
    var onSave: (VideoModel) -> Void
    
    var body: some View {
        Form {
            HStack {
                Spacer()
                Button {
                    onSave(video)
                } label: {
                    Text("Save")
                        .bold()
                        .disabled(imageImporter.importState == .loading)
                }
            }
            
            VideoImagePicker(
                selection: $imageImporter.mediaSelection,
                image: image
            )
            .scaledToFill()
            .frame(width: 375, height: 560)
            
            HStack {
                Text("Title")
                    .font(.headline)
                Divider()
                TextField("Title", text: $video.title)
                    .focused($textFieldIsFocused)
            }
        }
        .scrollBounceBehavior(.basedOnSize)
        .onReceive(imageImporter.$importedMedia) { output in
            switch output {
            case let .image(uiImage, path):
                video.imageURL = path
                image = Image(uiImage: uiImage)
            case .video, .empty:
                if let uiImage = UIImage(contentsOfFile: video.imageURL?.path() ?? "") {
                    image = Image(uiImage: uiImage)
                }
            }
        }
    }
}

struct EditVideoView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            EditVideoView(video: Mockups.videoModels[0], onSave: { _ in })
                .environmentObject(MediaImportManager(mediaImporter: AppServices.createImageImporter()))
        }
    }
}
