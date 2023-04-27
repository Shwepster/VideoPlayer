//
//  PreviewHelper.swift
//  VideoPlayer
//
//  Created by Maxim Vynnyk on 08.04.2023.
//

import Foundation
import AVKit
import SwiftUI
import Model

public struct PreviewHelper {
    static var current: Bundle {
        Bundle(identifier: "max.PreviewKit")!
    }
    
    public static let videoModels: [VideoModel] = [
        .init(
            id: "23",
            title: "test 1",
            videoURL: current.url(forResource: "video",
                                      withExtension: "MOV")!,
            imageURL: current.url(forResource: "kp2",
                                      withExtension: "jpg")!
        ),
        
        .init(
            id: "24",
            title: "test 2",
            videoURL: current.url(forResource: "test_video",
                                      withExtension: "MOV")!
        ),
        
        .init(
            id: "4",
            title: "test 2",
            videoURL: current.url(forResource: "test_video",
                                      withExtension: "MOV")!
        ),
        
        .init(
            id: "2",
            title: "test 2",
            videoURL: current.url(forResource: "test_video",
                                      withExtension: "MOV")!
        )
    ]
    
    public static let player: AVPlayer = {
        let asset = videoModels[1].asset
        let playerItem = AVPlayerItem(asset: asset)
        return AVPlayer(playerItem: playerItem)
    }()
    
    public static let engine: VideoPlayerEngine = .init(asset: videoModels[0].asset)
    
    public static let image = Image("kp")
}
