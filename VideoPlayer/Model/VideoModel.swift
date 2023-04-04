//
//  VideoModel.swift
//  VideoPlayer
//
//  Created by Maxim Vynnyk on 05.04.2023.
//

import AVKit

final class VideoModel {
    let id: String
    let videoURL: URL
    let imageURL: URL
    
    var asset: AVURLAsset {
        .init(url: videoURL)
    }
   
    init(id: String, videoURL: URL, imageURL: URL) {
        self.id = id
        self.videoURL = videoURL
        self.imageURL = imageURL
    }
}
