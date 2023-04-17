//
//  MediaImporter.swift
//  VideoPlayer
//
//  Created by Maxim Vynnyk on 04.04.2023.
//

import PhotosUI
import SwiftUI
import Combine
import AVKit

protocol MediaImporterProtocol {
    var state: CurrentValueSubject<MediaImporterState, Never> { get }
    func loadVideo(from selection: PhotosPickerItem) async -> VideoModel?
    func loadImage(from selection: PhotosPickerItem) async -> (UIImage?, URL?)
}

// MARK: - State

enum MediaImporterState {
    case loading
    case loaded
    case fail
    case empty
}

final class MediaImporter: MediaImporterProtocol {
    var state: CurrentValueSubject<MediaImporterState, Never> = .init(.empty)
    private var mediaSelection: PhotosPickerItem?
    private let previewGenerator: PreviewGenerator
    private let storageService: StorageService
    
    init(previewGenerator: PreviewGenerator = .shared, storageService: StorageService = .shared) {
        self.previewGenerator = previewGenerator
        self.storageService = storageService
    }
    
    func loadVideo(from selection: PhotosPickerItem) async -> VideoModel? {
        mediaSelection = selection
        state.send(.loading)
        let videoModel = try? await selection.loadTransferable(type: VideoModel.self)
        
        guard let videoModel else {
            state.send(.fail)
            return nil
        }
                
        // TODO: Make generation async and don't wait for it to return video
        let thumbnailURL = await previewGenerator.generatePreview(for: videoModel)
        videoModel.imageURL = thumbnailURL
        NSLog("Thumbnail: \(thumbnailURL?.path() ?? "")")
        
        storageService.saveVideo(videoModel)
        state.send(.loaded)
        return videoModel
    }
    
    func loadImage(from selection: PhotosPickerItem) async -> (UIImage?, URL?) {
        mediaSelection = selection
        state.send(.loading)
        do {
            let imageData = try await selection.loadTransferable(type: Data.self)
            
            guard let imageData, let image = UIImage(data: imageData) else {
                state.send(.fail)
                return (nil, nil)
            }
            
            let imageURL = try imageData.saveToStorageFile(format: "png")
            return (image, imageURL)
        } catch {
            state.send(.fail)
            return (nil, nil)
        }
    }
}
