//
//  VideoImporter.swift
//  VideoPlayer
//
//  Created by Maxim Vynnyk on 04.04.2023.
//

import PhotosUI
import SwiftUI
import Combine
import AVKit

final class VideoImporter {
    var state: CurrentValueSubject<State, Never> = .init(.empty)
    private var videoSelection: PhotosPickerItem?
    
    func loadVideo(from selection: PhotosPickerItem) {
        videoSelection = selection
        state.send(.loading)
        
        selection.loadTransferable(type: Data.self) { [weak self] result in
            guard let self, selection == self.videoSelection else { return }
            
            switch result {
            case .success(let data?):
                let format = selection.supportedContentTypes.first?.preferredFilenameExtension
                
                guard let url = try? data.saveToTempFile(format: format) else {
                    self.state.send(.fail)
                    return
                }
                
                let asset = AVURLAsset(url: url)
                asset.generateThumbnail { image in
                    DispatchQueue.main.async {
                        guard let image else {
                            self.state.send(.fail)
                            return
                        }
                        
                        self.state.send(.loaded(Image(uiImage: image)))
                    }
                }
            case .success(nil):
                self.state.send(.empty)
            case .failure:
                self.state.send(.fail)
            }
            //            }
        }
    }
}

// MARK: - State

extension VideoImporter {
    enum State {
        case loading
        case fail
        case empty
        case loaded(Image)
    }
}
