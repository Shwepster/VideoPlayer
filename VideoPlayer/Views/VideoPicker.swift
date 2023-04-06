//
//  VideoPicker.swift
//  VideoPlayer
//
//  Created by Maxim Vynnyk on 04.04.2023.
//

import SwiftUI
import PhotosUI

struct VideoPicker: View {
    @Binding var videoSelection: PhotosPickerItem?
        
    var body: some View {
        PhotosPicker(
            selection: $videoSelection,
            matching: .videos) {
                Label("Import", systemImage: "arrow.down.circle")
                    .bold()
        }
    }
}

struct VideoPicker_Previews: PreviewProvider {
    static var previews: some View {
        VideoPicker(videoSelection: .constant(nil))
    }
}
