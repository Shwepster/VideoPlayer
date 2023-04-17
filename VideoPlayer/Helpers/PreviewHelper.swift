//
//  PreviewHelper.swift
//  VideoPlayer
//
//  Created by Maxim Vynnyk on 08.04.2023.
//

import Foundation
import AVKit
import SwiftUI

struct PreviewHelper {
    static let videoModels: [VideoModel] = [
        .init(
            id: "23",
            title: "test 1",
            videoURL: Bundle.main.url(forResource: "video",
                                      withExtension: "MOV")!,
            imageURL: Bundle.main.url(forResource: "kp2",
                                      withExtension: "jpg")!
        ),
        
        .init(
            id: "24",
            title: "test 2",
            videoURL: Bundle.main.url(forResource: "test_video",
                                      withExtension: "MOV")!
        ),
        
        .init(
            id: "4",
            title: "test 2",
            videoURL: Bundle.main.url(forResource: "test_video",
                                      withExtension: "MOV")!
        ),
        
        .init(
            id: "2",
            title: "test 2",
            videoURL: Bundle.main.url(forResource: "test_video",
                                      withExtension: "MOV")!
        )
    ]
    
    static let player: AVPlayer = {
        let asset = videoModels[1].asset
        let playerItem = AVPlayerItem(asset: asset)
        return AVPlayer(playerItem: playerItem)
    }()
    
    static let image = Image("kp")
}
