//
//  PreviewGenerator.swift
//  VideoPlayer
//
//  Created by Maxim Vynnyk on 05.04.2023.
//

import AVKit

final class PreviewGenerator {
    static let shared = PreviewGenerator()
    private init() {}
    
    func generatePreview(for video: VideoModel) async -> URL? {
        let image = await video.asset.generateThumbnail()
        let thumbnailName = "\(video.id)_thumbnail"
        let thumbnailURL = try? image?.pngData()?.saveToTempFile(name: thumbnailName, format: "png")        
        return thumbnailURL
    }
}
