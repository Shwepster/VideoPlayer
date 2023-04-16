//
//  EditVideoView.swift
//  VideoPlayer
//
//  Created by Maxim Vynnyk on 16.04.2023.
//

import SwiftUI
import PhotosUI

struct EditVideoView: View {
    @StateObject var viewModel: ViewModel
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Form {
                VideoItemImageView(uiImage: viewModel.thumbnail)
                    .aspectRatio(1, contentMode: .fit)
                    .clipped()
                    .listRowInsets(.init())
                    .overlay {
                        PhotosPicker(
                            selection: $viewModel.imageSelection,
                            matching: .images
                        ) {
                            Color.black.opacity(0.15)
                            Image(systemName: "camera.circle.fill")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .tint(.white)
                                .shadow(radius: 8)
                        }
                    }
                
                HStack {
                    Text("Title")
                        .font(.headline)
                    Divider()
                    TextField("Title", text: $viewModel.title)
                }
            }
            .scrollBounceBehavior(.basedOnSize)
            
            Button {
                viewModel.save()
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
    static var viewModel: EditVideoView.ViewModel = .init(
        video: PreviewHelper.videoModels[0],
        mediaImporter: .init()
    )
    
    static var previews: some View {
        NavigationStack {
            EditVideoView(viewModel: viewModel)
        }
    }
}
