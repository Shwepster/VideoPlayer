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
    private let previewGenerator: PreviewGenerator
    private let storageService: StorageService
    
    init(previewGenerator: PreviewGenerator = .shared, storageService: StorageService = .shared) {
        self.previewGenerator = previewGenerator
        self.storageService = storageService
    }
    
    func loadVideo(from selection: PhotosPickerItem) async {
        videoSelection = selection
        state.send(.loading)
        let videoModel = try? await selection.loadTransferable(type: VideoModel.self)
        
        guard let videoModel else {
            state.send(.fail)
            return
        }
                
        // TODO: Make generation async and dont wait for it to return video
        let thumbnailURL = await previewGenerator.generatePreview(for: videoModel)
        videoModel.imageURL = thumbnailURL
        NSLog("Thumbnail: \(thumbnailURL?.path() ?? "")")
        
        storageService.saveVideo(videoModel)
        
        NSLog("Saved to DB")
        state.send(.loaded(videoModel))
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
