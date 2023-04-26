//
//  VideoImagePicker.swift
//  CustomViews
//
//  Created by Maxim Vynnyk on 24.04.2023.
//

import SwiftUI
import PhotosUI

public struct VideoImagePicker: View {
    @Binding var selection: PhotosPickerItem?
    let image: Image?
    
    public init(selection: Binding<PhotosPickerItem?>, image: Image?) {
        _selection = selection
        self.image = image
    }
    
    public var body: some View {
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

struct Previews_VideoImagePicker_Previews: PreviewProvider {
    static var previews: some View {
        VideoImagePicker(selection: .constant(nil), image: nil)
    }
}
