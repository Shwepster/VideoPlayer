//
//  EditVideoView.swift
//  VideoPlayer
//
//  Created by Maxim Vynnyk on 16.04.2023.
//

import SwiftUI
import CustomViews
import Model
import PreviewKit

struct EditVideoView: View {
    @StateObject var viewModel: ViewModel
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Form {
                VideoImagePicker(
                    selection: $viewModel.imageSelection,
                    image: viewModel.thumbnail
                )
                
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
        mediaImporter: AppServices.createImageImporter()
    )
    
    static var previews: some View {
        NavigationStack {
            EditVideoView(viewModel: viewModel)
        }
    }
}
