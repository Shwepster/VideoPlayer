//
//  EditVideoImagePicker.swift
//  VideoPlayer
//
//  Created by Maxim Vynnyk on 16.04.2023.
//

import SwiftUI
import PhotosUI
import CustomViews

struct EditVideoImagePicker: View {
    @Binding var selection: PhotosPickerItem?
    let image: Image?
    
    var body: some View {
        ImageView(image: image)
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
        EditVideoImagePicker(selection: .constant(nil), image: PreviewHelper.image)
    }
}
