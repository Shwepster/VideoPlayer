//
//  VideoPicker.swift
//  VideoPlayer
//
//  Created by Maxim Vynnyk on 04.04.2023.
//

import SwiftUI
import PhotosUI

public struct VideoPicker: View {
    @Binding var videoSelection: [PhotosPickerItem]
    
    public init(videoSelection: Binding<[PhotosPickerItem]>) {
        _videoSelection = videoSelection
    }
        
    public var body: some View {
        PhotosPicker(
            selection: $videoSelection,
            maxSelectionCount: 4,
            matching: .videos
        ) {
            HStack {
                Text("Import").bold()
                Spacer()
                Image(systemName: "plus.circle")
            }
        }
    }
}

struct VideoPicker_Previews: PreviewProvider {
    static var previews: some View {
        VideoPicker(videoSelection: .constant([]))
    }
}
