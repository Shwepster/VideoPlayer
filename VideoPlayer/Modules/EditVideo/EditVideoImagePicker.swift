//
//  EditVideoImagePicker.swift
//  VideoPlayer
//
//  Created by Maxim Vynnyk on 16.04.2023.
//

import SwiftUI
import PhotosUI

struct EditVideoImagePicker: View {
    @Binding var selection: PhotosPickerItem?
    let uiImage: UIImage?
    
    var body: some View {
        VideoItemImageView(uiImage: uiImage)
            .aspectRatio(1, contentMode: .fit)
            .clipped()
            .listRowInsets(.init())
            .overlay {
                PhotosPicker(
                    selection: $selection,
                    matching: .images
                ) {
                    ZStack {
                        Color.black.opacity(0.15)
                        Image(systemName: "camera.circle.fill")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .tint(.white)
                            .shadow(radius: 8)
                    }
                }
            }
    }
}

struct EditVideoImagePicker_Previews: PreviewProvider {
    static var previews: some View {
        EditVideoImagePicker(selection: .constant(nil), uiImage: PreviewHelper.image)
    }
}
