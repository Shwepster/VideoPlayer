//
//  EditVideoView.swift
//  VideoPlayerMV
//
//  Created by Maxim Vynnyk on 24.04.2023.
//

import SwiftUI
import CustomViews
import Model

struct EditVideoView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var videoManager: VideoManager
    
    var video: VideoModel
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Form {
//                VideoImagePicker(
//                    selection: $viewModel.imageSelection,
//                    image: viewModel.thumbnail
//                )
                
                HStack {
                    Text("Title")
                        .font(.headline)
                    Divider()
                    TextField("Title", text: video.title)
                }
            }
            .scrollBounceBehavior(.basedOnSize)
            
            Button {
                videoManager.saveVideo(video)
                dismiss()
            } label: {
                Text("Save")
                    .padding(.vertical)
                    .padding(.horizontal, 100)
            }
            .foregroundColor(Color(uiColor: .systemBackground))
            .background(Color.accentColor)
            .clipShape(Capsule(style: .continuous))
        }
    }
}

struct EditVideoView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            EditVideoView(viewModel: viewModel)
        }
    }
}
