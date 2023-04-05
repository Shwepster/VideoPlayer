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
        
        selection.loadTransferable(type: VideoModel.self) { [weak self] result in
            guard let self, selection == self.videoSelection else { return }
            
            switch result {
            case .success(let videoModel?):
                let thumbnailName = "\(videoModel.id)_thumbnail"
                
                videoModel.asset.generateThumbnail { image in
                    let thumbnailURL = try? image?.pngData()?.saveToTempFile(name: thumbnailName, format: "png")
                    videoModel.imageURL = thumbnailURL
                    
                    // TODO: Save viewModel to DB
                    
                    self.state.send(.loaded(videoModel))
                }
            case .success(nil):
                self.state.send(.empty)
            case .failure:
                self.state.send(.fail)
            }
        }
    }
}

// MARK: - State

extension VideoImporter {
    enum State {
        case loading
        case fail
        case empty
        case loaded(VideoModel)
    }
}
