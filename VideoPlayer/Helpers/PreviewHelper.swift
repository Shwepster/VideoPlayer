//
//  PreviewHelper.swift
//  VideoPlayer
//
//  Created by Maxim Vynnyk on 08.04.2023.
//

import Foundation
import AVKit

struct PreviewHelper {
    static let videoModels: [VideoModel] = [
        .init(
            id: "23",
            title: "test 1",
            videoURL: Bundle.main.url(forResource: "video",
                                      withExtension: "MOV")!
        ),
        
        .init(
            id: "24",
            title: "test 2",
            videoURL: Bundle.main.url(forResource: "test_video",
                                      withExtension: "MOV")!
        )
    ]
    
    static let player: AVPlayer = {
        let asset = videoModels[0].asset
        let playerItem = AVPlayerItem(asset: asset)
        return AVPlayer(playerItem: playerItem)
    }()
}
