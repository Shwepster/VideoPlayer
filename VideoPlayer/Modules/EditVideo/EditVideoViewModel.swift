//
//  EditVideoViewModel.swift
//  VideoPlayer
//
//  Created by Maxim Vynnyk on 16.04.2023.
//

import Foundation
import UIKit
import PhotosUI
import SwiftUI

extension EditVideoView {
    @MainActor class ViewModel: ObservableObject {
        @Published var imageLoadingState: ImportState = .idle
        @Published var title: String
        @Published var thumbnail: Image?
        @Published var imageSelection: PhotosPickerItem? {
            didSet {
                if let imageSelection {
                    loadImage(from: imageSelection)
                } else {
                    imageLoadingState = .idle
                }
            }
        }
        
        private let storageService: StorageService
        private let mediaImporter: MediaImporterProtocol
        private let video: VideoModel
        private var thumbnailURL: URL?
        
        init(video: VideoModel, storageService: StorageService = .shared, mediaImporter: MediaImporterProtocol) {
            self.video = video
            self.storageService = storageService
            self.mediaImporter = mediaImporter
            self.title = video.title
            self.thumbnailURL = video.imageURL
            
            Task {
                thumbnail = await ViewImageFetcher.makeImage(from: video.imageURL)
            }
        }
        
        func save() {
            let updatedVideo = VideoModel(
                id: video.id,
                title: title,
                videoURL: video.videoURL,
                imageURL: thumbnailURL
            )
            
            storageService.saveVideo(updatedVideo)
        }
        
        private func loadImage(from selection: PhotosPickerItem) {
            imageLoadingState = .loading
            
            Task { @MainActor in
                let (image, url) = await mediaImporter.loadImage(from: selection)
                
                guard let image, let url else {
                    imageLoadingState = .error
                    return
                }
                
                thumbnail = Image(uiImage: image)
                thumbnailURL = url
                imageLoadingState = .idle
            }
        }
    }
}

// MARK: - ImportState

extension EditVideoView.ViewModel {
    enum ImportState {
        case loading
        case idle
        case error
    }
}
